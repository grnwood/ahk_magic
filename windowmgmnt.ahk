;Env  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2

zim := "- WorkNotes2022"
mobilepass := "MobilePASS"
;zim := "WorkNotesObs - Obsidian"
zim_personal := "BujoObs"
zimtasks := "Tasks  -"
todoist := "Todoist"
mailapp := "Outlook (PWA)"
mailappfat := "ahk_exe OUTLOOK.EXE"

;lets automate my mobilepass python script
!q::
if WinExist(%mobilepass%) {
	WinKill %mobilepass%
}
RunWait, pythonw.exe c:/Users/jogreenw/code/python/mobilepass/pingid.py, c:/Users/jogreenw/code/python/mobilepass/
return

;;; switch desktops
![::
	Send, {LWin down}{LCtrl down}{Left down}
	Send, {LWin up}{LCtrl up}{Left up}
return

!]::
	Send, {LWin down}{LCtrl down}{Right down}
	Send, {LWin up}{LCtrl up}{Right up}
return

;;; task switcher
!BackSpace::
	;MsgBox, "alt backspace hit"
	Send, {LWin Down}{Tab}{LWin Up}
return

; Hot key desktop switch
<^<!Left::
	;MsgBox 'ctrl alt left'
	Send, {LWin down}{LCtrl down}{Left down}
	Send, {LWin up}{LCtrl up}{Left up}
return
<^<!Right::
	;MsgBog 'ctrl alt left'
	Send, {LWin down}{LCtrl down}{Right down}			
	Send, {LWin up}{LCtrl up}{Right up}	
return
<^<!Down::	
	;MsgBox 'ctrl alt left'
	Send, {LWin down}{tab down}
	Send, {LWin up}{tab up} 
return

!x::WinMinimize,A ;
!z::WinClose,A ;
;!SPACE::WinSet, AlwaysOnTop, Toggle, A

;skype on ctrl-1
^1::
far := WinActive("ahk_exe Far.exe")
If (far) {
    Send {F9}cd1
    return
} else {
	;regular skype use this
	skype := "Skype"

	;win10 native app use this
	;skype := "ahk_exe ApplicationFrameHost.exe"

	SetTitleMatchMode,2
	IfWinExist, %skype%
	{
		IfWinActive, %skype%
			{
				WinMinimize, %skype%
				;WinActivate ahk_class Shell_TrayWnd
			}
		else
			{
				WinActivate, %skype%
			}
	}

}
return

;zim on control-`
^`::
DetectHiddenWindows, on
IfWinExist, %zim%
{
;MsgBox, 'wdw  %wdw%'
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

	Run C:\Users\jogreenw\zim\zim.exe 
	;Run c:\msys64\mingw64\bin\python3w-msys.exe C:\Users\jogreenw\code\zim-desktop-wiki\zim.py

	DetectHiddenWindows, off
	return
}
return

;personal zim on control-escape (override windows)
$^escape::
DetectHiddenWindows, on
IfWinExist, %zim_personal%
{
;MsgBox, 'wdw  %wdw%'
	IfWinActive, %zim_personal%
		{
			WinMinimize, %zim_personal%
			;WinActivate ahk_class Shell_TrayWnd
		}
	else
		{
			WinShow, %zim_personal%
			WinActivate, %zim_personal%
			IfWinExist, %zim_personal%
			    WinActivate ; use the window found above

		}
} else {

	Run C:\Users\jogreenw\zim\zim.exe 
	;Run c:\mingw64\bin\python3w-msys.exe C:\Users\jogreenw\code\zim-desktop-wiki-grnwood\zim.py

	DetectHiddenWindows, off
	return
}
return

;fire up chrome app versions of outlook mail on Alt-1
!1::

; set to '' for web client
; mode := "fat-client-notused"
mode := "fat-client-notused"

if (mode = "fat-client") {
  wdw := WinExist("ahk_exe OUTLOOK.EXE")
} else {
	wdw := WinExist(mailapp)
	if (!wdw) {
	  wdw := WinExist(mailappfat)
	}
}
if (wdw) {
  if WinActive(%wdw%)
	WinMinimize ;
  else
	WinActivate ;
} else {
   Suspend, On
   Send, !1
   Suspend, Off
}
return

;fire up teams on Alt-2
!2::
wdw := WinExist("ahk_exe Teams.exe")
if (wdw) {
  if WinActive(%wdw%) 
     WinMinimize ;
    else
     WinActivate ;
} else {
   Suspend, On
   Send, !2
   Suspend, Off
   
}
return

;fire up keepbass
!c::
wdw := WinExist("ahk_exe KeePass.exe")
if (wdw) {
  if WinActive(%wdw%) 
     WinMinimize ;
    else
     WinActivate ;
} else {
   Suspend, On
   Send, !c
   Suspend, Off
}
return


;fire up chrome app versions of outlook mail on Alt-1
;!`::
;wdw := WinExist("ahk_exe OUTLOOK.EXE")
;MsgBox, 'wdw  %wdw%'
;if (wdw) {
; if WinActive(%wdw%)
;	WinMinimize ;
;  else
;     WinActivate ;
;} else if (%wdw%) {
;    if WinActive(%wdw%);
;	WinMinimize ;
;     else
;       WinActivate ;
;} else {
;   Suspend, On
;   Send, !1
;  Suspend, Off
;}
;return

!\::
IfWinActive %zimtasks%
  WinActivate, %zim%
else
 WinActivate, %zimtasks%
return

;alt-r to do ctrl-5 (h5 heading in zim)
!r::
IfWinActive, %zim%
{
   Send, {Control down}5{Control up}	
}
return

+^`::
IfWinActive %zimtasks%
  WinActivate, %zim%
else
 WinActivate, %zimtasks%
return

;todoist window on ctrl-\
^\::
IfWinActive %todoist%
  WinMinimize, %todoist%
else
  WinActivate, %todoist%
return

;Change zim task to bullets
^F12::
Send, {Home}{Home}{Shift down}{End}{Shift up}!mt
Send, {End}
return

;ctrl-alt-l: gimme copy url to this location in zim (cannot do it in zim hotkeys)
^!l::
Send, {Right}
Click, right, %A_CaretX%, %A_CaretY%
Sleep, 100
;Send, {Down}{Down}{Enter}
;Send, {Left}
return

;zim up and down keys
;+^Up::
;IfWinActive, %zim% 
;{
; Send {HOME 2}+{END}^x{Delete}{Up}^v{Enter}{Up}
;}
;return
  
;+^Down::
;IfWinActive, %zim% 
;{
;	Send {HOME 2}+{END}^x{Delete}{Down}^v{Enter}{Up}jjkkjj
;}
;return


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

;OUTLOOK reminder windows
;TrayTip Script, Looking for Reminder window to put on top, , 16
;SetTitleMatchMode  2 ; windows contains
;loop {
;  WinWait, Reminder(s), 
;  WinSet, AlwaysOnTop, on, Reminder(s)
;  WinRestore, Reminder(s)
;  TrayTip Outlook Reminder, You have an outlook reminder open, , 16
;  WinWaitClose, Reminder(s), ,30
;}
;return

;onenote horizontal scrolling
#IfWinActive ahk_exe onenote.exe
~LShift & WheelUp:: ; Scroll left.
ControlGetFocus, control, A
SendMessage, 0x114, 0, 0, %control%, A ; 0x114 is WM_HSCROLL
return

~Lshift & WheelDown:: ; Scroll right.
ControlGetFocus, control, A
SendMessage, 0x114, 1, 0, %control%, A ; 0x114 is WM_HSCROLL
return

