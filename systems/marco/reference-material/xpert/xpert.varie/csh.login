#
# .cshrc should have set $arch, $hostname
#
# if $WindowManager exists, window manager question will not be asked



# Ask user what windowing system he/she/it wishes to start, if any.
# Also ask for its preferred window manager.

if (`tty` != /dev/console && `tty` != /dev/hft/0) goto END_OF_WINDOWS

echo '       Windows Initialization'
echo '-------------------------------------'
echo 'Choose :   [x]  - MIT X11R5          '
echo '           [x4] - MIT X11R4          '
echo '           [o]  - OpenWindows X11    '
echo '           [s]  - Sunview            '
echo '           [d]  - Dual Screen X11 (xnews server)   '
echo '           [m]  - Dual Screen X11 (MIT X11R5 server)   '
echo '           [r]  - Xrunner modified server (mercury)'
echo '           [n]  - No Windows         '
glob '    ==[x]=> '

set i = $<
if ( "$i" == o) then
	setenv WindowSystem openwin
	setenv LD_LIBRARY_PATH /usr/openwin/lib:/usr/local/lib:${LD_LIBRARY_PATH}

else if ("$i" == x4) then
	setenv WindowSystem startx
else if ("$i" == x || "$i" == "") then
	set path = (/usr/bin/X11 /usr/local/X11R5/bin $path)
	setenv LD_LIBRARY_PATH /usr/lib/X11:/usr/local/X11R5/lib:$LD_LIBRARY_PATH
	setenv WindowSystem "startx"
else if ("$i" == s) then
	setenv WindowSystem sunview
else if ("$i" == d) then
	setenv WindowSystem "openwin -noauth -dev /dev/cgthree0 -dev /dev/cgthree1"
	setenv DualHeadSystem
else if ("$i" == r) then
	setenv WindowSystem "xinit -- /home/local/sun4/xrunner/bin/MIXsun :0"
else if ("$i" == m) then
#	set path = (/home/X11R5/sun4/bin $path)
#	setenv LD_LIBRARY_PATH /home/X11R5/sun4/lib:$LD_LIBRARY_PATH
	setenv XDEVICE /dev/cgthree0:/dev/cgthree1
	setenv WindowSystem "xinit"
	setenv DualHeadSystem
else
	set WindowSystem = "echo"
	goto END_OF_WINDOWS
endif

	echo '         Window Manager Initialization             '
	echo '---------------------------------------------------'
	echo 'Choose :   [m]  - Motif Window Manager (mwm)       '
	echo '           [t]  - X11 Standard Window Manager (twm)'
	echo '           [o]  - OpenLook Window Manager (olwm)   '
	echo '           [v]  - OpenLook Virtual Window Manager (olvwm)   '
	echo '           [f]  - Fvwm Window Manager (fvwm)   '
	glob '    ==[m]=> '

	set i = $<
	if ($i == t) then
		setenv WindowManager twm
	else if ($i == f) then
		setenv LD_LIBRARY_PATH /usr/lib/X11/xpm:$LD_LIBRARY_PATH
		setenv WindowManager "fvwm"
	else if ($i == o) then
		setenv WindowManager "olwm -3"
	else if ($i == v) then
		setenv WindowManager "olvwm -3"
	else
		setenv WindowManager mwm
	endif
endif

if ( $arch == ibm) then
	setenv WindowSystem xinit
	setenv WindowManager mwm
endif

$WindowSystem

END_OF_WINDOWS:

#if (-x /usr/bin/quota) /usr/bin/quota
