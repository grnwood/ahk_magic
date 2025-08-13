#Requires AutoHotkey v2.0-a

#SingleInstance Force
SetKeyDelay(-1)

; Globals
global inputNumber := " "
global modal := false
global shifton := false
global MyGui

; Custom Hotkeys

; Ctrl + Shift + i sends Insert
^+i:: Send("{Insert}")

; Clipboard modification for Zim tasks label swapping
^+2:: {
    MsgBox(clipboard)
    clipboard := StrReplace(clipboard, "@todo", "@wait")
}

^+1:: {
    MsgBox("replace")
    clipboard := StrReplace(clipboard, "@wait", "@todo")
}

; Long press on semicolon to call vimize, otherwise send semicolon
$`;:: {
    if !KeyWait("`;","T0.5") {
        vimize()
        KeyWait("`;")
    } else {
        Send("`;")
    }
}

; CapsLock toggles between modes
CapsLock:: {
    if (!modal) {
        vimize()
    } else {
        unvimize()
    }
}

; Functions to Enter and Exit Vim mode
vimize() {    ;; Enter Vim mode
    global modal
    global MyGui
    modal := true
    MyGui := Gui()
    MyGui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
    MyGui.BackColor := "EEAA99"  ; Can be any RGB color (it will be made transparent below).
    MyGui.SetFont("s32")  ; Set a large font size (32-point).
    CoordText := MyGui.Add("Text", "cYellow", "（︶︿︶）")  ; XX & YY serve to auto-size the window.

    ; Make all pixels of this color transparent and make the text itself translucent (150):
    WinSetTransColor(MyGui.BackColor " 150", MyGui)
    ; Calculate the center position, 10 pixels from the top
    centerX := (A_ScreenWidth - 350 ) // 2
    MyGui.Show("x" centerX " y5 NoActivate")  ; NoActivate avoids deactivating the currently active window.
	
}

unvimize() {  ;; Exit Vim mode
    global modal, MyGui
    modal := false
    MyGui.Destroy()
    resetInputNumber()
}

resetInputNumber() {
    global inputNumber
    inputNumber := " "
}

; Mode-Specific Hotkeys (only active in modal mode)
#HotIf modal

!Enter:: Send("{LWin Down}{Tab}{LWin Up}")

Esc:: unvimize()

; Delete key on 'd', shift deletes whole line
d:: Send("{Del}")
+d:: Send("{Home}{Shift Down}{End}{Shift Up}{Del}{Home}")

; Cut and Paste
c::Send("^c")  ; Remaps 'c' to Ctrl+C
p::Send("^v")  ; Remaps 'p' to Ctrl+V

+u::Send("{Shift Down}{Up}{Shift Up}")      ; Shift+U to Shift+Up
+n::Send("{Shift Down}{Down}{Shift Up}")    ; Shift+N to Shift+Down

; undo and redo
u::Send("^z")  ; Remaps 'u' to Ctrl+Y
r::Send("^y")  ; Remaps 'u' to Ctrl+Y


; end and front of lines
`;:: Send("{End}")
a:: Send("{Home}")
+`;::Send("{Shift Down}{End}{Shift Up}")  ; Shift+; to Shift+End

; Navigation keys like Vim
h:: Send("{Left}")
l:: Send("{Right}")
+k:: Send("{PgUp}")
k:: Send("{Up}")
j:: Send("{Down}")
+j:: Send("{PgDn}")

; Control arrows on 'Alt' (e.g., Alt-j is Alt-down)
!k:: Send("!{Up}")
!j:: Send("!{Down}")
!h:: Send("!{Left}")
!l:: Send("!{Right}")

; Mouse movement
^+j::MouseMove(0, 100, 0, "R")  ; Ctrl+Shift+J moves the mouse 10 pixels up
^+k::MouseMove(0, -100, 0, "R")  ; Ctrl+Shift+J moves the mouse 10 pixels up
^+h::MouseMove(-100, 0, 0, "R")  ; Ctrl+Shift+K moves the mouse 10 pixels left
^+l::MouseMove(100, 0, 0, "R")  ; Ctrl+Shift+K moves the mouse 10 pixels left

; SPECIAL hot key to get me 'Copy Link To Location' in zim
^+c::
{
    MouseClick("right", , , 1, 0)
}


#HotIf  ; End of mode-specific hotkeys

