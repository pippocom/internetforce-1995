DefInt A-Z
Declare Function GetWindowsDirectory Lib "Kernel" (ByVal Buff$, ByVal sizeBuf)

Function WinDir$ ()
 Buff$ = Space$(255)
 Tchars = GetWindowsDirectory(Buff$, 255)
 WinDir$ = Left$(Buff$, Tchars)
End Function
