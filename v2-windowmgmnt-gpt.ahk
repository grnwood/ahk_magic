#Requires AutoHotkey v2.0

; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetTitleMatchMode(2)

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
{
    if WinExist(mobilepass) {
        WinKill(mobilepass)
    }
    RunWait("pythonw.exe c:/Users/jogreenw/code/python/mobilepass/pingid.py", "c:/Users/jogreenw/code/python/mobilepass/")
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
        Run("C:\Users\jogreenw\zim\zim.exe")
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
!2::
{
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
    }return
}

; fire up keepass
!c::
{
    wdw := WinExist("ahk_exe KeePass.exe")
    if wdw {
        if WinActive(wdw)
            WinMinimize()
        else
            WinActivate()
    } else {
        Suspend(true)
        Send("!c")
        Suspend(false)
    }
	return
}

!\::
{
    if WinActive(zimtasks)
        WinActivate(zim)
    else
        WinActivate(zimtasks)
		return
}

; alt-r to do ctrl-5 (h5 heading in zim)
!r::
{
    if WinActive(zim) {
        Send("{Control down}5{Control up}")
    }
	return
}

+^`::
{
    if WinActive(zimtasks)
        WinActivate(zim)
    else
        WinActivate(zimtasks)
	return
}

; todoist window on ctrl-\
^\::
{
    if WinActive(todoist)
        WinMinimize(todoist)
    else
        WinActivate(todoist)
	return
}

; Change zim task to bullets
^F12::
{
    Send("{Home}{Home}{Shift down}{End}{Shift up}!mt")
    Send("{End}")
	return
}


