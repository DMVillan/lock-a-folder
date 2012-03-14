; LocK-A-FoLdeR 3.10.2
; © 2011 Gurjit Singh.
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;   http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
;
  !include "MUI2.nsh"
  !include "LogicLib.nsh"
  !include "x64.nsh"  
   !define MUI_NAME "LocK-A-FoLdeR"
   !define MUI_VER "3.10.2"
   !define MUI_LINK "http://code.google.com/p/lock-a-folder"
   !define APPFILE "lock-a-folder.exe"
   !define OUTFILE "${MUI_NAME}-V${MUI_VER}.exe"
   !define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
   !define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\orange.bmp"
  !define MUI_HEADERIMAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Header\orange-uninstall.bmp"
VIAddVersionKey "ProductName" "${MUI_NAME}"
VIAddVersionKey "LegalCopyright" "© Gurjit Singh"
VIAddVersionKey "FileVersion" "${MUI_VER}"
  VIAddVersionKey "CompanyName" "Gurjit Singh"
VIAddVersionKey "Filedescription" "${MUI_NAME} ${MUI_VER}"
VIAddVersionKey "ProductVersion" "${MUI_VER}"
VIAddVersionKey "OriginalFilename" "${OUTFILE}"
VIProductVersion "${MUI_VER}.0.0"
Var alreadyinstalled
Var tempvar
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
Name "${MUI_NAME}"
  OutFile "${OUTFILE}"
  BrandingText /TRIMLEFT "${MUI_NAME} ${MUI_VER}"
  InstallDir "$PROGRAMFILES\${MUI_NAME}"
  InstallDirRegKey HKCU "Software\${MUI_NAME}" ""
ShowInstDetails nevershow
ShowUninstDetails nevershow
CRCCheck On
AutoCloseWindow True
XPStyle On
  !define MUI_ABORTWARNING
  !insertmacro MUI_PAGE_LICENSE "License-AL2.0.txt"
  !insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_LINK "Visit ${MUI_NAME} site for the latest Updates."
!define MUI_FINISHPAGE_LINK_LOCATION "${MUI_LINK}"
!define MUI_FINISHPAGE_RUN "$INSTDIR\${APPFILE}"
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Create StartMenu and Desktop Shortcuts"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CREATESHORTCUTSM
!insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"

!define SHCNE_ASSOCCHANGED 0x08000000
!define SHCNF_IDLIST 0
 
Function .onInit
ReadRegStr $tempvar HKCU "Software\${MUI_NAME}" "lockedfolders"
Strcmp $tempvar '' not 0
MessageBox MB_YESNO "${MUI_NAME} 3.10.2 is not Backward compatible.$\nDo you want to Unlock Previously Locked folders first ?" IDYES 0 IDNO +5
ReadRegStr $tempvar HKCU "Software\${MUI_NAME}" "Install Dir"
Execwait '"$tempvar\${APPFILE}" /ukall'
Abort "Folders Unlocked Successfully"
goto +2
Abort
start:
FindProcDLL::FindProc "${APPFILE}"
IntCmp $R0 1 0 notRunning
MessageBox MB_YESNO "${MUI_NAME} is already running. Do you want to close it first ?$\nHitting NO will force Installer to quit " IDYES 0 IDNO exit
KillProcDLL::KillProc "${APPFILE}"
notRunning:
ReadRegStr $alreadyinstalled  HKCU "Software\${MUI_NAME}" "Install Dir"
IfFileExists $alreadyinstalled\Uninstall.exe 0 Not
strcmp $alreadyinstalled "" not
messagebox MB_YESNO "Do you want to Uninstall previous version first ?$\nHitting NO will force Installer to quit" IDYES 0 IDNO exit
Execwait '$alreadyinstalled\uninstall.exe _?=$alreadyinstalled'
goto start
exit:
Abort
not:
functionend

Function un.onInit

FindProcDLL::FindProc "${APPFILE}"
IntCmp $R0 1 0 notRunning
MessageBox MB_YESNO "${MUI_NAME} is already running. Do you want to close it first ?$\nHitting NO will force Installer to quit " IDYES 0 IDNO exit
KillProcDLL::KillProc "${APPFILE}"
notRunning:
ReadRegStr $tempvar HKCU "Software\${MUI_NAME}" "lockedfolders"
Strcmp $tempvar '' not 0
MessageBox MB_YESNO "Some versions are not Backward compatible.$\nDo you want to Unlock Previously Locked folders first ?" IDYES 0 IDNO +4
ReadRegStr $tempvar HKCU "Software\${MUI_NAME}" "Install Dir"
Execwait '"$tempvar\${APPFILE}" /ukall'
Abort
return
exit:
Abort
not:
functionend

Function CREATESHORTCUTSM
    CreateDirectory "$SMPROGRAMS\${MUI_NAME}"
    CreateShortCut "$SMPROGRAMS\${MUI_NAME}\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
   CreateShortCut "$SMPROGRAMS\${MUI_NAME}\${MUI_NAME}.lnk" "$INSTDIR\${APPFILE}"
   CreateShortCut "$SMPROGRAMS\${MUI_NAME}\Readme.lnk" "$INSTDIR\Readme.txt"
   CreateShortCut "$DESKTOP\${MUI_NAME}.lnk" "$INSTDIR\${APPFILE}"
functionend

Section "Components"
  SetOutPath "$INSTDIR"
    File "Readme.txt"
	File "NOTICE.txt"
	File "LICENSE.txt"	
    File "COPYING.TXT"
    File "Changes.TXT"	
    File "${APPFILE}"
	SetOutPath "$INSTDIR\Lang"
	File "Lang\*.*"
	  SetOutPath "$INSTDIR"
  WriteRegStr HKCU "Software\${MUI_NAME}" "Install Dir" $INSTDIR
  ${If} ${RunningX64}
    SetRegView 64
  ${EndIf}
 WriteRegStr HKCR "CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5}" "" "Lock-A-Folder"
 WriteRegStr HKCR "CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5}" "InfoTip" "Locked Folder"
 WriteRegStr HKCR "CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5}" "NeverShowExt" ""
 WriteRegStr HKCR "CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5}\DefaultIcon" "" "$INSTDIR\${APPFILE},0"
 WriteRegStr HKCR "CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5}\Shell" "" "Open"
 WriteRegStr HKCR "CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5}\Shell\Explore" "" ""  
 WriteRegStr HKCR "CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5}\Shell\Open" "" ""  
  ${If} ${RunningX64}
   SetRegView 32
  ${EndIf}
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_NAME}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_NAME}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_NAME}" "DisplayName" "${MUI_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_NAME}" "DisplayIcon" "$INSTDIR\${MUI_NAME}.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_NAME}" "DisplayVersion" "${MUI_VER}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_NAME}" "HelpLink" "${MUI_LINK}"
  WriteRegStr HKCU "Software\${MUI_NAME}" "EP" ""

  System::Call 'shell32.dll::SHChangeNotify(i, i, i, i) v \
  (${SHCNE_ASSOCCHANGED}, ${SHCNF_IDLIST}, 0, 0)'  
SetAutoClose true
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\Readme.txt"
  Delete "$INSTDIR\NOTICE.txt"
  Delete "$INSTDIR\LICENSE.txt"
  Delete "$INSTDIR\Uninstall.exe"
  Delete "$INSTDIR\COPYING.TXT"
  Delete "$INSTDIR\Changes"
  Delete "$INSTDIR\${APPFILE}"
  Delete "$INSTDIR\Lang\*.*"
  RMDir "$INSTDIR\Lang"
  Delete "$INSTDIR\*.*"  
  RMDir "$INSTDIR"
   Delete "$SMPROGRAMS\${MUI_NAME}\${MUI_NAME}.lnk"    
   Delete "$SMPROGRAMS\${MUI_NAME}\Readme.lnk"
  Delete "$SMPROGRAMS\${MUI_NAME}\Uninstall.lnk"
  Delete "$DESKTOP\${MUI_NAME}.lnk"  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_NAME}"
    RMDir "$SMPROGRAMS\${MUI_NAME}"
  DeleteRegvalue HKCU "Software\${MUI_NAME}" "EP"
  DeleteRegvalue HKCU "Software\${MUI_NAME}" "Install Dir"
SetAutoClose true
SectionEnd