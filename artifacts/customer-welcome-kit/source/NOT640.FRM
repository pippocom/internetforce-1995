VERSION 2.00
Begin Form Form3 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Attenzione"
   ClientHeight    =   3585
   ClientLeft      =   2610
   ClientTop       =   2670
   ClientWidth     =   5415
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   3990
   Left            =   2550
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3585
   ScaleWidth      =   5415
   Top             =   2325
   Width           =   5535
   Begin CommandButton Command2 
      Caption         =   "Aiuto"
      Height          =   375
      Left            =   3240
      TabIndex        =   3
      Top             =   3000
      Width           =   975
   End
   Begin CommandButton Command1 
      Caption         =   "Chiudi"
      Height          =   375
      Left            =   840
      TabIndex        =   2
      Top             =   3000
      Width           =   975
   End
   Begin Label Label2 
      Caption         =   "E' necessario collegarsi  ad  Internet  Force premendo il  pulsante  con  il  telefono,  lanciare il programma di FTP e scaricare  il  programma  che  ci interessa. Per maggiori informazioni su quale file prelevare, premere il pulsante di aiuto."
      Height          =   1095
      Left            =   360
      TabIndex        =   1
      Top             =   1680
      Width           =   4695
   End
   Begin Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Questo pulsante esegue un programma che non possedete ancora ma che potete scaricare da Internet Force."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   15.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00800000&
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   5175
   End
End

Sub Command1_Click ()
    Unload form3
End Sub

Sub Command2_Click ()
    Dim aiu, ilfile As String
    Dim x As Integer
    x = FreeFile
    drivedef = Left$(CurDir$, 2)
    ilfile = drivedef + "\iforce\easy-net.hlp"
    On Error Resume Next
    Open ilfile For Input As x
    If Err = 0 Then
        aiu = Shell("winhelp.exe " + ilfile, 1)
        Unload form3
    Else
      response = MsgBox("Manca un file", 16, "ATTENZIONE")
      End
    End If
End Sub

