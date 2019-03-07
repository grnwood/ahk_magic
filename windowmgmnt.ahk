;Env  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 3


!x::WinMinimize,A ;
!z::WinClose,A ;
!SPACE::WinSet, AlwaysOnTop, Toggle, A

;# skype quake on ctrl-1
^1::
skype := WinExist("ahk_exe Skype.exe")
if WinActive(%skype%)
	WinMinimize ;
else
	WinActivate ;
return


^`::
DetectHiddenWindows, on

zim := "Notes2 - Zim"

IfWinExist, %zim%
{
	IfWinActive, %zim%
		{
			WinMinimize, %zim%
			;WinActivate ahk_class Shell_TrayWnd
		}
	else
		{
			WinShow, %zim%
			WinActivate, %zim%
			IfWinExist, %zim%
			    WinActivate ; use the window found above

		}
} else {
			
	Run "C:\Program Files (x86)\Zim Desktop Wiki\zim.exe"

	DetectHiddenWindows, off
	return
}
return

+^`::
	IfWinActive Task List - Zim
		WinActivate, %zim%
	else
		WinActivate, Task List - Zim
return

!c::
IfWinExist ahk_exe KeePass.exe
{
	IfWinActive ahk_exe KeePass.exe
		WinMinimize, ahk_exe KeePass.exe 
	else
		WinActivate, ahk_exe KeePass.exe
	return
} else {
	Run "C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe"
	DetectHiddenWindows, off
	return
}
return

;#~LButton & RButton::send, {lalt down}{lctrl down}{tab}{lalt up}{lctrl up}

;# Left click then right click mouse show win-tab task switcher
~LButton & RButton::  ;or ~MButton & XButton
Send, {LWinDOWN}{Tab}
SetTimer, Send_LWinUP, 500
return
 
Send_LWinUP:
KeyWait, MButton, L 
SetTimer, Send_LWinUP, off
Send, {LWinUP}
return

;Change zim task to bullets
^F12::
Send, {Home}{Home}{Shift down}{End}{Shift up}!mt
return

