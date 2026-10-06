#!/bin/sh
#
# rc.M		This file is executed by init(8) when the system is being
#		initialized for one of the "multi user" run levels (i.e.
#		levels 1 through 6).  It usually does mounting of file
#		systems et al.
#
# Version:	@(#)/etc/rc.d/rc.M	2.02	02/26/93
#
# Author:	Fred N. van Kempen, <waltje@uwalt.nl.mugnet.org>
#		Heavily modified by Patrick Volkerding <volkerdi@ftp.cdrom.com>
#

  # Tell the viewers what's going to happen...
  echo "Going multiuser..."

  # Screen blanks after 15 minutes idle time.
  /bin/setterm -blank 15

  # Start crond (Dillon's crond):
  # If you want cron to actually log activity to /var/adm/cron, then change
  # -l10 to -l8 to increase the logging level.
  /usr/sbin/crond -l10 >>/var/adm/cron 2>&1

  # If there's no /etc/HOSTNAME, fall back on this default:
  if [ ! -r /etc/HOSTNAME ]; then
   echo "darkstar.frop.org" > /etc/HOSTNAME
  fi

  # Initialize the NET subsystem.
  if [ -x /etc/rc.d/rc.inet1 ];
  then
        /bin/hostname `cat /etc/HOSTNAME | cut -f1 -d .`
        /bin/sh /etc/rc.d/rc.inet1
        /bin/sh /etc/rc.d/rc.inet2
  else
        /sbin/hostname_notcp `cat /etc/HOSTNAME | cut -f1 -d .`
	/usr/sbin/syslogd
	/usr/sbin/klogd
	/usr/sbin/lpd
  fi

  # Remove stale locks (must be done after mount -a!)
  /bin/rm -f /var/spool/locks/* /var/spool/uucp/LCK..* /tmp/.X*lock 1> /dev/null 2> /dev/null

  # Remove stale hunt sockets so the game can start.
  if [ -r /tmp/hunt -o -r /tmp/hunt.stats ]; then
    echo "Removing your stale hunt sockets from /tmp..."
    /bin/rm -f /tmp/hunt*
  fi

  # Update all the shared library links automatically
  /sbin/ldconfig

  # Start the sendmail daemon:
  if [ -x /usr/sbin/sendmail ]; then
   echo "Starting sendmail daemon (/usr/sbin/sendmail -bd -q 15m)..."
   /usr/sbin/sendmail -bd -q 15m
  fi

  # Load a custom screen font if the user has an rc.font script.
  if [ -r /etc/rc.d/rc.font ]; then
    /etc/rc.d/rc.font
  fi

  # Start the local setup procedure.
  /etc/rc.d/rc.local

  # All done.
