VERSION 4.00
Begin VB.Form Form2 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Easy!"
   ClientHeight    =   2385
   ClientLeft      =   1560
   ClientTop       =   3000
   ClientWidth     =   7365
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
   Height          =   2790
   Left            =   1500
   LinkTopic       =   "Form2"
   MinButton       =   0   'False
   Picture         =   "ABOUT.frx":0000
   ScaleHeight     =   2385
   ScaleWidth      =   7365
   ShowInTaskbar   =   0   'False
   Top             =   2655
   Visible         =   0   'False
   Width           =   7485
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Istruzioni"
      Default         =   -1  'True
      Height          =   375
      Left            =   5400
      TabIndex        =   3
      Top             =   1560
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Ok"
      Height          =   375
      Left            =   3840
      TabIndex        =   0
      Top             =   1560
      Width           =   735
   End
   Begin VB.Label Label6 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      Caption         =   "© 1995-96, M. Iannacone"
      BeginProperty Font 
         name            =   "Arial"
         charset         =   1
         weight          =   700
         size            =   9.75
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   4680
      TabIndex        =   2
      Top             =   2040
      Width           =   2655
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   $"ABOUT.frx":7ED2
      BeginProperty Font 
         name            =   "Times New Roman"
         charset         =   1
         weight          =   400
         size            =   10.5
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1335
      Left            =   3480
      TabIndex        =   1
      Top             =   120
      Width           =   3735
   End
End
Attribute VB_Name = "Form2"
Attribute VB_Creatable = False
Attribute VB_Exposed = False

Private Sub Command1_Click()
    Unload Form2
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
        Unload Form2
    Else
      response = MsgBox("Manca un file", 16, "ATTENZIONE")
      End
    End If
End Sub

Private Sub Form_Load()

End Sub


Private Sub Label2_Click()

End Sub


Private Sub Label6_Click()

End Sub


