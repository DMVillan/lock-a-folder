#NoTrayIcon
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=appicon.ico
#AutoIt3Wrapper_Outfile=lock-a-folder.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=LocK-A-FoLdeR allows you to hide and lock up any folders on your computer.
#AutoIt3Wrapper_Res_Description=LocK-A-FoLdeR 3.9
#AutoIt3Wrapper_Res_Fileversion=3.9.0.0
#AutoIt3Wrapper_Res_ProductVersion=3.9
#AutoIt3Wrapper_Res_LegalCopyright=© Gurjit Singh
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

#cs ----------------------------------------------------------------------------

	LocK-A-FoLdeR Version: 3.9
	Author: Gurjit Singh
	Webpage: http://lock-a-folder.googlecode.com/
	Written in AutoIt v3.3.6.1
	Script Function:
	LocK-A-FoLdeR allows you to hide and lock up any folders on your computer, making them invisible and inaccessible to anyone but yourself. After you create a master password, simply select the folder(s) you want to hide and click a button to make them disappear. To unlock a folder, enter your password and select the folder that you want to unlock.
	License: Apache License 2.0 (http://www.opensource.org/licenses/apache2.0.php)
	Copyright (c) 2011 Gurjit Singh
		Licensed under the Apache License, Version 2.0 (the "License");
		you may not use this file except in compliance with the License.
		You may obtain a copy of the License at

			http://www.apache.org/licenses/LICENSE-2.0

		Unless required by applicable law or agreed to in writing, software
		distributed under the License is distributed on an "AS IS" BASIS,
		WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
		See the License for the specific language governing permissions and
		limitations under the License.

#ce ----------------------------------------------------------------------------
Opt("MustDeclareVars", 1)
Global Const $AppName = "LocK-A-FoLdeR",$AppVer = "3.9",$Apppage = "http://lock-a-folder.googlecode.com/",$updatefile = 'http://lock-a-folder.googlecode.com/hg/Updates.ini'
Global $Langdir = @ScriptDir & '\' & 'Lang',$Language = RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "Lang"),$Transby,$Translink,$winver
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <Process.au3>
#include <File.au3>
#include <String.au3>
#include <ComboConstants.au3>
#include <Array.au3>
#include <EditConstants.au3>
#include <Debug.au3>
#Include <Date.au3>
#Include <Security.au3>

If $Language ="" Then $Language = "English"
Global $Langslice = StringRegExpReplace($Language, '(\((.*?))\)', "")
If Not FileExists($Langdir & "\" & $Langslice & ".ini") Then $Language = "English"
_DebugSetup ("LocK-A-FoLdeR Debug Window", True,4,@ScriptDir & "\debug.log")
_DebugBugReportEnv()
_DebugOut(_Now())
_DebugOut($AppName &  "-" & $AppVer &  "-" & $Language &  "-" & $Langdir )
If _Singleton($AppName, 1) = 0 Then
	MsgBox(0, $AppName, $AppName & " "& Lang('alreadyrunning'))
	Exit
EndIf
If Not FileExists(@WindowsDir & "\system32\takeown.exe") Then $winver = "XP"
;Global $winver = "XP"
Global $WIN1 = GUICreate($AppName & " " & $AppVer , 449, 296)
getpass()
If $CmdLine[0] = 0 Then
	GUICtrlCreateTab(1, 0, 446, 269)
	Global $Label1 = GUICtrlCreateLabel("Copyright © 2011 Gurjit Singh", 10, 271, 182, 20)
	Global $Combo1 = GUICtrlCreateCombo("", 300, 269, 145, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "English" & "|" & llist(), $Language)
	Global $tabi1 = GUICtrlCreateTabItem(Lang('pickatask'))
	Global $Button1 = GUICtrlCreateButton(Lang('lockafolder'), 6, 28, 435, 33)
	Global $List1 = GUICtrlCreateList("", 6, 62, 433, 102)
	Global $Button2 = GUICtrlCreateButton(Lang('unlockselected'), 6, 166, 435, 33)
	Global $Button3 = GUICtrlCreateButton(Lang('changepassword'), 6, 198, 435, 33)
	Global $Button4 = GUICtrlCreateButton(Lang('exit'), 6, 230, 435, 33)
	Global $tabi2 = GUICtrlCreateTabItem(Lang('Aboutlockafolder'))
	GUICtrlCreateLabel($AppName & " " & "Version" & " " & $AppVer, 12, 38, 405, 20)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlCreateLabel("Copyright © 2011 Gurjit Singh", 12, 58, 405, 20)
	Global $Label2 = GUICtrlCreateLabel("Licensed Under: Apache License 2.0", 12, 78, 405, 20)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetFont(-1, 8.5, 400, 4)
	Global $Label7 = GUICtrlCreateLabel("Icon Copyright © Svengraph", 12, 98, 405, 20)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetFont(-1, 8.5, 400, 4)
	Global $Label3 = GUICtrlCreateLabel("Portions Copyright © AutoIt", 12, 118, 405, 20)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetFont(-1, 8.5, 400, 4)
	Global $Label9 = GUICtrlCreateLabel("", 12, 118, 405, 20)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetFont(-1, 8.5, 400, 4)
	Global $Label4 = GUICtrlCreateLabel("For Bug reports, suggestions and such, please contact correctlyincorrect@gmail.com", 12, 138, 405, 35)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetFont(-1, 8.5, 400, 4)
	GUICtrlCreateLabel("OR report an issue @", 12, 173, 405, 20)
	Global $Label5 = GUICtrlCreateLabel("http://code.google.com/p/lock-a-folder/issues/list", 12, 190, 405, 20)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetFont(-1, 8.5, 400, 4)
	Global $Button8 = GUICtrlCreateButton(Lang('checkupdates'), 6, 237, 435, 30)
	Global $Button5 = GUICtrlCreateButton(Lang('openreadme'), 8, 209, 203, 29)
	Global $Button6 = GUICtrlCreateButton(Lang('visitwebpage'), 212, 209, 227, 29)
	GUICtrlCreateTabItem("License")
	Global $Edit1 = GUICtrlCreateEdit(Fileread("LICENSE.txt"), 3, 27, 437, 237, $ES_READONLY + $WS_VSCROLL + $WS_HSCROLL)
	Global $tabi3 = GUICtrlCreateTabItem(Lang('RescueCentre'))
	Global $Button7 = GUICtrlCreateButton(Lang('Rescuefolder'), 6, 28, 435, 33)
	Global $Label6 = GUICtrlCreateLabel(Lang('notinlist'), 8, 68, 425, 92)
	GUICtrlCreateTabItem("")
	GUISetState(@SW_SHOW)
	Readfolders()
	if $Language <> "English" Then updatelang()
ElseIf $CmdLine[0] = 1 Then
	If $CmdLine[1] = "/ukall" Then
		Local $aray = StringSplit(RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders"), "|")
		For $i = 1 to UBound($aray,1) - 1
		If $aray[$i] = "" Then ExitLoop
		unlock($aray[$i])
		Next
		_Update_Explorer()
		Exit
	Else
		Msgbox(0,"",'LocK-A-FoLdeR.exe param "Folder[1]" "Folder[2]" "Folder[3]" "Folder[N]"' & @crlf & @crlf & 'Where param is : ' & @CRLF & '/lk to lock folder(s)' & @CRLF & '/uk to unlock folder(s)' & @CRLF& 'Examples :' & @CRLF & '> LocK-A-FoLdeR.exe /lk "C:\Downloads" "C:\Users\Gurjit\Pictures" "D:\F.E.A.R. 3" "D:\AssassinsCreed Brotherhood"' & @CRLF & '> LocK-A-FoLdeR.exe /uk "C:\Users\Gurjit\Pictures" "D:\F.E.A.R. 3"' & @CRLF & '> LocK-A-FoLdeR.exe /uk "C:\Downloads"' & @CRLF & @crlf & 'To Unlock all Locked folders :' & @CRLF & 'LocK-A-FoLdeR.exe /ukall')
	EndIf
Else
_DebugOut("cmdline")
	Switch $CmdLine[1]
		Case "/lk"
			For $i = 2 to UBound($CmdLine,1) - 1
			lock($CmdLine[$i])
			Next
			_Update_Explorer()
			Exit
		Case "/uk"
			For $i = 2 to UBound($CmdLine,1) - 1
			unlock($CmdLine[$i])
			Next
			_Update_Explorer()
			Exit
		Case Else
			Msgbox(0,"",'LocK-A-FoLdeR.exe param "Folder[1]" "Folder[2]" "Folder[3]" "Folder[N]"' & @crlf & @crlf & 'Where param is : ' & @CRLF & '/lk to lock folder(s)' & @CRLF & '/uk to unlock folder(s)' & @CRLF& 'Examples :' & @CRLF & '> LocK-A-FoLdeR.exe /lk "C:\Downloads" "C:\Users\Gurjit\Pictures" "D:\F.E.A.R. 3" "D:\AssassinsCreed Brotherhood"' & @CRLF & '> LocK-A-FoLdeR.exe /uk "C:\Users\Gurjit\Pictures" "D:\F.E.A.R. 3"' & @CRLF & '> LocK-A-FoLdeR.exe /uk "C:\Downloads"' & @CRLF & @crlf & 'To Unlock all Locked folders :' & @CRLF & 'LocK-A-FoLdeR.exe /ukall')
	EndSwitch
EndIf

If $CmdLine[0] = 0 Then
While 1
	Local $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button4
_DebugOut('Exit Pressed')
			Exit
		Case $Button1
_DebugOut('Lock Button Pressed')
			_Update_Explorer()
			Local $debug = Lock(FileSelectFolder(Lang("chooseafolder"), "", 1, "", $WIN1))
_DebugOut('Lock() = ' & $debug)
			_Update_Explorer()
		Case $Button2
_DebugOut('UnLock Button Pressed')
			_Update_Explorer()
			Local $debug = UnLock(GUICtrlRead($List1))
_DebugOut('UnLock() = ' & $debug)
			_Update_Explorer()
		Case $Button3
			changepass()
		Case $Label2
			Run(@ComSpec & ' /c start http://www.opensource.org/licenses/apache2.0.php', '', @SW_HIDE)
		Case $Label3
			Run(@ComSpec & ' /c start http://www.autoitscript.com/autoit3/', '', @SW_HIDE)
		Case $Label7
			Run(@ComSpec & ' /c start http://svengraph.deviantart.com/art/I-Love-Icons-178980215', '', @SW_HIDE)
		Case $Label4
			Run(@ComSpec & ' /c start mailto:correctlyincorrect@gmail.com', '', @SW_HIDE)
		Case $Label9
			Run(@ComSpec & ' /c start mailto:' & $Translink, '', @SW_HIDE)
		Case $Label5
			Run(@ComSpec & ' /c start ' & $Apppage & "issues/list", '', @SW_HIDE)
		Case $Button5
			Run('C:\Windows\Notepad.exe "Readme.txt" ')
		Case $Button6
			Run(@ComSpec & ' /c start ' & $Apppage, '', @SW_HIDE)
		Case $Combo1
			$Language = GUICtrlRead($Combo1)
			updatelang()
			GUICtrlSetData($Button1, Lang('lockafolder'))
			GUICtrlSetData($Button2, Lang('unlockselected'))
			GUICtrlSetData($Button3, Lang('changepassword'))
			GUICtrlSetData($Button4, Lang('exit'))
			GUICtrlSetData($Button5, Lang('openreadme'))
			GUICtrlSetData($Button6, Lang('visitwebpage'))
			GUICtrlSetData($Button7, Lang('Rescuefolder'))
			GUICtrlSetData($Button8, Lang('checkupdates'))
			GUICtrlSetData($tabi2, Lang('aboutlockafolder'))
			GUICtrlSetData($tabi1, Lang('pickatask'))
			GUICtrlSetData($tabi3, Lang('RescueCentre'))
			GUICtrlSetData($Label6, Lang('notinlist'))

			RegWrite("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "Lang", "REG_SZ", $Language)
		Case $Button7
			Local $Temp = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Hidden")
			Local $Temp1 = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "ShowSuperHidden")
			If $Temp = 2 Then
				RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Hidden", "REG_DWORD", 1)
				$Temp = 00
			EndIf
			If $Temp1 = 0 Then
				RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "ShowSuperHidden", "REG_DWORD", 1)
				$Temp1 = 00
			EndIf
			_Update_Explorer()
			Local $debug = UnLock(FileSelectFolder(Lang('chooseafolder'), "", 1, "", $WIN1))
_DebugOut($debug)
			If $Temp1 = 00 Then
				RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "ShowSuperHidden", "REG_DWORD", 0)
			EndIf
			If $Temp = 00 Then
				RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Hidden", "REG_DWORD", 2)
			EndIf
			_Update_Explorer()
		Case $Button8
			checkupdates()
	EndSwitch
WEnd
EndIf

Func updatelang()
	$Langslice = StringRegExpReplace($Language, '(\((.*?))\)', "")
	If $Language = "English" And $CmdLine[0] =0 Then
		GUICtrlSetPos($Label3, 12, 118, 405, 20)
		GUICtrlSetData($Label9,"")
	Else
		$Transby = IniRead($Langdir & '\' & $Langslice & '.ini', 'LocK-A-FoLdeR', "Translationby", '')
		$Translink = IniRead($Langdir & '\' & $Langslice & '.ini', 'LocK-A-FoLdeR', "authorlink", '')
		GUICtrlSetPos($Label3, 205, 98, 405, 20)
		GUICtrlSetData($Label9, $Language & " Translation By " & $Transby)
	EndIf
EndFunc

Func Lock($slected)
	Local $Temp,$TempFile
	If @error or $slected = "" Then Return("Empty selection/Cancel Pressed")
	If Not FileExists($slected) Then
		MsgBox(0, $AppName, $slected & " " & Lang('doesntexist'), 0, $WIN1)
		Return('doesntexist')
	EndIf
	_PathSplit($slected, $TempFile, $Temp, $Temp, $Temp)
	$Temp = DriveGetFileSystem($TempFile)
_DebugOut("DriveGetFileSystem = " & $Temp)
	If $Temp <> "NTFS" Then
		MsgBox(0, $AppName, $AppName & " only works with NTFS filesystem", 0, $WIN1)
		Return("notntfs")
	EndIf
	Local $l0ckd = RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders")
_DebugOut('RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders") = ' & $l0ckd)
	$Temp = StringInStr($l0ckd, $slected)
	If Not $Temp = 0 Then
		MsgBox(0, $AppName, $slected & " " & Lang('alreadyinlist'), 0, $WIN1)
		Return('alreadyinlist')
	EndIf
	If $CmdLine[0] = 0 Then
	GUICtrlSetData($List1, "")
	GUICtrlSetData($List1, Lang('plzwait') & "....")
	GUISetState(@SW_DISABLE)
	EndIf
	Local $user = _Security__LookupAccountSid("S-1-1-0")
_DebugOut("$user = " & $user[0])
	If @error Then Return("error processing SID")
	FileSetAttrib($slected, "-R+SH")
	If $winver = "XP" Then
_DebugOut("$winver = XP")

		Local $Proc = RunWait(@ComSpec & " /c " & @WindowsDir & "\system32\cacls.exe" & ' "' & $slected & '" /c ' & "/e /p " & $user[0] & ":n", "", @SW_HIDE)
_DebugOut("RunWait(cacls.exe) = " & $Proc)
	Else
		Local $Proc = RunWait(@ComSpec & " /c takeown /f " & ' "' & $slected & '" ' & " /r /d y & icacls" & ' "' & $slected & '" ' & "/deny " & $user[0] & ":F /c /q", "", @SW_HIDE)
_DebugOut("RunWait(icacls) = " & $Proc)
	EndIf
	ProcessWaitClose($Proc)
	If $CmdLine[0] = 0 Then GUISetState(@SW_ENABLE)
	$TempFile = _TempFile($slected)
_DebugOut("_TempFile() = " & $TempFile)
	$Temp = _FileCreate($TempFile)
_DebugOut("_FileCreate() = " & $Temp)
	Local $debug
	If $Temp = 1 Then
		$debug = FileDelete($TempFile)
_DebugOut("FileDelete() = " & $debug)
		$debug = FileSetAttrib($slected, "+R-SH")
_DebugOut("FileSetAttrib() = " & $debug)
		MsgBox(0, $AppName, $slected & " " & Lang('unable2lock'), 0, $WIN1)
		If $CmdLine[0] = 0 Then	Readfolders()
		Return('unable2lock')
	EndIf
	$l0ckd &= $slected & "|"
_DebugOut("$l0ckd &= $slected| = " & $l0ckd)
	$debug = RegWrite("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders", "REG_SZ", $l0ckd)
_DebugOut('RegWrite("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders", "REG_SZ", $l0ckd) = ' & $debug)
	If $CmdLine[0] = 0 Then Readfolders()
	Return("Done")
EndFunc   ;==>Lock

Func Readfolders()
	GUICtrlSetData($List1, "")
	GUICtrlSetData($List1, RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders"))
EndFunc   ;==>Readfolders

Func UnLock($slected)
	If $slected = "" Or @error Then
		MsgBox(0, $AppName, Lang('selectfirst'), 0, $WIN1)
		Return("Empty selection/Cancel Pressed")
	EndIf
	If $CmdLine[0] = 0 Then
	GUICtrlSetData($List1, "")
	GUICtrlSetData($List1, Lang('plzwait') & "....")
	GUISetState(@SW_DISABLE)
	EndIf
	Local $user = _Security__LookupAccountSid("S-1-1-0")
_DebugOut("$user = " & $user[0])
	If @error Then Return("error processing SID")
	If $winver = "XP" Then
_DebugOut("$winver = XP")
		Local $Proc = RunWait(@ComSpec & " /c " & @WindowsDir & "\system32\cacls.exe" & ' "' & $slected & '" /c ' & "/e /g " & $user[0] & ":f" & ' & cacls "'  & $slected & '" /c /t ' & "/e /r " & $user[0], "", @SW_HIDE)
_DebugOut("RunWait(cacls.exe) = " & $Proc)

	Else
		Local $Proc = RunWait(@ComSpec & " /c takeown /f" & ' "' & $slected & '" ' & "/r /d y & icacls" & ' "' & $slected & '" ' & "/reset /c /t /q", "", @SW_HIDE)
_DebugOut("RunWait(icacls) = " & $Proc)
	EndIf
	ProcessWaitClose($Proc)
	If $CmdLine[0] = 0 Then GUISetState(@SW_ENABLE)
	Local $TempFile = _TempFile($slected)
_DebugOut("_TempFile() = " & $TempFile)
	Local $Temp = _FileCreate($TempFile)
_DebugOut("_FileCreate() = " & $Temp)
	If $Temp = 0 Then
		MsgBox(0, $AppName, $slected & " " & Lang('unable2unlock'), 0, $WIN1)
		If $CmdLine[0] = 0 Then Readfolders()
		Return('unable2unlock')
	EndIf
	Local $debug = FileDelete($TempFile)
_DebugOut("FileDelete() = " & $debug)
	$debug = FileSetAttrib($slected, "+R-SH")
_DebugOut("FileSetAttrib() = " & $debug)
	Local $l0ckd = RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders")
_DebugOut('RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders") = ' & $l0ckd)
	$Temp = StringReplace($l0ckd, $slected & "|", "")
_DebugOut('StringReplace($l0ckd, $slected & "|", "")' & " = " & $Temp)
	$debug = RegWrite("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders", "REG_SZ", $Temp)
_DebugOut('RegWrite("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "lockedfolders", "REG_SZ", $l0ckd) = ' & $debug)
	If $CmdLine[0] = 0 Then Readfolders()
	Return("Done")
EndFunc   ;==>UnLock

Func getpass()
	Local $passwd = RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "EP")
;_DebugOut('RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "EP" = ' & $passwd & "|" & @error)
	If @error Then
	MsgBox(0, $AppName, "Unable to access Windows registry. Try to run application as administrator or reinstall application.", 0, $WIN1)
	Exit
	EndIf
	If $passwd = "" Or $passwd = "0" Then
		MsgBox(0, $AppName, Lang('alertmasterpass'), 0, $WIN1)
		changepass()
	Else
		Local $EP = _StringEncrypt(0, RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "EP"), "PaSwoRRD")
		Do
			$passwd = InputBox($AppName, Lang('entermasterpassword'), "", "*M", "250", "140", (@DesktopWidth - 191) / 2, (@DesktopHeight - 157) / 2, "", $WIN1)
			If @error Then Exit
			If $EP == $passwd Then ExitLoop
			MsgBox(0, $AppName, Lang('Invalidpass'), 0, $WIN1)
		Until $EP == $passwd
	EndIf
EndFunc   ;==>getpass

Func changepass()
	Local $passwd = InputBox($AppName, Lang('Enternewpassword'), "", "*M", "250", "140", (@DesktopWidth - 191) / 2, (@DesktopHeight - 157) / 2, "", $WIN1)
	If @error Then Exit
	Local $EP = _StringEncrypt(1, $passwd, "PaSwoRRD")
	RegWrite("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "EP", "REG_SZ", $EP)
	$passwd = RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "EP")
	$EP = _StringEncrypt(0, RegRead("HKEY_CURRENT_USER\SOFTWARE\" & $AppName, "EP"), "PaSwoRRD")
		Do
			$passwd = InputBox($AppName, Lang('entermasterpassword'), "", "*M", "250", "140", (@DesktopWidth - 191) / 2, (@DesktopHeight - 157) / 2, "", $WIN1)
			If @error Then Exit
			If $EP == $passwd Then ExitLoop
			MsgBox(0, $AppName, Lang('Invalidpass'), 0, $WIN1)
		Until $EP == $passwd
EndFunc   ;==>changepass
Func llist()
	Local $llist = ""
	Local $llistaray = _FileListToArray($Langdir, "*.ini", 1)
	If @error Then
		$Language = "English"
		Return($llist)
	Else
		for $i = 1 to UBound($llistaray,1) - 1
			Local $Temp = IniRead($Langdir & '\' & $llistaray[$i], 'LocK-A-FoLdeR', "Language","")
			$llist &= $llistaray[$i] & "(" & $Temp & ")|"
		Next
		$llist = StringReplace($llist, "()", "", 0)
		$llist = StringReplace($llist, ".ini", "", 0)
		$llist = StringReplace($llist, "English(English)|", "", 0)
		Return($llist)
	EndIf
EndFunc   ;==>llist

Func Lang($Lang)

	If $Language = "English" Then
		Switch $Lang
			Case "pickatask"
				Return "&Pick A Task"
			Case "lockafolder"
				Return "&Lock A Folder"
			Case "unlockselected"
				Return "&UnLock selected Folder"
			Case "changepassword"
				Return "&Change Master Password"
			Case "exit"
				Return "&Exit"
			Case "Aboutlockafolder"
				Return "About LocK-A-FoLdeR"
			Case "enternewpassword"
				Return "Enter New password"
			Case "entermasterpassword"
				Return "Enter Master password"
			Case "alreadyrunning"
				Return "is already running"
			Case "doesntexist"
				Return "doesn't exists"
			Case "chooseafolder"
				Return "Choose a folder to lock"
			Case "selectfirst"
				Return "please select a folder first"
			Case "alreadyinlist"
				Return "is already in list"
			Case "plzwait"
				Return "Please Wait"
			Case "unable2lock"
				Return "can't be locked"
			Case "unable2unlock"
				Return "can't be unlocked"
			Case "invalidpass"
				Return "Invalid password"
			Case "alertmasterpass"
				Return "Please choose a Master Password."
			Case "waitupdate"
				Return "Please wait update information is being downloaded ..."
			Case "nointernet"
				Return "There is some sort of problem with your internet connection"
			Case "checkupdates"
				Return "&Check for Updates"
			Case "openreadme"
				Return "Open &Readme file"
			Case "visitwebpage"
				Return "Visit &Webpage"
			Case "rescuecentre"
				Return "&Rescue Centre"
			Case "Rescuefolder"
				Return "&Rescue a folder"
			Case "notinlist"
				Return "Folders not in list can be unlocked from here."
		EndSwitch
	Else
		Return IniRead($Langdir & '\' & $Langslice & '.ini', 'LocK-A-FoLdeR', $Lang, 'nf')
	EndIf
EndFunc   ;==>Lang

Func checkupdates()
_DebugOut("Update Started")
	Local $Temp
	If FileExists(@ScriptDir & "\" & "updatesinstaller.exe") Then $Temp = MsgBox(4, $AppName, "It seems like update file is already downloaded." & @LF & "Do you want to run it now ?" , 0, $WIN1)
	If $Temp = 6 Then
		ShellExecute(@ScriptDir & "\" & "updatesinstaller.exe")
		Return("updatesinstaller.exe executed")
	EndIf
	Local $debug = FileDelete(@TempDir & "\" & "updates.ini")
_DebugOut('FileDelete(@TempDir & "\" & "updates.ini") = ' & $debug)
	GUISetState(@SW_DISABLE)
	GUICtrlSetData($Button8, "Please wait update information is being downloaded ...")
	$Temp = InetGet($updatefile, @TempDir & "\" & "updates.ini", 1, 0)
_DebugOut('InetGet("updates.ini") = ' & $Temp)
	$debug = InetClose($Temp)
_DebugOut('InetClose($Temp) = ' & $debug)
	$Temp = IniRead(@TempDir & "\" & "updates.ini", "LocK-A-FoLdeR", "newVersionavailable", "notfound")
_DebugOut('IniRead(updates.ini) = ' & $Temp)
	If $Temp = "notfound" Then
_DebugOut("notfound")
		MsgBox(0, $AppName, "There is some sort of problem with your internet connection", 0, $WIN1)
		GUICtrlSetData($Button8, Lang('checkupdates'))
		GUISetState(@SW_ENABLE)
		Return("notfound")
	EndIf
	GUICtrlSetData($Button8, "Downloading Update ...")
_DebugOut("Downloading Update")
	Local $Temp1 = IniRead(@TempDir & "\" & "updates.ini", "LocK-A-FoLdeR", "newVersionlink", "")
_DebugOut('IniRead(updates.ini,newVersionlink) = ' & $Temp1)
	Local $len = InetGetSize($Temp1, 1)

	Local $len1 = Int($len / 2 ^ 10)

	Local $slected = Round($len / 2 ^ 20, 2)
	If $Temp > $AppVer Then
		$Temp = MsgBox(4, $AppName, "A new version is available @" & $Apppage & @LF & "Do you want to download it now ?" & @LF & "Filesize = " & $len1 & "KB \ " & $slected & "MB", 0, $WIN1)
	Else
		MsgBox(0, $AppName, "No update found", 0, $WIN1)
	EndIf
	If $Temp = 6 Then
		$Temp = InetGet($Temp1, @ScriptDir & "\" & "updatesinstaller.exe", 1, 1)
_DebugOut('InetGet(updatesinstaller.exe) = ' & $Temp)
		ProgressOn("Download progress", "Downloading update file ", "0 %")
		For $i = 1 To $len Step 1
			$Temp1 = InetGetInfo($Temp)
_DebugOut('InetGetInfo($Temp) = ' & $Temp1)
			Local $EP = Round($Temp1[0] * 100 / $len, 2)
			ProgressSet($EP, $EP & " %")
			If InetGetInfo($Temp, 2) Then
				$debug = InetClose($Temp)
_DebugOut('InetClose($Temp) = ' & $debug )
				ExitLoop
			Else
				ContinueLoop
			EndIf
		Next
		ProgressSet(100, "100%", "Download completed.")
		ProgressOff()
		If FileExists(@ScriptDir & "\" & "updatesinstaller.exe") Then
			MsgBox(0, "", "File Downloaded @ " & @ScriptDir & "\" & "updatesinstaller.exe", 0, $WIN1)
_DebugOut("Executing updatesinstaller.exe" )
		$Temp = MsgBox(4, $AppName, "Do you want to start update now ?" & @LF & "Filesize = " & $len1 & "KB \ " & $slected & "MB", 0, $WIN1)
		If $Temp = 6 Then
			Sleep(500)
			$debug = ShellExecute(@ScriptDir & "\" & "updatesinstaller.exe")
_DebugOut('ShellExecute("updatesinstaller.exe") = ' & $debug )
		Else
			Return
		EndIf
		Else
			MsgBox(0, "", "Update Failed", 0, $WIN1)
		EndIf
		GUICtrlSetData($Button8, Lang('checkupdates'))
		GUISetState(@SW_ENABLE)
	Else
		GUICtrlSetData($Button8, "&Check for Updates")
		GUISetState(@SW_ENABLE)
		Return
	EndIf
EndFunc   ;==>checkupdates

Func _Update_Explorer()
	Local $Temp = Opt("WinSearchChildren", True)
	Local $Temp1 = WinList("[CLASS:SHELLDLL_DefView]")
	For $i = 0 To UBound($Temp1) - 1
		DllCall("user32.dll", "long", "SendMessage", "hwnd", $Temp1[$i][1], "int", 0x111, "int", 28931, "int", 0)
	Next
	Opt("WinSearchChildren", $Temp)
EndFunc   ;==>_Update_Explorer
