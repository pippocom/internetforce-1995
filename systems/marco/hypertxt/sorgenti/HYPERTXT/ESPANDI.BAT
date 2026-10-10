@echo off
cls
echo     Script di espansione Hypertxt 1.30
echo             (utilizza PKUNZIP)
echo.
echo      premere un tasto per continuare...
pause > nul
md xzy
cd xzy
a:pkunzip a:hypertxt
win \xzy\installa
cd\
cls
echo    Sto per cancellare i files temporanei
echo      premere un tasto per continuare...
pause > nul
cd xzy
del *.*
cd \
rd xzy
echo.
echo Fatto. Buon divertimento!
echo.
