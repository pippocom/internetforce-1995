VERSION 2.00
Begin Form Form2 
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Easy!"
   ClientHeight    =   2550
   ClientLeft      =   1560
   ClientTop       =   3000
   ClientWidth     =   7365
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   2955
   Left            =   1500
   LinkTopic       =   "Form2"
   Picture         =   ABOUT.FRX:0000
   ScaleHeight     =   2550
   ScaleWidth      =   7365
   Top             =   2655
   Width           =   7485
   Begin CommandButton Command2 
      Caption         =   "Istruzioni"
      Default         =   -1  'True
      Height          =   375
      Left            =   5400
      TabIndex        =   3
      Top             =   1680
      Width           =   1215
   End
   Begin CommandButton Command1 
      Caption         =   "Ok"
      Height          =   375
      Left            =   4200
      TabIndex        =   0
      Top             =   1680
      Width           =   735
   End
   Begin Label Label6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "© 1995-96, M. Iannacone"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   4680
      TabIndex        =   2
      Top             =   2280
      Width           =   2655
   End
   Begin Label Label2 
      Caption         =   "Internet Force ha creato questo programma per rendere più semplice l'uso di Internet ai propri abbonati.    Per iniziare, dopo aver letto le istruzioni, premere il pulsante con il telefono."
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   10.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1335
      Left            =   3480
      TabIndex        =   1
      Top             =   120
      Width           =   3735
   End
End

Sub Command1_Click ()
    Unload form2
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
        Unload form2
    Else
      response = MsgBox("Manca un file", 16, "ATTENZIONE")
      End
    End If
End Sub

