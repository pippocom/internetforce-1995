VERSION 2.00
Begin Form Form1 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Welcome kit setup"
   ClientHeight    =   3975
   ClientLeft      =   750
   ClientTop       =   1710
   ClientWidth     =   8580
   ControlBox      =   0   'False
   FillColor       =   &H00FF0000&
   Height          =   4380
   Icon            =   INST640.FRX:0000
   Left            =   690
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   Picture         =   INST640.FRX:0302
   ScaleHeight     =   3975
   ScaleWidth      =   8580
   Top             =   1365
   Visible         =   0   'False
   Width           =   8700
   Begin DriveListBox Drive2 
      Height          =   315
      Left            =   5760
      TabIndex        =   13
      Top             =   1560
      Width           =   2295
   End
   Begin CommandButton Command3 
      Caption         =   "&Help"
      Height          =   375
      Left            =   5520
      TabIndex        =   8
      Top             =   3360
      Width           =   855
   End
   Begin FileListBox File1 
      ForeColor       =   &H00C0C0C0&
      Height          =   225
      Left            =   1320
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   3000
      Visible         =   0   'False
      Width           =   735
   End
   Begin CommandButton Command2 
      Caption         =   "&Esci dal Setup"
      Height          =   375
      Left            =   6720
      TabIndex        =   4
      Top             =   3360
      Width           =   1455
   End
   Begin CommandButton Command1 
      Caption         =   "&Continua"
      Height          =   375
      Left            =   4080
      TabIndex        =   3
      Top             =   3360
      Width           =   975
   End
   Begin DriveListBox Drive1 
      Height          =   315
      Left            =   5760
      TabIndex        =   0
      Top             =   960
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
      Left            =   4080
      TabIndex        =   14
      Top             =   2160
      Width           =   1215
   End
   Begin Label Label6 
      BackColor       =   &H00C0C0C0&
      Caption         =   "© 1995, M. Iannacone"
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
      Top             =   3720
      Width           =   2175
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
      Left            =   3360
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
      Left            =   4080
      TabIndex        =   10
      Top             =   1560
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
      Left            =   4080
      TabIndex        =   9
      Top             =   960
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
      Left            =   5760
      TabIndex        =   1
      Top             =   2160
      Width           =   1455
   End
   Begin Label Label1 
      Caption         =   "DDE"
      Height          =   375
      Left            =   2520
      TabIndex        =   2
      Top             =   3000
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
      Left            =   7200
      TabIndex        =   6
      Top             =   2760
      Width           =   495
   End
   Begin Shape Shape3 
      BackColor       =   &H00FFFFFF&
      BorderColor     =   &H00FFFFFF&
      FillColor       =   &H0000FFFF&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   3960
      Top             =   2760
      Width           =   3135
   End
   Begin Shape Shape2 
      BackColor       =   &H00FFFFFF&
      BorderColor     =   &H00808080&
      BorderStyle     =   6  'Inside Solid
      FillColor       =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   3960
      Top             =   2760
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
      Left            =   7680
      TabIndex        =   5
      Top             =   2760
      Width           =   255
   End
   Begin Shape Shape1 
      BackColor       =   &H00FFFFFF&
      BorderColor     =   &H00000000&
      BorderWidth     =   2
      FillColor       =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   7200
      Top             =   2760
      Width           =   735
   End
End

Sub Command1_Click ()
  dovewin = windir$()
  oggi = Date
  scade = CVDate("01/12/99")
  If oggi > scade Then
    mess1 = "Questa versione (beta 1) è scaduta."
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
  If File1.ListCount = 0 Then End

  MkDir destpath
  
    stato_bar = 3015 / 52
    stato_per = 1
    Shape3.Width = stato_bar
    Label9.Caption = stato_per
    Shape3.Refresh
    Label9.Refresh
    destfile = destpath + "\twsk20b.zip"
    startfile = drivein + "\twsk20b.zip"
    FileCopy startfile, destfile
	stato_bar = 3015 / 7
	stato_per = 14
	Shape3.Width = stato_bar
	Label9.Caption = stato_per
	Shape3.Refresh
	Label9.Refresh
    FileCopy drivein + "\eudor152.zip", destpath + "\eudor152.zip"
    FileCopy drivein + "\easy-net.ex_", destpath + "\easy-net.exe"
    FileCopy drivein + "\installa.hlp", destpath + "\easy-net.hlp"
	stato_bar = 3015 / 4
	stato_per = 25
	Shape3.Width = stato_bar
	Label9.Caption = stato_per
	Shape3.Refresh
	Label9.Refresh
    FileCopy drivein + "\vbrun300.dll", destpath + "\vbrun300.dll"
    FileCopy drivein + "\pkunzip.exe", destpath + "\pkunzip.exe"
	stato_bar = 3015 / 2.5
	stato_per = 40
	Shape3.Width = stato_bar
	Label9.Caption = stato_per
	Shape3.Refresh
	Label9.Refresh
    FileCopy drivein + "\threed.vb_", destpath + "\threed.vbx"
    FileCopy drivein + "\ws_ftp.zip", destpath + "\ws_ftp.zip"
	stato_bar = 3015 / 2
	stato_per = 50
	Shape3.Width = stato_bar
	Label9.Caption = stato_per
	Shape3.Refresh
	Label9.Refresh
    FileCopy drivein + "\installa.inf", destpath + "\pk.bat"
    FileCopy drivein + "\installa.pi_", destpath + "\pk.pif"
    FileCopy drivein + "\$setup.ex_", destpath + "\$setup.exe"
    Screen.MousePointer = 0
    ' unzippa i files e li cancella
	form2.Show 1
	stato_bar = 3015 * 4 / 5
	stato_per = 80
	Shape3.Width = stato_bar
	Label9.Caption = stato_per
	Shape3.Refresh
	Label9.Refresh

    ' Copia i file di configurazione a cura del file batch
    
    ' Crea gruppo e icona nel Program Manager
    CreateProgManGroup form1, "Internet Force", "ianna.grp"
    CreateProgManItem form1, destpath + "\easy-net.exe", "Easy-Net", destpath + "\easy-net.exe"
    CreateProgManItem form1, "winhelp " + destpath + "\easy-net.hlp", "Guida", "winhelp.exe"
    CreateProgManItem form1, destpath + "\$setup.exe", "Installa WinWeb", destpath + "\$setup.exe"
    stato_bar = 3013
    stato_per = 99
    'copia in WinDir$()
    FileCopy destpath + "\winsock.dll", dovewin + "\winsock.dll"
    Shape3.Width = stato_bar
    Label9.Caption = stato_per
    Shape3.Refresh
    Label9.Refresh
    form1.Refresh
    Screen.MousePointer = 0
    cancello = MsgBox("Quando l'espansione è ultimata, premi OK per cancellare i file temporanei", 48, "IMPORTANTE")
    zippati = destpath + "\*.zip"
    Kill zippati
    altri = destpath + "\pk*.*"
    Kill altri
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

