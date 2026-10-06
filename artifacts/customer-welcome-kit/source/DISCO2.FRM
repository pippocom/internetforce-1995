VERSION 2.00
Begin Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Procedo..."
   ClientHeight    =   1440
   ClientLeft      =   4245
   ClientTop       =   3825
   ClientWidth     =   2025
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   1845
   Left            =   4185
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1440
   ScaleWidth      =   2025
   Top             =   3480
   Width           =   2145
   Begin CommandButton Command3 
      Caption         =   " B:"
      Height          =   375
      Left            =   1200
      TabIndex        =   3
      Top             =   480
      Width           =   495
   End
   Begin CommandButton Command2 
      Caption         =   "Annulla"
      Height          =   375
      Left            =   600
      TabIndex        =   2
      Top             =   960
      Width           =   855
   End
   Begin CommandButton Command1 
      Caption         =   " A:"
      Height          =   375
      Left            =   360
      TabIndex        =   1
      Top             =   480
      Width           =   495
   End
   Begin Label Label1 
      Caption         =   "Inserisci il Disco 2"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   1815
   End
End

Sub Command1_Click ()
    drivein = "a:"
    zw = Shell(drivein + "ww20b3.exe", 1)
    End
End Sub

Sub Command2_Click ()
    End
End Sub

Sub Command3_Click ()
    drivein = "b:"
    zw = Shell(drivein + "ww20b3.exe", 1)
    End
End Sub

