VERSION 2.00
Begin Form Form1 
   BackColor       =   &H00E0FFFF&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "WWW setup"
   ClientHeight    =   1545
   ClientLeft      =   2745
   ClientTop       =   2745
   ClientWidth     =   3300
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   1950
   Icon            =   WINWEB.FRX:0000
   Left            =   2685
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1545
   ScaleWidth      =   3300
   Top             =   2400
   Width           =   3420
   Begin CommandButton Command2 
      Caption         =   "No, ne ho gia' uno."
      Height          =   375
      Left            =   1200
      TabIndex        =   3
      Top             =   1080
      Width           =   1935
   End
   Begin CommandButton Command1 
      Caption         =   "SI !"
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   1080
      Width           =   735
   End
   Begin Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00E0FFFF&
      Caption         =   "WINWEB ?"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   13.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   720
      TabIndex        =   1
      Top             =   480
      Width           =   1935
   End
   Begin Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00E0FFFF&
      Caption         =   "Vuoi installare il browser "
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   120
      Width           =   2655
   End
End

Sub Command1_Click ()
    form2.Show MODAL
    Unload form1
End Sub

Sub Command2_Click ()
    End
End Sub

