VERSION 2.00
Begin Form Form1 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   0  'None
   Caption         =   "Un progetto di Marco Iannacone"
   ClientHeight    =   1440
   ClientLeft      =   2955
   ClientTop       =   3975
   ClientWidth     =   5055
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   1845
   Icon            =   BARRA640.FRX:0000
   Left            =   2895
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1440
   ScaleWidth      =   5055
   Top             =   3630
   Width           =   5175
   Begin TextBox Text1 
      Height          =   285
      Left            =   2640
      TabIndex        =   16
      Text            =   "text"
      Top             =   1560
      Width           =   615
   End
   Begin FileListBox File1 
      Height          =   225
      Left            =   1320
      TabIndex        =   15
      Top             =   1560
      Visible         =   0   'False
      Width           =   1095
   End
   Begin DriveListBox Drive1 
      Height          =   315
      Left            =   120
      TabIndex        =   14
      Top             =   1560
      Visible         =   0   'False
      Width           =   855
   End
   Begin SSCommand Command3D14 
      Height          =   735
      Left            =   4320
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:0302
      TabIndex        =   13
      Top             =   720
      Width           =   735
   End
   Begin SSCommand Command3D13 
      Height          =   735
      Left            =   3600
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:0638
      TabIndex        =   12
      Top             =   720
      Width           =   735
   End
   Begin SSCommand Command3D12 
      Height          =   735
      Left            =   2880
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:0832
      TabIndex        =   11
      Top             =   720
      Width           =   735
   End
   Begin SSCommand Command3D11 
      Height          =   735
      Left            =   2160
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:0B34
      TabIndex        =   10
      Top             =   720
      Width           =   735
   End
   Begin SSCommand Command3D10 
      Height          =   735
      Left            =   4320
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:0E92
      TabIndex        =   6
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D9 
      Height          =   735
      Left            =   1440
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:129C
      TabIndex        =   9
      Top             =   720
      Width           =   735
   End
   Begin SSCommand Command3D8 
      Height          =   735
      Left            =   720
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:15E6
      TabIndex        =   8
      Top             =   720
      Width           =   735
   End
   Begin SSCommand Command3D7 
      Height          =   735
      Left            =   0
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:1944
      TabIndex        =   7
      Top             =   720
      Width           =   735
   End
   Begin SSCommand Command3D6 
      Height          =   735
      Left            =   3600
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:1CB6
      TabIndex        =   5
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D5 
      Height          =   735
      Left            =   1440
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:2028
      TabIndex        =   2
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D4 
      Height          =   735
      Left            =   2880
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:22FA
      TabIndex        =   4
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D3 
      Height          =   735
      Left            =   2160
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:2644
      TabIndex        =   3
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D2 
      Height          =   735
      Left            =   0
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:29A2
      TabIndex        =   0
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D1 
      Height          =   735
      Left            =   720
      Outline         =   0   'False
      Picture         =   BARRA640.FRX:2DAC
      TabIndex        =   1
      Top             =   0
      Width           =   735
   End
End
DefInt F
Declare Function FindWindow Lib "User" (ByVal lpClassName As Any, ByVal lpCaption As Any)
Const niente = 0&

Dim scade
Dim oggi

Sub Command3D1_Click ()
    Dim net, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\netscape.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        net = Shell(ilfile, 1)
    Else
    form3.Show MODAL
    End If
End Sub

Sub Command3D10_Click ()
    Dim ping, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\ws_ping.exe"
    
    text1.Text = "ws_ping"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
     ClassName$ = text1.Text
     FoundhWnd = FindWindow(ClassName$, niente)
      If FoundhWnd <> 0 Then
           mess1$ = "Il programma è già in memoria.." & Chr(13) & "Verificate che il collegamento" & Chr(13) & "con Internet sia attivo."
           messag = MsgBox(mess1$, 64, "ATTENZIONE")
      Else
           ping = Shell(ilfile, 1)
      End If
    
    Else
        form3.Show MODAL
    End If
End Sub

Sub Command3D11_Click ()
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
    form3.Show MODAL
    End If
End Sub

Sub Command3D12_Click ()
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
    form3.Show MODAL
    End If
End Sub

Sub Command3D13_Click ()
    form2.Show MODAL
End Sub

Sub Command3D14_Click ()
    End
End Sub

Sub Command3D2_Click ()
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
      form3.Show MODAL
    End If
End Sub

Sub Command3D3_Click ()
    Dim ftp, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\ws_ftp.exe"
    text1.Text = "ws_ftp"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
     ClassName$ = text1.Text
     FoundhWnd = FindWindow(ClassName$, niente)
      If FoundhWnd <> 0 Then
           mess1$ = "Il programma è già in memoria..." & Chr(13) & "Verificate che il collegamento" & Chr(13) & "con Internet sia attivo."
           messag = MsgBox(mess1$, 64, "ATTENZIONE")
      Else
           ftp = Shell(ilfile, 1)
      End If
    
    Else
        form3.Show MODAL
    End If
End Sub

Sub Command3D4_Click ()
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
    form3.Show MODAL
    End If
End Sub

Sub Command3D5_Click ()
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
    form3.Show MODAL
    End If
End Sub

Sub Command3D6_Click ()
    Dim teln, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\trmptel.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        teln = Shell(ilfile, 1)
    Else
    form3.Show MODAL
    End If
End Sub

Sub Command3D7_Click ()
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
    form3.Show MODAL
    End If
End Sub

Sub Command3D8_Click ()
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
    form3.Show MODAL
    End If
End Sub

Sub Command3D9_Click ()
    Dim irc, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(Drive1.Drive, 2)
    ilfile = drivedef + "\iforce\wsirc.exe"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        irc = Shell(ilfile, 1)
    Else
    form3.Show MODAL
    End If
End Sub

Sub Drive1_Change ()
  drivein = Drive1.Drive
  File1.Path = Left(Drive1.Drive, 2) + "\"
End Sub

Sub File1_Click ()
    File1.Refresh
End Sub

Sub Form_Load ()
  Drive1.Drive = Left$(CurDir$, 2)
  File1.Path = CurDir$
  oggi = Date
  scade = CVDate("01/02/99")
  If oggi > scade Then
    mess1 = "Questa versione è scaduta."
    mess1 = mess1 & Chr(13) & "Contattare Internet Force o l'autore"
    esci = MsgBox(mess1, 16, "ATTENZIONE")
   Unload form1
   form2.Show
  Else
   form1.Show
  End If
End Sub

