/*
 * Virtual IP interface module. 
 *
 * Credits where credits are due:
 *
 * John Ioannidis <ji@cs.columbia.edu> came up with the VIF concept,
 * and wrote most of this code.
 *
 * Chuck Smoko <csmoko@relay.nswc.navy.mil> added the IFF_LOOPBACK flag.
 * This causes the route to be installed as a host route directly, and
 * thus removes the need to delete an extraneous network route.
 *
 * Steinar Haug <steinar.haug@runit.sintef.no> ported it to HP-UX 9.0x,
 * and made the code loadable and unloadable on SunOS 4.1.x.
 *
 * The necessary magic to detach an interface is taken from ppp-2.1.2 
 * (the sunos/ppp_if.c file).
 *
 * HP-UX note: This code will almost certainly not work on interfaces
 * using checksum offload (eg. FDDI).
 * 
 */

#include <sys/types.h>
#include <sys/param.h>
#include <sys/systm.h>
#include <sys/mbuf.h>
#include <sys/socket.h>
#include <sys/errno.h>
#include <sys/ioctl.h>
#ifndef __hpux
#include <sys/syslog.h>
#endif /* __ hpux */

#include <net/if.h>
#include <net/netisr.h>
#include <net/route.h>

#include <netinet/in.h>
#include <netinet/in_systm.h>
#include <netinet/in_var.h>
#include <netinet/ip.h>
#include <netinet/in_pcb.h>

#ifdef sparc
#include <sys/conf.h>
#include <sun/vddrv.h>
#endif

#define	NVIF 4

typedef struct
{
	struct ifnet	vif_if;
	struct ifnet	*vif_sif;	/* slave interface */
	int		vif_flags;
} vif_softc_t;

#define VIFMTU  (1024+512)

vif_softc_t vif_softc[NVIF];

int vifs_inited = 0;

int vifoutput(), vififioctl();

vifattach()
{
	register int i;
	register struct ifnet *ifp;
	
	for (i=0; i<NVIF; i++)
	{
		ifp = &vif_softc[i].vif_if;
		ifp->if_name = "vif";
		ifp->if_unit = i;
		ifp->if_mtu = VIFMTU;
#ifdef	MULTICAST
		ifp->if_flags = IFF_LOOPBACK | IFF_NOARP | IFF_MULTICAST;
#else	MULTICAST
		ifp->if_flags = IFF_LOOPBACK | IFF_NOARP;
#endif	MULTICAST
		ifp->if_ioctl = vififioctl;
		ifp->if_output = vifoutput;
		if_attach(ifp);
	}
}

#ifdef DETACH
vifdetach()
{
	register int i, s;
	register struct ifnet *ifp;
	register struct ifnet **p;
	
	for (i=0; i<NVIF; i++)
	{
		ifp = &vif_softc[i].vif_if;

		/* remove interface from interface list */
		s = splimp();
		for (p = &ifnet; *p; p = &((*p)->if_next)) {
			if (*p == ifp) {
				*p = (*p)->if_next;

				/* mark it down and flush it's que */
				if_down(ifp);

				/* free any addresses hanging off the intf */
				if_release_addrs(ifp);

				(void)splx(s);
				break;
			}
		}
	}
}

static int	/* should be void */
if_release_addrs(ifp)
register struct ifnet *ifp;
{
	register struct in_ifaddr **addr;
	register struct ifaddr *ifa, *ifanxt;
	register int s;
 
	if_delete_route(ifp);
 
	for (addr = &in_ifaddr; *addr; ) {
		if ((*addr)->ia_ifp == ifp)
			*addr = (*addr)->ia_next;
		else
			addr = &((*addr)->ia_next);
	}
 
	/*
	 * Free all mbufs holding down this interface's address(es).
	 */
	for (ifa = ifp->if_addrlist; ifa; ifa = ifanxt) {
		ifanxt = ifa->ifa_next;
		m_free(dtom(ifa));
	}
	ifp->if_addrlist = 0;
}

/*
 * Delete routes to the specified interface.
 * Hacked from rtrequest().
 */
static int	/* should be void */
if_delete_route(ifp)
struct ifnet *ifp;
{
	extern int rttrash;		/* routes not in table but not freed */
	register struct mbuf **mprev, *m;
	register struct rtentry *route;
	register int i;
 
	/* search host rt tbl */
	for (i = 0; i < RTHASHSIZ; i++) {
		mprev = &rthost[i];
		while (m = *mprev) {
			route = mtod(m, struct rtentry *);
			if (route->rt_ifp == ifp) {
				*mprev = m->m_next;
				if (route->rt_refcnt > 0) {
					route->rt_flags &= ~RTF_UP;
					rttrash++;
					m->m_next = 0;
				} else
					m_free(m);
			} else
				mprev = &m->m_next;
		}
	}
 
	/* search net rt tbl */
	for (i = 0; i < RTHASHSIZ; i++) {
		mprev = &rtnet[i];
		while (m = *mprev) {
			route = mtod(m, struct rtentry *);
			if (route->rt_ifp == ifp) {
				*mprev = m->m_next;
				if (route->rt_refcnt > 0) {
					route->rt_flags &= ~RTF_UP;
					rttrash++;
					m->m_next = 0;
				} else
					m_free(m);
			} else
				mprev = &m->m_next;
		}
	}
} 
#endif /* DETACH */

vif_open(dev, flag)
int dev, flag;
{
	int unit;
	
	if (!vifs_inited)
	{
		vifattach();
		vifs_inited = 1;
	}
	
	unit = minor(dev);
	if ((unit < 0) || (unit >= NVIF))
		return ENXIO;
	
	return 0;
}

vif_close(dev, flag)
int dev, flag;
{
	return 0;
}

vif_read()
{
	return ENXIO;
}

vif_write()
{
	return ENXIO;
}

vif_select()
{
	return ENXIO;
}

vifoutput(ifp, m0, dst)
	struct ifnet *ifp;
	register struct mbuf *m0;
	struct sockaddr *dst;
{
	int s;
	register struct ifqueue *ifq;
	struct mbuf *m;
	struct sockaddr_in *din;
	
	if (dst->sa_family != AF_INET)
	{
#ifdef __hpux
		printf("%s%d: can't handle af%d\n", 
		    ifp->if_name, ifp->if_unit, dst->sa_family);
#else
		log(LOG_ERR, "%s%d: can't handle af%d\n", 
		    ifp->if_name, ifp->if_unit, dst->sa_family);
#endif /* __hpux */
		m_freem(m0);
		return (EAFNOSUPPORT);
	}

	din = (struct sockaddr_in *)dst;
	
	if (din->sin_addr.s_addr == IA_SIN(ifp->if_addrlist)->sin_addr.s_addr)
	{
		/*
		 * Place interface pointer before the data
		 * for the receiving protocol.
		 */
		if (m0->m_off <= MMAXOFF &&
		    m0->m_off >= MMINOFF + sizeof(struct ifnet *)) {
			m0->m_off -= sizeof(struct ifnet *);
			m0->m_len += sizeof(struct ifnet *);
		} else {
			MGET(m, M_DONTWAIT, MT_HEADER);
			if (m == (struct mbuf *)0)
			  return (ENOBUFS);
			m->m_off = MMINOFF;
			m->m_len = sizeof(struct ifnet *);
			m->m_next = m0;
			m0 = m;
		}
		*(mtod(m0, struct ifnet **)) = ifp;
		s = splimp();
		ifp->if_opackets++;
		ifq = &ipintrq;
		if (IF_QFULL(ifq)) {
			IF_DROP(ifq);
			m_freem(m0);
			splx(s);
			return (ENOBUFS);
		}
		IF_ENQUEUE(ifq, m0);
		schednetisr(NETISR_IP);
		ifp->if_ipackets++;
		splx(s);
		return (0);
	}

	return EHOSTUNREACH;
}

/*
 * Process an ioctl request.
 */
/* ARGSUSED */
vififioctl(ifp, cmd, data)
	register struct ifnet *ifp;
	int cmd;
	caddr_t data;
{
	int error = 0;

	switch (cmd) {

	case SIOCSIFADDR:
		ifp->if_flags |= IFF_UP;
		/*
		 * Everything else is done at a higher level.
		 */
		break;

#ifdef __hpux
	case SIOCSIFNETMASK:
		break;
#endif

	default:
		error = EINVAL;
	}
	return (error);
}

vif_ioctl(dev, cmd, arg, mode)
dev_t dev;
int cmd;
caddr_t arg;
int mode;
{
	int unit;
	
	unit = minor(dev);
	if ((unit < 0) || (unit >= NVIF))
		return ENXIO;
	
	return EINVAL;
}

#ifdef sparc
extern int nodev();

struct cdevsw vif_cdevsw = {
	vif_open,	vif_close,	vif_read,	vif_write,
	vif_ioctl,	nodev,		vif_select,	0,
	0,		0,
};

#ifdef sun4m
struct vdldrv vif_drv = {
	VDMAGIC_PSEUDO,
	"vif",
	NULL,
	NULL,
	&vif_cdevsw,
	0,
	0,
	NULL,
	NULL,
	NULL,
	0,
	0
};
#else /* sun4m */
struct vdldrv vif_drv = {
	VDMAGIC_PSEUDO,
	"vif",
#ifdef sun4c
	NULL,
#else
	NULL,
	NULL,
	NULL,
	0,
	0,
#endif
	NULL,
	&vif_cdevsw,
	0,
	0
};
#endif /* sun4m */

/* ARGSUSED */
xxxinit(cmd, vdp, vdi, vds)
int cmd;
struct vddrv *vdp;
struct vdioctl_load *vdi;
struct vdstat *vds;
{
	int status = 0;

	switch (cmd) {
	case VDLOAD:
		vdp->vdd_vdtab = (struct vdlinkage *) &vif_drv;
		break;
	case VDUNLOAD:
#ifdef DETACH
		vifdetach();
#endif /* DETACH */
		break;
	case VDSTAT:
		break;
	default:
		status = EINVAL;
		break;
	}
	return status;
}
#endif
