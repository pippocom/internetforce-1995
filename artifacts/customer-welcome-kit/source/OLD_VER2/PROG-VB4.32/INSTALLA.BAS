Type OFSTRUCT
    cBytes As String * 1
    fFixedDisk As String * 1
    nErrCode As Integer
    reserved As String * 4
    szPathName As String * 128
End Type

Declare Function LZStart Lib "LZexpand.dll" () As Integer
Declare Function GetExpandedName Lib "LZexpand.dll" (ByVal lpszSource As String, ByVal lpszBuffer As String) As Integer
Declare Function LZOpenFile Lib "LZexpand.dll" (ByVal lpszFile As String, lpOf As OFSTRUCT, ByVal style As Integer) As Integer
Declare Function CopyLZFile Lib "LZexpand.dll" (ByVal hfSource As Integer, ByVal hfDest As Integer) As Long
Declare Sub LZClose Lib "LZexpand.dll" (ByVal hfFile As Integer)
Declare Sub LZDone Lib "LZexpand.dll" ()

Global drivein, driveout, destpath

'-------------------------------------------------------------
' Procedure: CreateProgManGroup
' Arguments: X           Form where Label1 exist
'            GroupName$  string that contains group name
'            GroupPath$  string that contains group file
'                        name  ie 'myapp.grp'
'-------------------------------------------------------------
Sub CreateProgManGroup (x As Form, GroupName$, GroupPath$)
    
    Screen.MousePointer = 11
    
    '----------------------------------------------------------------------
    ' Windows requires DDE in order to create a program group and item.
    ' Here, a Visual Basic label control is used to generate the DDE messages
    '----------------------------------------------------------------------
    On Error Resume Next

    
    '--------------------------------
    ' Set LinkTopic to PROGRAM MANAGER
    '--------------------------------
    x.Label1.LinkTopic = "ProgMan|Progman"
    x.Label1.LinkMode = 2
    For i% = 1 To 10                                         ' Loop to ensure that there is enough time to
      z% = DoEvents()                                        ' process DDE Execute.  This is redundant but needed
    Next                                                     ' for debug windows.
    x.Label1.LinkTimeout = 100


    '---------------------
    ' Create program group
    '---------------------
    x.Label1.LinkExecute "[CreateGroup(" + GroupName$ + Chr$(44) + GroupPath$ + ")]"


    '-----------------
    ' Reset properties
    '-----------------
    x.Label1.LinkTimeout = 50
    x.Label1.LinkMode = 0
    
    Screen.MousePointer = 0
End Sub

'----------------------------------------------------------
' Procedure: CreateProgManItem
'
' Arguments: X           The form where Label1 exists
'
'            CmdLine$    string that contains command
'                        line for item/icon.
'                        ie 'c:\myapp\setup.exe'
'
'            IconTitle$  string that contains item's caption
'----------------------------------------------------------
Sub CreateProgManItem (x As Form, CmdLine$, IconTitle$, Icona$)
    
    Screen.MousePointer = 11
    
    '----------------------------------------------------------------------
    ' Windows requires DDE in order to create a program group and item.
    ' Here, a Visual Basic label control is used to generate the DDE messages
    '----------------------------------------------------------------------
    On Error Resume Next


    '---------------------------------
    ' Set LinkTopic to PROGRAM MANAGER
    '---------------------------------
    x.Label1.LinkTopic = "ProgMan|Progman"
    x.Label1.LinkMode = 2
    For i% = 1 To 10                                         ' Loop to ensure that there is enough time to
      z% = DoEvents()                                        ' process DDE Execute.  This is redundant but needed
    Next                                                     ' for debug windows.
    x.Label1.LinkTimeout = 100

    
    '------------------------------------------------
    ' Create Program Item, for Program Manager
    '------------------------------------------------
    If gfWin31% Then
        ' Win 3.1 has a ReplaceItem, which will allow us to replace existing icons
        x.Label1.LinkExecute "[ReplaceItem(" + IconTitle$ + ")]"
    End If
    x.Label1.LinkExecute "[AddItem(" + CmdLine$ + Chr$(44) + IconTitle$ + Chr$(44) + Icona$ + ",,)]"
    x.Label1.LinkExecute "[ShowGroup(groupname, 1)]"         ' This will ensure that Program Manager does not
                                                             ' have a Maximized group, which causes problem in RestoreProgMan

    '-----------------
    ' Reset properties
    '-----------------
    x.Label1.LinkTimeout = 50
    x.Label1.LinkMode = 0
    
    Screen.MousePointer = 0
End Sub

