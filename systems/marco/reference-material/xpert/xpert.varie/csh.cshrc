# @(#)cshrc 1.11 89/11/29 SMI
# ----------------------------------------------------------------------
# | .cshrc Xpert development public initialization file.               |
# | ALL RIGHTS RESERVED TO XPERT UNIX SYSTEMS LTD.                     |
# | R-E-A-D !!! this before ADDING anything !!!                        |
# |                                                                    |
# | The file is devided into 2 parts:                                  |
# | 1.1: Global settings including all Environment settings (setenv)   |
# |    The first part is executed only if it hasn't been executed by   |
# |    the parent csh. i.e.: when logging in at the console or when    |
# |    logging onto another computer. This part will be run on all     |
# |    architectures                                                   |
# |                                                                    |
# | 1.2: Same as 1.1 except for being architecture dependent ($PATH)   |
# |                                                                    |
# | 2.1: Interactive part executed every time a csh is run             |
# |    Contains things like "set ...", "stty ..." and "alias ..."      |
# |    This part will be run on all architectures                      |
# |                                                                    |
# | 2.2: Same as 2.1 except for being architecture dependent           |
# ----------------------------------------------------------------------
#
# **********************************************************************
# **********************************************************************
#
# ----------------------------------------------------------------------
# | Some Settings, need only be done Once (no need to do it in each    |
# | new window) This includes environment variables, paths etc.        |
# ----------------------------------------------------------------------

if ( -d /usr/ucb ) set path = ($path /usr/ucb) #solaris sucks
setenv whoami	`whoami` # there's no way to get over this on hp
set home = ~$whoami
umask 022		#Yahel - 6-7-95
if ( $?arch ) then
	if ( $arch != hp ) then
		goto SKIP_INITIALIZATIONS
	endif
endif

#
# **********************************************************************
# **********************************************************************
#


# ----------------------------------------------------------------------
# | Very important environment (global) variables                      |
# ----------------------------------------------------------------------
setenv hostname		`hostname`
set uname = (`uname -a`)
switch ($uname[1])
case SunOS:
	if ( $uname[3]:r == 5 ) then
		setenv arch	solaris
	else
		setenv arch	sun4
	endif
	breaksw
case ULTRIX:
	setenv arch	dec
	breaksw
case IRIX:
	if ($#uname == 5) then
		setenv arch	sgi
	else
		setenv arch	indy
	endif
	breaksw
case HP-UX:
	setenv arch	hp
	breaksw
case AIX:
	setenv arch	ibm
	breaksw
case Linux:
	setenv arch	linux
	breaksw
case OSF1:
	setenv arch	osf1
	breaksw
endsw


# ----------------------------------------------------------------------
# General Purpose Environment Variables                                |
# ----------------------------------------------------------------------
setenv MORE		'-l'
#setenv EDITOR		lemacs
setenv NNTPSERVER	wisipc.weizmann.ac.il
setenv ORGANIZATION 	"Unix Xpert Systems LTD"
setenv TAPE		/dev/rst0
#setenv EMACSLOADPATH	"/usr/local/lemacs/lisp"




# ----------------------------------------------------------------------
# | Architecture dependent settings (This part is run once only)       |
# ----------------------------------------------------------------------
switch ($arch)
case sun4:
	setenv OPENWINHOME	/usr/openwin
	set path = (	$OPENWINHOME/{bin,demo}/{,/xview}	\
			/usr/demo/{SOUND,CDROM}				\
			/bin /usr/{ucb,bin,5bin,lib,etc,games,lang} /etc \
			. )
	setenv LD_LIBRARY_PATH	/usr/lib:/usr/lib/X11:$OPENWINHOME/lib
#	setenv XSUNBELLFILE	/usr/demo/SOUND/sounds/clink.au
#	setenv UIDPATH		/home/Motif/lib/X11/uid/%U.uid
	setenv MANPATH		$OPENWINHOME/man:/usr/lang/man
	setenv XNLSPATH		/usr/openwin/lib/nls
#	setenv FMHOME /home/FrameMaker
breaksw
case hp:
	set path = (/bin /usr/bin /usr/contrib/bin /etc /usr/bin/X11 .)
	setenv UIDPATH
	setenv MANPATH
	setenv TZ GMT-2
breaksw
case linux:
	set path = (/usr/bin/X11 /bin /usr/bin /sbin /usr/sbin .)
	setenv UIDPATH
	setenv MANPATH /usr/man/preformat
	#setenv TZ GMT+3
breaksw
case dec:
set path = ( /usr/ucb /bin /usr/bin /etc /etc/sec /usr/etc /usr/etc/sec /usr/local/bin /usr/bin/X11 .)
	setenv UIDPATH	/usr/lib/X11/uid/%U%S:/usr/lib/X11/uid/%U.uid
	setenv MANPATH

	setenv TZ GMT-2  #do whatever is needed so that the time will look
                         #ok while TZ is GMT-2 , this is the only way to sync
                         #the sun and the ultrix
	limit core 0
breaksw
case ibm:
	set path = (/bin /usr/bin /usr/ucb /etc /usr/etc /usr/etc/install \
		/usr/bin/X11 .)
	setenv UIDPATH
	setenv MANPATH
	setenv TZ GMT-2
	setenv EMACSLOADPATH ${EMACSLOADPATH}:/home/src/lemacs/lisp:`echo /home/src/lemacs/lisp/*/ | tr ' ' ':'`
	limit core 0
breaksw
case sgi:
	set path = (/usr/sbin /usr/bsd /usr/bin /bin /etc /usr/etc /usr/bin/X11 .)
	setenv UIDPATH
	setenv MANPATH
breaksw
case osf1:
	set path = (/sbin /usr/sbin /usr/bin /usr/bin/X11)
	setenv UIDPATH
	setenv MANPATH
breaksw
case indy:
	set path = (/usr/sbin /usr/bsd /sbin /usr/bin /bin /etc /usr/etc /usr/bin/X11 .)
	setenv UIDPATH
	setenv MANPATH /usr/share/catman
	setenv TZ GMT-3

breaksw
case solaris:
	set path = (/usr/sbin /usr/bin /usr/etc /opt/SUNWmotif/bin /usr/openwin/bin /opt/SUNWspro/bin /home/local/sun4/bin /usr/ccs/lib /usr/ccs/bin /usr/ucb)
	setenv UIDPATH /opt/SUNWmotif/lib/uid/%.uid
	setenv MANPATH /usr/man
	setenv LD_LIBRARY_PATH /opt/SUNWmotif/lib:/opt/SUNWspro/lib:/usr/openwin/lib:/usr/lib
endsw


# ----------------------------------------------------------------------
# | Common paths for all architectures                                 |
# ----------------------------------------------------------------------
set path = (/usr/local/bin /usr/local/scripts $path)
setenv MANPATH		/usr/local/man:/usr/man:/usr/local/man:$MANPATH

#
# **********************************************************************
# **********************************************************************
#
SKIP_INITIALIZATIONS:
# ----------------------------------------------------------------------
# | Following Initializations are for an Interactive Shell session Only|
# ----------------------------------------------------------------------
if ( ! $?prompt ) goto SKIP_INTERACTIVE
#
# **********************************************************************
# **********************************************************************


#
# ----------------------------------------------------------------------
# | A L I A S E S  for everyone                                        |
# ----------------------------------------------------------------------
alias +		more
alias -		less
alias backup_list	gtar -b 126 -tv -z -f /dev/rmt/c201d5cb "\!*"
alias backup_get	gtar -b 126 -xv -z -f /dev/rmt/c201d5cb "\!*"
alias cd	'chdir \!* ; reprompt'
alias chdir	'chdir \!* ; reprompt'
alias di	'll | +'
alias enscript "nenscript -TUS -fCourier7 -G -2 -p- -r \!* | rsh dec-2 lpr -Plw"
alias enscript1 "nenscript -TUS  -G -p- \!* | rsh dec-2 lpr -Plw"
alias enscript2 "nenscript -TUS  -G -p- \!* | rsh sun4-4 lpr -Plw2"
alias enscrman 'man \!* | a2ps -nP -m -H\"\!*\" -nu | sed -e s/11\.64/10\.5/ -e s/1\.4/0\.5/ | rsh dec-2 lpr -Plw'
alias enscrinfo 'cat \!* | sed /\\\\input texinfo/d | texi2roff -i -ms | a2ps -nP -m -H\"\!*\" -nu | sed -e s/11\.64/10\.5/ -e s/1\.4/0\.5/'
alias h		history
alias hh	history
alias ho	hostname
alias home	cd
#alias ls	'ls -CFo'
alias ls	'ls -CF'
alias me	whoami
alias pd	pushd
alias popd	'popd  \!* ; reprompt'
alias pp	popd
alias print	lpr -Plp
alias pushd	'pushd \!* ; reprompt'
alias rcs-get	'co -r'
alias rcs-save	'ci -u'
alias rcs-edit	'co -l'
alias reprompt	'set prompt = "[${whoami}@${hostname}]`echo $cwd | sed -e s\;/home/users/\;\~\;`>"'
alias rm	rm -i
alias up	cd ..
reprompt

if ($whoami == root) then
	alias edit '(co -l \!* ; \vi \!* ;ci -u \!*)'
	alias vi echo 'As root use "edit" instead.'
	alias emacs vi
	alias ed vi
endif
#if ("`msgs -q`" != "") msgs	# display public messages

# ----------------------------------------------------------------------
# | Interactive Csh (system) settings and architecture specific.       |
# ----------------------------------------------------------------------
set history = 500	#remember 500 last commands
set ignoreeof		#ignore end of file (^D).. use "exit" instead
switch ($arch)
case sun4:
	stty		sane dec erase "" erase ""
	if ($whoami != root) then
		unlimit	cputime \
			filesize \
			datasize \
			stacksize \
			descriptors \
		#	memoryuse
	endif
	alias talk ntalk
	limit		core 0
	alias ll	/bin/ls -lg
	#this was changed by Yahel 6-7-95
	umask 022
	set term=`tset -`
	if ($term == "unknown") then
	    echo "terminal type set to vt100"
	    set term=vt100
	endif
	if ($term == "") then
	    echo "terminal type set to vt100"
	    set term=vt100
	endif
	if ($term == "network") then
	    echo "terminal type set to vt100"
	    set term=vt100
	endif
	alias sz "sz -e -l 512"
	alias rz "rz -e -l 512"
breaksw
case hp:
	stty erase  intr  kill  start  stop  dsusp  susp 
	alias df bdf
	set whoami = `whoami`	# the usual method dosnt work
	setenv HOME ~$whoami	#  "   "  ...
	cd .
	eval `resize`
breaksw
case dec:
	alias ll /bin/ls -lg
breaksw
case ibm:
	alias ll /bin/ls -l
	stty sane
breaksw
case sgi:
	alias ll /bin/ls -l
	limit core 0
	stty dec
breaksw
case osf1:
	alias ll /bin/ls -l
	limit core 0
	stty dec
breaksw
case indy:
	alias ll /bin/ls -l
	alias df df -k
	limit core 0
	stty dec
breaksw
case solaris:
	alias ll /bin/ls -l
	alias df df -k
	limit core 0
	if ($whoami != root) then
		unlimit datasize stacksize vmemoryuse descriptors cputime filesize
	endif
endsw

#
# **********************************************************************
# **********************************************************************
#
SKIP_INTERACTIVE:

#
# $Id: csh.cshrc,v 1.1 1995/11/23 16:29:26 limor Exp $
# $Log: csh.cshrc,v $
# Revision 1.1  1995/11/23  16:29:26  limor
# Initial revision
#
# Revision 1.16  1995/01/22  02:41:55  limor
# /usr/lib/X11 added to LD_LIBRARY_PATH
#
# Revision 1.16  1995/01/22  02:41:55  limor
# /usr/lib/X11 added to LD_LIBRARY_PATH
#
# Revision 1.15  1995/01/18  13:49:25  wags
# added -e for rz/sz
#
# Revision 1.14  1995/01/10  22:27:55  limor
# added XNLSPATH /usr/openwin/lib/nls
#
# Revision 1.13  1995/01/10  22:13:57  limor
# changed the tset -Q -
# to tset -
# (to avoid it clearing the screen)
#
# Revision 1.12  1994/12/26  07:13:28  wags
# added rz
#
# Revision 1.11  1994/12/23  22:13:10  wags
# added alias sz -> sz -l 512 because larger packets don't work (wags)
#
# Revision 1.10  1994/12/21  23:55:57  wags
# added terminal network
#
# Revision 1.9  1994/12/21  11:38:22  root
# Added a forgotten "endif"
#
# Revision 1.8  1994/12/21  11:26:43  wags
# fix again vt100
#
# Revision 1.7  1994/12/21  11:24:06  wags
# fix vt100
#
# Revision 1.6  1994/12/21  11:19:46  wags
# added dev-vt**
#
# Revision 1.5  1994/12/19  12:47:29  wags
# added tset -Q -
#
# Revision 1.4  1994/12/19  09:36:58  root
# removing term setting to vt100
#
# Revision 1.3  1994/12/19  08:08:30  wags
# add set term vt100 for mofet users
#
# Revision 1.2  1994/12/07  16:57:27  root
# Changed the organization and nntp server
# (yuval)
#
# Revision 1.1  1994/11/22  18:25:21  root
# Initial revision
#
# Revision 1.6  1994/10/25  17:28:43  root
# editor change
#
# Revision 1.6  1994/10/25  17:28:43  root
# editor change
#
# Revision 1.5  1994/10/25  11:48:58  limor
# *** empty log message ***
#
# Revision 1.2  1994/10/25  09:47:59  limor
# *** empty log message ***
#
# Revision 1.87  1994/06/07  16:48:34  oleg
# without doc_jeremy & + postmig
#
# Revision 1.86  1994/05/04  14:00:36  root
# moved the /usr/ucb dir to the end of the path
# in case of solaris. may just cause the compilers to work
#
# Revision 1.85  1994/04/21  11:24:53  ofra
# umask 002 moved to beginning
#
# Revision 1.84  1994/04/18  13:35:14  limor
# changed the TZ for the new indy to be synched with
# the suns seems to need GMT-3
#
# Revision 1.83  1994/04/10  18:41:05  limor
# fucking solaris - ypcat hosts
# outputs each line twice for some obscure reason
#
# Revision 1.82  1994/04/10  12:36:24  limor
# added solaris stuff
#
# Revision 1.81  1994/03/16  10:05:36  limor
# frame maker additions
#
# Revision 1.80  1994/03/06  14:37:58  limor
# changed the enscrman alias to fix the page size
#
# Revision 1.79  1994/02/16  18:30:17  limor
# enscript2 added
#
# Revision 1.78  1994/01/09  16:44:38  limor
# bugfix Vers_develop_ninjas
#
# Revision 1.77  1994/01/09  16:40:01  limor
# with vers_develop_ninjas
#
# Revision 1.76  1994/01/09  11:56:15  limor
# ghostview alias on sun (motif ldpath)
#
# Revision 1.75  1994/01/06  19:52:18  limor
# using ~customer_patch instead of automounter
#
# Revision 1.74  1994/01/06  19:12:09  limor
# set basic path for sgi and indy
#
# Revision 1.73  1994/01/06  19:06:56  limor
# fixed env bug with ninjas and customer env
#
# Revision 1.72  1994/01/06  17:55:21  limor
# additions concerning ninjas env
#
# Revision 1.71  1993/12/29  21:50:31  limor
# indy arch support
#
# Revision 1.70  1993/12/09  19:01:33  limor
# saving before major revision
#
# Revision 1.69  1993/12/07  20:12:47  limor
# want to add the vers4_2 stuff
#
# Revision 1.68  1993/11/22  21:18:03  limor
# changed the mkdir GS shit not to work with root
#
# Revision 1.67  1993/11/07  09:41:41  limor
# *** empty log message ***
#
# Revision 1.66  1993/10/26  16:08:33  limor
# addition of excrman (enscript man..)
#
# Revision 1.65  1993/10/14  15:59:58  udi
# env var gt_print canceled
#
# Revision 1.64  1993/10/11  18:17:05  limor
# change in the enscript1 font def.
#
# Revision 1.63  1993/07/29  16:48:57  alex
# new alias for clean. Now:
# alias clean 'source $pro_e/admin/clean'.
#
# Revision 1.62  1993/07/19  09:19:17  ofra
# ibm EMACSLOADPATH (after ibm lemacs instalation)
#
# Revision 1.61  1993/06/29  13:04:21  limor
# mkdir -p on sgi caused shit
#
# Revision 1.60  1993/06/09  13:24:39  limor
# multi gd session for the same user
#
# Revision 1.59  1993/06/08  22:25:23  limor
# again prompt problem when root.. solved
#
# Revision 1.58  1993/06/08  22:23:54  limor
# prompt problem when su ing solved
#
# Revision 1.57  1993/06/08  14:05:16  ofra
# vi problem on hp xterm . useing eval `resize` to solve
#
# Revision 1.56  1993/06/03  15:12:28  ishay
# added gt_tape_host definition
#
# Revision 1.55  1993/05/23  08:11:43  limor
# katavim can use cpus other then dec-2
#
# Revision 1.54  1993/05/16  07:57:06  limor
# added some katavim techniim functionality
#
# Revision 1.53  1993/05/04  13:37:43  limor
# setenv MANPATH had 2 arguments
#
# Revision 1.52  1993/05/04  13:23:10  limor
# added /home/src/fileutils stuff to path and manpath
#
# Revision 1.51  1993/05/04  12:43:30  ofra
# alias to newcc which changes the path in order to work with new gcc
#
# Revision 1.50  1993/04/20  11:31:41  limor
# doc team needs were given some variables
#
# Revision 1.49  1993/04/14  11:06:01  limor
# decwrite needed /usr/lib/X11/uid/%U%S in the UIDPATH
#
# Revision 1.48  1993/03/25  17:27:02  zvi
# dont source GT-site-init any more!!!
#
# Revision 1.47  1993/03/24  14:27:05  yossi
# fixed uilm for IBM
#
# Revision 1.46  1993/03/24  14:20:46  yossi
# *** empty log message ***
#
# Revision 1.45  1993/03/24  14:19:26  yossi
# *** empty log message ***
#
# Revision 1.44  1993/03/24  10:17:12  oleg
# *** empty log message ***
#
# Revision 1.43  1993/03/21  10:48:22  ofra
# /lib was moved in the global path to the end cause "rsh" didnt work on suns
#
# Revision 1.42  1993/03/18  07:47:52  limor
# added /lib to path of all arch
#
# Revision 1.41  1993/03/16  11:36:45  udi
# as  result of moving capture directory to the library area wcapt variable was c
# canceled
#
# Revision 1.40  1993/03/15  18:27:21  limor
# fixed ibm path
#
# Revision 1.39  1993/03/11  17:19:19  ishay
# added alias for rcs-get
#
# Revision 1.38  1993/03/10  17:25:17  limor
# TZ is GMT-2 on hp
#
# Revision 1.37  1993/03/10  16:13:35  yossi
# alias df bdf   <- hp
# uilm for hp and $whoami unfucked
#
# Revision 1.36  1993/03/08  17:40:12  limor
# UIDPATH remade with %U ($pro_d/..%U is in GT-site-init)
#
# Revision 1.35  1993/03/08  11:37:44  oleg
# UIDPATH
#
# Revision 1.34  1993/03/08  11:27:59  oleg
# path contains ~/project/product/$arch/exe
#
# Revision 1.33  1993/03/03  14:38:54  limor
# MANPATH includes /usr/lang/man too
#
# Revision 1.32  1993/03/01  14:52:44  alex
# ninjas default environment is now V4.1
#
# Revision 1.31  1993/02/24  15:45:33  oleg
# Added $wuil path to include paths of UIL.
#
# Revision 1.30  1993/02/24  15:43:46  zvi
# *** empty log message ***
#
# Revision 1.29  1993/02/21  18:45:59  limor
# XDISPLAY_TYPE needed fgrep $hostname" " with a tab otherwise sun4-4 and sun4-4-r conflict
#
# Revision 1.28  1993/02/21  13:24:43  project
# added ninja functions for 4.1 and XDISPLAY_TYPE stuff (from hosts)
#
# Revision 1.27  1993/02/21  13:13:30  limor
# ?
#
#

