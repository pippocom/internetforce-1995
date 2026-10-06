VERSION 4.00
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Easy!"
   ClientHeight    =   4560
   ClientLeft      =   2325
   ClientTop       =   1470
   ClientWidth     =   5415
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   DrawMode        =   9  'Not Mask Pen
   DrawWidth       =   5
   BeginProperty Font 
      name            =   "MS Sans Serif"
      charset         =   1
      weight          =   700
      size            =   8.25
      underline       =   0   'False
      italic          =   0   'False
      strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Height          =   4965
   Icon            =   "EASY.frx":0000
   Left            =   2265
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4560
   ScaleWidth      =   5415
   Top             =   1125
   Width           =   5535
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2520
      TabIndex        =   17
      Text            =   "text"
      Top             =   4680
      Width           =   615
   End
   Begin VB.FileListBox File1 
      Appearance      =   0  'Flat
      Height          =   225
      Left            =   1200
      TabIndex        =   16
      Top             =   4680
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.DriveListBox Drive1 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   120
      TabIndex        =   15
      Top             =   4680
      Visible         =   0   'False
      Width           =   855
   End
   Begin Threed.SSCommand Command3D0 
      Height          =   2415
      Left            =   1080
      TabIndex        =   0
      Top             =   1080
      Width           =   3255
      _version        =   65536
      _extentx        =   5741
      _extenty        =   4260
      _stockprops     =   78
      bevelwidth      =   3
      roundedcorners  =   0   'False
      picture         =   "EASY.frx":030A
   End
   Begin Threed.SSCommand Command3D1 
      Height          =   1095
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":81EC
   End
   Begin Threed.SSCommand Command3D6 
      Height          =   1215
      Left            =   0
      TabIndex        =   6
      Top             =   1080
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   2143
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      picture         =   "EASY.frx":89DE
   End
   Begin Threed.SSCommand Command3D8 
      Height          =   1215
      Left            =   0
      TabIndex        =   8
      Top             =   2280
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   2143
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      picture         =   "EASY.frx":91D0
   End
   Begin Threed.SSCommand Command3D10 
      Height          =   1095
      Left            =   0
      TabIndex        =   10
      Top             =   3480
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":99C2
   End
   Begin Threed.SSCommand Command3D11 
      Height          =   1095
      Left            =   1080
      TabIndex        =   11
      Top             =   3480
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":A1B4
   End
   Begin Threed.SSCommand Command3D12 
      Height          =   1095
      Left            =   2160
      TabIndex        =   12
      Top             =   3480
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":A9A6
   End
   Begin Threed.SSCommand Command3D13 
      Height          =   1095
      Left            =   3240
      TabIndex        =   13
      Top             =   3480
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":B198
   End
   Begin Threed.SSCommand Command3D14 
      Height          =   1095
      Left            =   4320
      TabIndex        =   14
      Top             =   3480
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":B98A
   End
   Begin Threed.SSCommand Command3D9 
      Height          =   1215
      Left            =   4320
      TabIndex        =   9
      Top             =   2280
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   2143
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      picture         =   "EASY.frx":C17C
   End
   Begin Threed.SSCommand Command3D7 
      Height          =   1215
      Left            =   4320
      TabIndex        =   7
      Top             =   1080
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   2143
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      picture         =   "EASY.frx":C96E
   End
   Begin Threed.SSCommand Command3D5 
      Height          =   1095
      Left            =   4320
      TabIndex        =   5
      Top             =   0
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":D160
   End
   Begin Threed.SSCommand Command3D4 
      Height          =   1095
      Left            =   3240
      TabIndex        =   4
      Top             =   0
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":D952
   End
   Begin Threed.SSCommand Command3D3 
      Height          =   1095
      Left            =   2160
      TabIndex        =   3
      Top             =   0
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":E144
   End
   Begin Threed.SSCommand Command3D2 
      Height          =   1095
      Left            =   1080
      TabIndex        =   2
      Top             =   0
      Width           =   1095
      _version        =   65536
      _extentx        =   1931
      _extenty        =   1931
      _stockprops     =   78
      bevelwidth      =   5
      roundedcorners  =   0   'False
      autosize        =   2
      picture         =   "EASY.frx":E936
   End
End
Attribute VB_Name = "Form1"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
DefInt F
Private Declare Function GetVersion Lib "Kernel" () As Integer
Const niente = 0&

Dim scade
Dim oggi

Private Sub Command3D0_Click()
   Form2.Visible = True
   Form2.Show MODAL
End Sub


Private Sub Command3D1_Click()
    Dim tel, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\tcpman.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        tel = Shell(ilfile, 1)
    Else
      Form3.Show MODAL
    End If
End Sub


Private Sub Command3D10_Click()
    Dim arc, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\wsarchie.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        arc = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub

Private Sub Command3D11_Click()
    Dim talk, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\wintalk.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        talk = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub

Private Sub Command3D12_Click()
    Dim hyp, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\virtual.hlp"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        hyp = Shell("winhelp.exe " + ilfile, 1)
    Else
      messg$ = "E' possibile acquistare presso Internet Force" & Chr(13) & "un Ipertesto su Internet a L. 50.000 + IVA." & Chr(13) & "Per informazioni scrivete a custserv@intf.com"
      info = MsgBox(messg$, 64, "Guida Ipertestuale ad Internet e RV")
    End If
End Sub

Private Sub Command3D13_Click()
    Dim aiu, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\easy.hlp"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        aiu = Shell("winhelp.exe " + ilfile, 1)
        Unload Form2
    Else
      response = MsgBox("Manca un file", 16, "ATTENZIONE")
      End
    End If

End Sub

Private Sub Command3D14_Click()
    End
End Sub

Private Sub Command3D2_Click()
    Dim iphone, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\$setup.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        iphone = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub

Private Sub Command3D3_Click()
    Dim mail, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\eudora.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        mail = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub

Private Sub Command3D4_Click()
    Dim ftp, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\ws_ftp.exe"
    Text1.Text = "ws_ftp"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
     ClassName$ = Text1.Text
          ftp = Shell(ilfile, 1)
    Else
        Form3.Show MODAL
    End If
End Sub

Private Sub Command3D5_Click()
    Dim news, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\agent.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        news = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub


Private Sub Command3D6_Click()
    Dim irc, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\mirc.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        irc = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub

Private Sub Command3D7_Click()
    Dim teln, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\qvtnet16.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        teln = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub

Private Sub Command3D8_Click()
    Dim fing, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\mfinger.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        fing = Shell(ilfile, 1)
    Else
    Form3.Show MODAL
    End If
End Sub

Private Sub Command3D9_Click()
    Dim ping, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\ws_ping.exe"
    
    Text1.Text = "ws_ping"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
     ClassName$ = Text1.Text
         ping = Shell(ilfile, 1)
    Else
        Form3.Show MODAL
    End If
End Sub

Private Sub Form_Load()
Form2.Visible = False
Form3.Visible = False
Form2.Hide
Form3.Hide
drivedef = Left$(Drive1.Drive, 2)
Version% = GetVersion()
MajorVersion = Version% And &HFF
MinorVersion = (Version% And &HFF00) \ 256
If MinorVersion >= 95 Then
  response = MsgBox("Questa versione di Easy! non funziona con Win95", 16, "ATTENZIONE")
  End
End If
End Sub


