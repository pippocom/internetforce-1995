VERSION 4.00
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Easy!"
   ClientHeight    =   4530
   ClientLeft      =   2340
   ClientTop       =   1455
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
   Height          =   4935
   Icon            =   "EASY.frx":0000
   Left            =   2280
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4530
   ScaleWidth      =   5415
   Top             =   1110
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
   Begin VBX.SSCommand Command3D0 
      BevelWidth      =   3
      Height          =   2415
      Index           =   0
      Left            =   1080
      Picture         =   "EASY.frx":030A
      RoundedCorners  =   0   'False
      TabIndex        =   0
      Top             =   1080
      Width           =   3255
   End
   Begin VBX.SSCommand Command3D1 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   1
      Left            =   0
      Picture         =   "EASY.frx":81DC
      RoundedCorners  =   0   'False
      TabIndex        =   1
      Top             =   0
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D6 
      BevelWidth      =   5
      Height          =   1215
      Index           =   6
      Left            =   0
      Picture         =   "EASY.frx":89BE
      RoundedCorners  =   0   'False
      TabIndex        =   6
      Top             =   1080
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D8 
      BevelWidth      =   5
      Height          =   1215
      Index           =   8
      Left            =   0
      Picture         =   "EASY.frx":91A0
      RoundedCorners  =   0   'False
      TabIndex        =   8
      Top             =   2280
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D10 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   10
      Left            =   0
      Picture         =   "EASY.frx":9982
      RoundedCorners  =   0   'False
      TabIndex        =   10
      Top             =   3480
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D11 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   11
      Left            =   1080
      Picture         =   "EASY.frx":A164
      RoundedCorners  =   0   'False
      TabIndex        =   11
      Top             =   3480
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D12 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   12
      Left            =   2160
      Picture         =   "EASY.frx":A946
      RoundedCorners  =   0   'False
      TabIndex        =   12
      Top             =   3480
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D13 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   13
      Left            =   3240
      Picture         =   "EASY.frx":B128
      RoundedCorners  =   0   'False
      TabIndex        =   13
      Top             =   3480
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D14 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   14
      Left            =   4320
      Picture         =   "EASY.frx":B90A
      RoundedCorners  =   0   'False
      TabIndex        =   14
      Top             =   3480
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D9 
      BevelWidth      =   5
      Height          =   1215
      Index           =   9
      Left            =   4320
      Picture         =   "EASY.frx":C0EC
      RoundedCorners  =   0   'False
      TabIndex        =   9
      Top             =   2280
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D7 
      BevelWidth      =   5
      Height          =   1215
      Index           =   7
      Left            =   4320
      Picture         =   "EASY.frx":C8CE
      RoundedCorners  =   0   'False
      TabIndex        =   7
      Top             =   1080
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D5 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   5
      Left            =   4320
      Picture         =   "EASY.frx":D0B0
      RoundedCorners  =   0   'False
      TabIndex        =   5
      Top             =   0
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D4 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   4
      Left            =   3240
      Picture         =   "EASY.frx":D892
      RoundedCorners  =   0   'False
      TabIndex        =   4
      Top             =   0
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D3 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   3
      Left            =   2160
      Picture         =   "EASY.frx":E074
      RoundedCorners  =   0   'False
      TabIndex        =   3
      Top             =   0
      Width           =   1095
   End
   Begin VBX.SSCommand Command3D2 
      AutoSize        =   2  'Adjust Button Size To Picture
      BevelWidth      =   5
      Height          =   1095
      Index           =   2
      Left            =   1080
      Picture         =   "EASY.frx":E856
      RoundedCorners  =   0   'False
      TabIndex        =   2
      Top             =   0
      Width           =   1095
   End
End
Attribute VB_Name = "Form1"
Attribute VB_Creatable = False
Attribute VB_Exposed = False

Private Sub Command3D14_Click(Index As Integer)
    End
End Sub

Private Sub Form_GotFocus()
    Form1.Refresh
End Sub

