@echo off
arj u virtual virtual.doc virtual.hpj r*.doc *.bmp i*.doc gergo.doc gergo_1.hpj -jm -p
arj u virtual he*.hpj he*.doc i*.hpj *.wri *.bat news.doc novita'.hpj -jm -p
arj u bitmap *.bmp -jm -p
hc31 virtual
hc31 internet
hc31 help
hc31 novita'
move virtual.hlp;internet.hlp;help.hlp;novita'.hlp d:\skitapo\internet
copy d:\skitapo\internet\virtual.hlp d:\marco\distribu\*.hl_
copy d:\skitapo\internet\internet.hlp d:\marco\distribu\*.hl_
copy d:\skitapo\internet\help.hlp d:\marco\distribu\*.hlp
copy d:\skitapo\internet\novita'.hlp d:\marco\distribu\*.hl_
rem copy d:\marco\sound.wav d:\marco\distribu\*.wa_
del *.ph
exit
