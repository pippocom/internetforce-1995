@echo off
hc31 virtual.dem
hc31 address
hc31 internet.dem
hc31 help
move d:\marco\virtual.hlp d:\marco\distribu\*.hl_
move d:\marco\address.hlp d:\marco\distribu\*.hl_
move d:\marco\internet.hlp d:\marco\distribu\*.hl_
move d:\marco\help.hlp d:\marco\distribu\*.hlp
copy d:\marco\sound.wav d:\marco\distribu\*.wa_
del *.ph
exit
