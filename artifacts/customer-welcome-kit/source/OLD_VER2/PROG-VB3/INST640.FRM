VERSION 2.00
Begin Form Form1 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Welcome kit setup"
   ClientHeight    =   3450
   ClientLeft      =   1005
   ClientTop       =   1710
   ClientWidth     =   7785
   ControlBox      =   0   'False
   FillColor       =   &H00FF0000&
   Height          =   3855
   Icon            =   INST640.FRX:0000
   Left            =   945
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   Picture         =   INST640.FRX:0302
   ScaleHeight     =   3450
   ScaleWidth      =   7785
   Top             =   1365
   Visible         =   0   'False
   Width           =   7905
   Begin DriveListBox Drive2 
      Height          =   315
      Left            =   5160
      TabIndex        =   13
      Top             =   1200
      Width           =   2295
   End
   Begin CommandButton Command3 
      Caption         =   "&Help"
      Height          =   375
      Left            =   1080
      TabIndex        =   8
      Top             =   2520
      Width           =   855
   End
   Begin FileListBox File1 
      ForeColor       =   &H00C0C0C0&
      Height          =   225
      Left            =   120
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   2040
      Visible         =   0   'False
      Width           =   735
   End
   Begin CommandButton Command2 
      Caption         =   "&Esci dal Setup"
      Height          =   375
      Left            =   5040
      TabIndex        =   4
      Top             =   2880
      Width           =   1455
   End
   Begin CommandButton Command1 
      Caption         =   "&Continua"
      Height          =   375
      Left            =   3480
      TabIndex        =   3
      Top             =   2880
      Width           =   975
   End
   Begin DriveListBox Drive1 
      Height          =   315
      Left            =   5160
      TabIndex        =   0
      Top             =   720
      Width           =   2295
   End
   Begin Label Label7 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Directory"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   3480
      TabIndex        =   14
      Top             =   1800
      Width           =   1215
   End
   Begin Label Label6 
      BackColor       =   &H00C0C0C0&
      Caption         =   "© 1995-96, M. Iannacone"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   3120
      Width           =   2655
   End
   Begin Label Label5 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Internet Force Welcome kit 1"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   13.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000080&
      Height          =   360
      Left            =   3480
      TabIndex        =   11
      Top             =   120
      Width           =   4035
   End
   Begin Label Label4 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Installa su:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   3480
      TabIndex        =   10
      Top             =   1200
      Width           =   1455
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Installa da:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   3480
      TabIndex        =   9
      Top             =   720
      Width           =   1575
   End
   Begin Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "C:\IFORCE"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   5160
      TabIndex        =   1
      Top             =   1800
      Width           =   1455
   End
   Begin Label Label1 
      Caption         =   "DDE"
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Top             =   2040
      Visible         =   0   'False
      Width           =   735
   End
   Begin Label Label9 
      Alignment       =   1  'Right Justify
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   6480
      TabIndex        =   6
      Top             =   2400
      Width           =   495
   End
   Begin Shape Shape3 
      BackColor       =   &H00FFFFFF&
      BorderColor     =   &H00FFFFFF&
      FillColor       =   &H0000FFFF&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   3120
      Top             =   2400
      Width           =   3135
   End
   Begin Shape Shape2 
      BackColor       =   &H00FFFFFF&
      BorderColor     =   &H00808080&
      BorderStyle     =   6  'Inside Solid
      FillColor       =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   3120
      Top             =   2400
      Width           =   3135
   End
   Begin Label Label10 
      Caption         =   "%"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   6960
      TabIndex        =   5
      Top             =   2400
      Width           =   255
   End
   Begin Shape Shape1 
      BackColor       =   &H00FFFFFF&
      BorderColor     =   &H00000000&
      BorderWidth     =   2
      FillColor       =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   6480
      Top             =   2400
      Width           =   735
   End
End

Sub Command1_Click ()
  dovewin = windir$()
  oggi = Date
  scade = CVDate("01/12/99")
  If oggi > scade Then
    mess1 = "Questa versione è scaduta."
    mess1 = mess1 & Chr(13) & "       Contattare Internet Force"
    esci = MsgBox(mess1, 16, "ATTENZIONE")
    End
  Else
   form1.Show
  End If
  Screen.MousePointer = 11
  Dim x
  stato_bar = 0
  stato_per = 0
  Shape3.Width = stato_bar
  Label9.Caption = stato_per
  Shape3.Visible = True
  Shape3.Refresh
  Label9.Refresh
  drivein = Left(drive1.Drive, 2)
  driveout = Left(drive2.Drive, 2)
  File1.Path = CurDir$(drive1)
  destpath = driveout + "\iforce"
  docdest$ = destpath + "\doc"
  If File1.ListCount = 0 Then End

  MkDir destpath
  MkDir docdest$

    Const OF_READ = 0
    Const OF_CREATE = &H1000
    Dim lpOfSrc As OFSTRUCT
    Dim lpOfDst As OFSTRUCT
    t% = LZStart()
    destfile$ = destpath + "\easy.hlp"
    startfile$ = drivein + "\installa.hlp"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
    
  'Posta
    destfile$ = destpath + "\eudora.exe"
    startfile$ = drivein + "\eudora\eudora.exe"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
    LZClose hfSrc%
    LZClose hfDst%
    
    destfile$ = destpath + "\eudora.hlp"
    startfile$ = drivein + "\eudora\eudora.hl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 3
      stato_per = 3
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    
    destfile$ = destpath + "\eudora.ini"
    startfile$ = drivein + "\eudora\eudora.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
    LZClose hfSrc%
    LZClose hfDst%

    'Leggimi posta
    docnow$ = docdest$ + "\eudora"
    MkDir docnow$

    destfile$ = docnow$ + "\readme.txt"
    startfile$ = drivein + "\eudora\readme.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
    LZClose hfSrc%
    LZClose hfDst%

  'Posta completo

  'finger
    destfile$ = destpath + "\mfinger.exe"
    startfile$ = drivein + "\finger\mfinger.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 4
      stato_per = 4
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    'Leggimi finger
    docnow$ = docdest$ + "\finger"
    MkDir docnow$

    destfile$ = docnow$ + "\readme.doc"
    startfile$ = drivein + "\finger\readme.do_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = docnow$ + "\readme.txt"
    startfile$ = drivein + "\finger\readme.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 5
      stato_per = 5
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
    
    destfile$ = docnow$ + "\readme.wri"
    startfile$ = drivein + "\finger\readme.wr_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 6
      stato_per = 6
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
    
  'finger completo
    
  'ftp
    destfile$ = destpath + "\complete.wav"
    startfile$ = drivein + "\ftp\complete.wa_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 7
      stato_per = 7
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\connect.wav"
    startfile$ = drivein + "\ftp\connect.wa_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 8
      stato_per = 8
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\error.wav"
    startfile$ = drivein + "\ftp\error.wa_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 9
      stato_per = 9
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\ws_ftp.ext"
    startfile$ = drivein + "\ftp\ws_ftp.et_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 10
      stato_per = 10
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\ws_ftp.exe"
    startfile$ = drivein + "\ftp\ws_ftp.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 11
      stato_per = 11
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
    
    destfile$ = destpath + "\ws_ftp.hlp"
    startfile$ = drivein + "\ftp\ws_ftp.hl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 12
      stato_per = 12
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\ws_ftp.ini"
    startfile$ = drivein + "\iforce\ws_ftp.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
    LZClose hfSrc%
    LZClose hfDst%

    'Leggimi ftp
    docnow$ = docdest$ + "\ftp"
    MkDir docnow$

    destfile$ = docnow$ + "\ws_ftp.txt"
    startfile$ = drivein + "\ftp\ws_ftp.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 52 * 13
      stato_per = 13
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
    
  'ftp completo

  'ping

    destfile$ = destpath + "\ws_ping.exe"
    startfile$ = drivein + "\ping\ws_ping.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 14
      stato_per = 14
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    'Leggimi ping
    docnow$ = docdest$ + "\ping"
    MkDir docnow$

    destfile$ = docnow$ + "\ws_ping.txt"
    startfile$ = drivein + "\ping\ws_ping.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 15
      stato_per = 15
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
    
  'ping completo

  'trumpet 2.0b

    destfile$ = destpath + "\bye.cmd"
    startfile$ = drivein + "\trump\bye.cm_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 16
      stato_per = 16
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\login.cmd"
    startfile$ = drivein + "\iforce\login.cm_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 85 * 17
      stato_per = 17
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\trumpwsk.ini"
    startfile$ = drivein + "\iforce\trumpwsk.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 18
      stato_per = 18
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\pingw.exe"
    startfile$ = drivein + "\trump\pingw.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 20
      stato_per = 20
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\sendreg.exe"
    startfile$ = drivein + "\trump\sendreg.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 21
      stato_per = 21
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\setup.cmd"
    startfile$ = drivein + "\trump\setup.cm_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 22
      stato_per = 22
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\tcpman.exe"
    startfile$ = drivein + "\trump\tcpman.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 23
      stato_per = 24
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\winsock.dll"
    startfile$ = drivein + "\trump\winsock.dl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 24
      stato_per = 26
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%


    'Leggimi trumpet
    docnow$ = docdest$ + "\trumpet"
    MkDir docnow$

    destfile$ = docnow$ + "\install.doc"
    startfile$ = drivein + "\trump\install.do_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 25
      stato_per = 29
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
    
    destfile$ = docnow$ + "\install.txt"
    startfile$ = drivein + "\trump\install.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 26
      stato_per = 30
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = docnow$ + "\readme.msg"
    startfile$ = drivein + "\trump\readme.ms_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
    LZClose hfSrc%
    LZClose hfDst%

  'trumpet completo

  'iforce
    destfile$ = destpath + "\easy.exe"
    startfile$ = drivein + "\iforce\easy.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 27
      stato_per = 31
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\threed.vbx"
    startfile$ = drivein + "\threed.vb_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 28
      stato_per = 33
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
  
  'iforce completo

  'cambio disco
   Screen.MousePointer = 0
   cambiodsk = MsgBox("Inserisci il disco 2", 49, "Setup")
   If cambiodsk = 2 Then    ' Evaluate response
      sicuro = MsgBox("Vuoi abbandonare l'installazione?", 20, "ATTENZIONE")
      If sicuro = 6 Then    ' Evaluate response
       LZDone
       Screen.MousePointer = 0
       Unload form1
      End If
   End If
   Screen.MousePointer = 11

  'News
    destfile$ = destpath + "\agent.exe"
    startfile$ = drivein + "\agent\agent.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 29
      stato_per = 35
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\agent.hlp"
    startfile$ = drivein + "\agent\agent.hl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 30
      stato_per = 36
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\ctl3dv2.dl_"
    startfile$ = drivein + "\agent\ctl3dv2.dl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 31
      stato_per = 38
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    'Leggimi agent
    docnow$ = docdest$ + "\agent"
    MkDir docnow$

    destfile$ = docnow$ + "\order.txt"
    startfile$ = drivein + "\agent\order.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = docnow$ + "\readme.txt"
    startfile$ = drivein + "\agent\readme.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 58 * 32
      stato_per = 39
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

  'News completo
  
  'Telnet

    destfile$ = destpath + "\news.rc"
    startfile$ = drivein + "\telnet\news.rc_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\passwd.exe"
    startfile$ = drivein + "\telnet\passwd.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\qvtdll.dll"
    startfile$ = drivein + "\telnet\qvtdll.dl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\qvtdll.sys"
    startfile$ = drivein + "\telnet\qvtdll.sy_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\qvtnet.ini"
    startfile$ = drivein + "\telnet\qvtnet.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\qvtnet16.exe"
    startfile$ = drivein + "\telnet\qvtnet16.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\qvtnet16.sys"
    startfile$ = drivein + "\telnet\qvtnet16.sy_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\termcap."
    startfile$ = drivein + "\telnet\termcap._"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\tnstart.exe"
    startfile$ = drivein + "\telnet\tnstart.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\vt220.fon"
    startfile$ = drivein + "\telnet\vt220.fo_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\vtfkeys.txt"
    startfile$ = drivein + "\telnet\vtfkeys.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\wnqvtnet.hlp"
    startfile$ = drivein + "\telnet\wnqvtnet.hl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    'Leggimi telnet
    docnow$ = docdest$ + "\telnet"
    MkDir docnow$

    destfile$ = docnow$ + "\readme16.wri"
    startfile$ = drivein + "\telnet\readme16.wr_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = docnow$ + "\relnotes.wri"
    startfile$ = drivein + "\telnet\relnotes.wr_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

  'telnet completo

   Screen.MousePointer = 0
   cambiodsk = MsgBox("Inserisci il disco 3", 49, "Setup")
   If cambiodsk = 2 Then    ' Evaluate response
      sicuro = MsgBox("Vuoi abbandonare l'installazione?", 20, "ATTENZIONE")
      If sicuro = 6 Then    ' Evaluate response
       LZDone
       Screen.MousePointer = 0
       Unload form1
      End If
   End If
   Screen.MousePointer = 11

  'Archie
    destfile$ = destpath + "\mfc250.dll"
    startfile$ = drivein + "\archie\mfc250.dl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\wsarchie.exe"
    startfile$ = drivein + "\archie\wsarchie.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\wsarchie.hlp"
    startfile$ = drivein + "\archie\wsarchie.hl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\wsarchie.ini"
    startfile$ = drivein + "\archie\wsarchie.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    'Leggimi archie
    docnow$ = docdest$ + "\archie"
    MkDir docnow$

    destfile$ = docnow$ + "\wsarch08.txt"
    startfile$ = drivein + "\archie\wsarch08.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

  'archie completo

  'Irc
    destfile$ = destpath + "\aliases.ini"
    startfile$ = drivein + "\irc\aliases.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\mirc.exe"
    startfile$ = drivein + "\irc\mirc.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\mirc.hlp"
    startfile$ = drivein + "\irc\mirc.hl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\mirc.ini"
    startfile$ = drivein + "\irc\mirc.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\popups.ini"
    startfile$ = drivein + "\irc\popups.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\remote.ini"
    startfile$ = drivein + "\irc\remote.in_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%


   'Leggimi irc
    docnow$ = docdest$ + "\irc"
    MkDir docnow$

    destfile$ = docnow$ + "\readme.txt"
    startfile$ = drivein + "\irc\readme.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = docnow$ + "\updat392.txt"
    startfile$ = drivein + "\irc\updat392.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = docnow$ + "\versions.txt"
    startfile$ = drivein + "\irc\versions.tx_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

  'irc completo

  'Talk
    destfile$ = destpath + "\bwcc.dll"
    startfile$ = drivein + "\talk\bwcc.dl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\ctl3d.dll"
    startfile$ = drivein + "\talk\ctl3d.dl_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\dingding.wav"
    startfile$ = drivein + "\talk\dingding.wa_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = destpath + "\wintalk.exe"
    startfile$ = drivein + "\talk\wintalk.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%
   
   
   'Leggimi talk
    docnow$ = docdest$ + "\talk"
    MkDir docnow$

    destfile$ = docnow$ + "\readme.1st"
    startfile$ = drivein + "\irc\readme.1s_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

    destfile$ = docnow$ + "\wintalk.doc"
    startfile$ = drivein + "\irc\wintalk.do_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%

  'irc completo
   
  'iphone
    destfile$ = destpath + "\$setup.exe"
    startfile$ = drivein + "\hi-tech\$setup.ex_"
    hfSrc% = LZOpenFile(startfile$, lpOfSrc, OF_READ)
    hfDst% = LZOpenFile(destfile$, lpOfDst, OF_CREATE)
    Rtn& = CopyLZFile(hfSrc%, hfDst%)
      stato_bar = 3015 / 52
      stato_per = 1
      Shape3.Width = stato_bar
      Label9.Caption = stato_per
      Shape3.Refresh
      Label9.Refresh
    LZClose hfSrc%
    LZClose hfDst%



   ' Crea gruppo e icona nel Program Manager
    CreateProgManGroup form1, "Internet Force", "ianna.grp"
    CreateProgManItem form1, destpath + "\easy.exe", "Easy!", destpath + "\easy.exe"
    CreateProgManItem form1, "winhelp " + destpath + "\easy-net.hlp", "Guida", "winhelp.exe"
    CreateProgManItem form1, destpath + "\$setup.exe", "Telefono su Internet", destpath + "\$setup.exe"
    
    stato_bar = 3013
    stato_per = 99
    'copia in WinDir$()
    'FileCopy destpath + "\winsock.dll", dovewin + "\winsock.dll"
    Shape3.Width = stato_bar
    Label9.Caption = stato_per
    Shape3.Refresh
    Label9.Refresh
    form1.Refresh
    LZDone
    Screen.MousePointer = 0
    fine = MsgBox("L'installazione è stata completata", 64, "Setup")
    Unload form1
End Sub

Sub Command2_Click ()
 End
End Sub

Sub Command3_Click ()
     x = Shell("winhelp " + drivein + "\installa.hlp", 3)
End Sub

Sub Drive1_Change ()
  drivein = Left(drive1.Drive, 2)
  File1.Path = Left(drive1.Drive, 2) + "\"
  drive2.Refresh
End Sub

Sub Drive2_Change ()
    driveout = Left(drive2.Drive, 2)
    destpath = driveout + "\iforce"
    label2.Caption = UCase(destpath)
End Sub

Sub File1_PathChange ()
    File1.Refresh
    drive2.Refresh
End Sub

Sub Form_Load ()
  Shape3.Width = 0
  Label9.Caption = 0
  Shape3.Visible = False
  drive1.Drive = Left$(CurDir$, 2)
  drive2.Drive = "C:"
  File1.Path = CurDir$
  form1.Show
End Sub

