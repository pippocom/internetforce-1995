VERSION 2.00
Begin Form Form1 
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Form1"
   ClientHeight    =   2460
   ClientLeft      =   1605
   ClientTop       =   1485
   ClientWidth     =   7095
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Height          =   2865
   Icon            =   IPHONE.FRX:0000
   Left            =   1545
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   IPHONE.FRX:0302
   ScaleHeight     =   2460
   ScaleWidth      =   7095
   Top             =   1140
   Width           =   7215
   Begin CommandButton Command1 
      Caption         =   "&Ok"
      Height          =   375
      Left            =   4440
      TabIndex        =   1
      Top             =   2040
      Width           =   1095
   End
   Begin Label Label1 
      Caption         =   "Internet Force ha sviluppato un apposito kit che consente di utilizzare Internet per comunicare in viva voce. Il Kit contiene una scheda audio ad alte prestazioni, un potente microfono, un paio di cuffie ergonomiche di alta qualità e tutto il software necessario. Per maggiori informazioni contattate INTERNET FORCE."
      Height          =   1815
      Left            =   3480
      TabIndex        =   0
      Top             =   120
      Width           =   3375
   End
End
Sub Command1_Click ()
Unload form1
End Sub

