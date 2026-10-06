VERSION 4.00
Begin VB.Form Form3 
   Appearance      =   0  'Flat
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Attenzione"
   ClientHeight    =   1455
   ClientLeft      =   1350
   ClientTop       =   2475
   ClientWidth     =   6585
   ClipControls    =   0   'False
   ControlBox      =   0   'False
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
   Height          =   1860
   Left            =   1290
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1455
   ScaleWidth      =   6585
   ShowInTaskbar   =   0   'False
   Top             =   2130
   Visible         =   0   'False
   Width           =   6705
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Aiuto"
      Height          =   375
      Left            =   5400
      TabIndex        =   1
      Top             =   960
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Chiudi"
      Height          =   375
      Left            =   4440
      TabIndex        =   2
      Top             =   960
      Width           =   855
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      Caption         =   $"NOTFND.frx":0000
      BeginProperty Font 
         name            =   "Times New Roman"
         charset         =   1
         weight          =   700
         size            =   15.75
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6135
   End
End
Attribute VB_Name = "Form3"
Attribute VB_Creatable = False
Attribute VB_Exposed = False

Private Sub Command1_Click()
    Unload Form3
End Sub

Private Sub Command2_Click()
    Dim aiu, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(CurDir$, 2)
    ilfile = drivedef + "\iforce\easy-net.hlp"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        aiu = Shell("winhelp.exe " + ilfile, 1)
        Unload Form3
    Else
      response = MsgBox("Manca un file", 16, "ATTENZIONE")
      End
    End If
End Sub

