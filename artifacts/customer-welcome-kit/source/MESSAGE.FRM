VERSION 2.00
Begin Form Form2 
   BackColor       =   &H00E0FFFF&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "ATTENZIONE"
   ClientHeight    =   1935
   ClientLeft      =   2085
   ClientTop       =   2310
   ClientWidth     =   3975
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   2340
   Left            =   2025
   LinkTopic       =   "Form2"
   ScaleHeight     =   1935
   ScaleWidth      =   3975
   Top             =   1965
   Width           =   4095
   Begin CommandButton Command1 
      Caption         =   "Procedi"
      Height          =   375
      Left            =   720
      TabIndex        =   2
      Top             =   1440
      Width           =   2535
   End
   Begin PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   240
      Picture         =   MESSAGE.FRX:0000
      ScaleHeight     =   495
      ScaleWidth      =   495
      TabIndex        =   0
      Top             =   360
      Width           =   495
   End
   Begin Label Label1 
      BackColor       =   &H00E0FFFF&
      Caption         =   "Tutti  gli  archivi  sono  stati copiati sul disco. Questi files verranno ora  decompressi  e verranno create le opportune icone nel Program Manager."
      Height          =   1095
      Left            =   960
      TabIndex        =   1
      Top             =   120
      Width           =   2535
   End
End

Sub Command1_Click ()
    file1 = driveout + "\iforce\pk.pif"
    x = Shell(file1 + " " + driveout + " " + drivein, 1)
    'cancello i files in più
    Unload form2
End Sub

Sub Form_Unload (Cancel As Integer)
    fine = MsgBox("Attendere che il programma abbia ultimato l'espansione dei files", 48, "IMPORTANTE")
End Sub

