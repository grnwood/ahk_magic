#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Launch console if necessary; hide/show on Win+`
;You can coustomise this by yourself #=Win, !=Alt, ^=Ctrl, +=Shift, see (http://www.autohotkey.com/docs/Hotkey.htm - http://www.autohotkey.com/docs/KeyList.htm )

^`::
DetectHiddenWindows, on

IfWinExist ahk_class gdkWindowToplevel
{
	IfWinActive ahk_class gdkWindowToplevel
		{
			WinMinimize ahk_class gdkWindowToplevel
			;WinActivate ahk_class Shell_TrayWnd
		}
	else
		{
			WinShow ahk_class gdkWindowToplevel
			WinActivate ahk_class gdkWindowToplevel
		}
}
else
		
		; QuakeConsole.ahk (or QuakeConsole.exe if you don't have autohotkey instaled in your system) must be in the same folder as console.exe
		; -c <xxxx.xml> settings file for console2, if empty then  use console.xml
		; -w title of console2 window
		; -t Specifies a startup tab ;  tab must be defined in Console settings. There are 4 definied tabs in QuakeConsole.xml : cmd=cmd.exe(Ctrl+F1), ps=powershell.exe(Ctrl+F2), bash="x:\Cygwin\Cygwin.bat"(Ctrl+F3), telnet=telnet.exe(Ctrl+F4)
		; -d Specifies a startup directory
		
	Run "C:\Program Files (x86)\Zim Desktop Wiki\zim.exe"

DetectHiddenWindows, off
return

;hide console on "esc".
#IfWinActive ahk_class gdkWindowToplevel
esc::
	{
		WinMinimize ahk_class gdkWindowToplevel
		;WinActivate ahk_class Shell_TrayWnd
	}
return



