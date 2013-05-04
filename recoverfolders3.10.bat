@ECHO OFF
ECHO "This script will try to reveal and unlock Folders Locked by LocK-A-FoLdeR 3.10<"
Pause
reg delete HKEY_CLASSES_ROOT\CLSID\{90F8C996-7C70-4331-9D70-FB357D559FD5} /f
set regpath=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
set regvalue=Hidden
set regdata=2
reg query "%regpath%" /v "%regvalue%" | find /i "%regdata%"

IF errorlevel 1 goto :hide
    Reg add "%regpath%" /v Hidden /t REG_DWORD /d 1 /f
    Reg add "%regpath%" /v HideFileExt /t REG_DWORD /d 0 /f
    Reg add "%regpath%" /v ShowSuperHidden /t REG_DWORD /d 1 /f
    goto :end
:hide
    Reg add "%regpath%" /v Hidden /t REG_DWORD /d 2 /f
    Reg add "%regpath%" /v HideFileExt /t REG_DWORD /d 1 /f
    Reg add "%regpath%" /v ShowSuperHidden /t REG_DWORD /d 0 /f
:end