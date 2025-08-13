#Requires AutoHotkey v2.0

; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetTitleMatchMode(2)

zim := "- WorkNotes2025"
mobilepass := "MobilePASS"
;zim := "WorkNotesObs - Obsidian"
zim_personal := "BujoObs"
zimtasks := "Tasks  -"
todoist := "Todoist"
mailapp := "Outlook (PWA)"
mailappfat := "ahk_exe OUTLOOK.EXE"

;lets automate my mobilepass python script
!q::
{
    if WinExist(mobilepass) {
        WinKill(mobilepass)
    }
    RunWait("pythonw.exe c:/Users/jogreenw/code/python/mobilepass/pingid.py", "c:/Users/jogreenw/code/python/mobilepass/")
	return
}	

^!Down:: {
    Send("{LAlt down}{Tab}")
    ;Send("{LAlt up}")
}

;;; ctrl-alt-up is like expose windows-tab
^!Up:: {
    Send("{LWin Down}{Tab}{LWin Up}")
    return
}

; switch desktops
![::
{
    Send("{LWin down}{LCtrl down}{Left down}")
    Send("{LWin up}{LCtrl up}{Left up}")
	return
}

!]::
{
    Send("{LWin down}{LCtrl down}{Right down}")
    Send("{LWin up}{LCtrl up}{Right up}")
	return
}

; task switcher
!BackSpace::
{
    Send("{LWin Down}{Tab}{LWin Up}")
	return
}

; Hot key desktop switch
<^<!Left::
{
    Send("{LWin down}{LCtrl down}{Left down}")
    Send("{LWin up}{LCtrl up}{Left up}")
	return
}

<^<!Right::
{
    Send("{LWin down}{LCtrl down}{Right down}")
    Send("{LWin up}{LCtrl up}{Right up}")
	return
}

<^<!Down::
{
    Send("{LWin down}{tab down}")
    Send("{LWin up}{tab up}")
	return
}

!x::WinMinimize("A")
!z::WinClose("A")

;!SPACE::WinSet("AlwaysOnTop", "Toggle", "A")

; Alt navs in vim mode
<!h::  ; Alt + H
{
    Send("!{Left}")  ; Sends Alt + Left Arrow
    return
}

<!l::  ; Alt +L
{
    Send("!{Right}")  ; Sends Alt + Right Arrow
    return
}

<!k::  ; Alt +L
{
    Send("!{Up}")  ; Sends Alt + Up Arrow
    return
}

<!j::  ; Alt +j
{
    Send("!{Down}")  ; Sends Alt + Up Arrow
    return
}

; zim on control-`
^`::
{
    DetectHiddenWindows(true)
    if WinExist(zim) {
        if WinActive(zim) {
            WinMinimize(zim)
            ;WinActivate("ahk_class Shell_TrayWnd")
        } else {
            WinShow(zim)
            WinActivate(zim)
        }
    } else {
        Run("C:\Users\jogreenw\programs\zim\zim.exe")
        ;Run("c:\msys64\mingw64\bin\python3w-msys.exe C:\Users\jogreenw\code\zim-desktop-wiki\zim.py")
        DetectHiddenWindows(false)
    }return
}

; fire up chrome app versions of outlook mail on Alt-1
!1::
{
    mode := "fat-client-notused"
    if (mode = "fat-client") {
        wdw := WinExist("ahk_exe OUTLOOK.EXE")
    } else {
        wdw := WinExist(mailapp)
        if (!wdw) {
            wdw := WinExist(mailappfat)
        }
    }
    if wdw {
        if WinActive(wdw)
            WinMinimize()
        else
            WinActivate()
    } else {
        Suspend(true)
        Send("!1")
        Suspend(false)
    }return
}

; fire up teams on Alt-2
; Try to target the 'Chat' window first, otherwise fail to anything teams exe.
!2::
{
    wdw := WinExist("Chat |")
    if wdw {
        if WinActive(wdw)
            WinMinimize()
        else
            WinActivate()
    } else {
	wdw := WinExist("ahk_exe ms-teams.exe")
	if wdw {
		if WinActive(wdw)
			WinMinimize()
		else
			WinActivate()
	} else {
		Suspend(true)
		Send("!2")
		Suspend(false)
	}
    }
  return
}

; Fire up AI with Alt+3 shortcut
; Try to target the specific 'SlipStreamAI' window first. Minimize if already active, otherwise activate it.
; If not running, run the Python script.
!3::
{
SetTitleMatchMode "2"
    wdw := WinExist("SlipStreamAI")
    if wdw {
       if WinActive(wdw)
          WinMinimize(wdw)
       else
       	WinActivate(wdw)
    } else {
        Run 'wsl cd /home/jgreenwood/code/ai-stuff && venv/bin/python ask-client/ask-client.py'
    }
}

; alt-r to do ctrl-5 (h5 heading in zim)
!r::
{
    if WinActive(zim) {
        Send("{Control down}5{Control up}")
    }
	return
}


; Change zim task to bullets
^F12::
{
    Send("{Home}{Home}{Shift down}{End}{Shift up}!mt")
    Send("{End}")
	return
}


; Define a variable to track the state of the mouse buttons
leftRightClicked := false

; Set a timer to check the state of the mouse buttons
SetTimer CheckMouseButtons, 10

CheckMouseButtons() {
    global leftRightClicked
    
    ; Check if both the left and right mouse buttons are pressed
    if (GetKeyState("LButton", "P") && GetKeyState("RButton", "P")) {
        ; If not already clicked, simulate Windows Key + Tab
        if (!leftRightClicked) {
            Send("{LWin Down}{Tab Down}")
            Send("{Tab Up}{LWin Up}")
            leftRightClicked := true
        }
    } else {
        leftRightClicked := false
    }
}
