VERSION 2.00
Begin Form Form3 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Attenzione"
   ClientHeight    =   2370
   ClientLeft      =   1350
   ClientTop       =   2475
   ClientWidth     =   6210
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   2775
   Left            =   1290
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2370
   ScaleWidth      =   6210
   Top             =   2130
   Width           =   6330
   Begin CommandButton Command2 
      Caption         =   "Aiuto"
      Height          =   375
      Left            =   3120
      TabIndex        =   1
      Top             =   1800
      Width           =   975
   End
   Begin CommandButton Command1 
      Caption         =   "Chiudi"
      Height          =   375
      Left            =   1200
      TabIndex        =   2
      Top             =   1800
      Width           =   975
   End
   Begin Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Questo pulsante esegue un programma che si trova sul disco n.2 (utilità aggiuntive).  Se non riuscite a lanciarlo, rifate l'installazione"
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
      Width           =   5895
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

