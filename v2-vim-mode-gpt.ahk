#Requires AutoHotkey v2.0-a

;#Persistent
#SingleInstance Force
SetKeyDelay(-1)

;; globals
global inputNumber := " "
global modal := false
global shifton := false

; kinesys freestyle, need an insert on ctrl/shift/i
^+i:: {
    Send("{Insert}")
    return
}

; Zim tasks label swapping
^+2:: {
    MsgBox(clipboard)
    clipboard := StrReplace(clipboard, "@todo", "@wait")
    return
}

^+1:: {
    MsgBox("replace")
    clipboard := StrReplace(clipboard, "@wait", "@todo")
    return
}

; this other @wait

;;; GUI
notifyvim(time := 300) {
	ToolTip "NAV MODE", 900,  05
	return
}

notifyinsert(time := 300) {
	ToolTip
    return
}

; long press semi colon
$`;:: {
    ; Long press (> 0.5 sec) on * substitutes the dot multiply
    if !KeyWait("`;","T0.5") {
        vimize()
        KeyWait("`;")
    } else {
        Send("`;")
    }
    return
}

;;; Mode-Switch key
CapsLock:: {
    if (!modal) {
        vimize()
    } else {
        unvimize()
    }
    return
}

;;; Mode-Switch and Cleanup Functions
vimize() {    ;; Enter Vim mode
    global modal
    modal := true
    notifyvim()
    return
}

unvimize() {  ;; Exit Vim mode, do cleanup
    global modal
    modal := false
    notifyinsert()
    resetInputNumber()
    return
}

resetInputNumber() {
    global inputNumber
    inputNumber := " "
}

;;; Modal Commands
#HotIf modal

Esc:: {
    unvimize()
    return
}

handleNumber() {
    global inputNumber
    inputNumber := inputNumber . A_ThisHotkey
}

;;; Delete key on 'd'
d:: {
    Send("{Del}")
    return
}

;;; Delete a whole line on shift-d
+d:: {
    Send("{Home}{Shift Down}{End}{Shift Up}{Del}{Del}{Home}{Home}")
    return
}

;;; Navigation via vim like keys
h:: {
    Send("{Left}") 
    resetInputNumber()
    return
}

l:: {
    Send("{Right}") 
    resetInputNumber()
    return
}

+k:: {
    Send("{PgUp}")
    return
}

k:: {
    Send("{Up}") 
    resetInputNumber()
    return
}

j:: {
    Send("{Down}") 
    resetInputNumber()
    return
}

+j:: {
    Send("{PgDn}")
    return
}

; Control arrows on 'Alt' (e.g. alt-j is alt-down)


!k:: {
	Send("!{Up}")
	return
}
!j:: {
	Send("!{Down}")
	return
}

!h:: {
   Send("!{Left}")
	return
}
!l:: {
   Send("!{Right}")
   return
}

; So, 'a' goes to home of line, ';' goes to end of line
; And Shift-; selects the whole line!
a::Send("{Home}")
`;::Send("{End}")
<+;::Send("{Shift Down}{End}{Shift up}")
w:: {
    Send("^+{Right " . inputNumber . "}")
    resetInputNumber()
    return
}

b:: {
    Send("^+{Left " . inputNumber . "}")
    resetInputNumber()
    return
}

; shift-b and shift-t do multi-line select (up/down respectively)
; shift-l and shift-h also select
<+n:: {
    Send("{Shift Down}{Down}{Shift up}")
    return
}
<+u:: {
    Send("{Shift Down}{Up}{Shift up}")
    return
}
<+h:: {
    Send("{Shift Down}{Left}{Shift up}")
    return
}
<+l:: {
    Send("{Shift Down}{Right}{Shift up}")
    return
}

;;; cut
x::Send("^x")
return

;;; copy no (support for vi multi as not needed or desired)
c::Send("^c")


;;; Pasting  (support for vi multi as not needed or desired)
p::Send("^v")

;;; undo and redo key feature when forgetting to turn off nav mode
u::Send("^z")
y::Send("^y")

; Hot key desktop switch ctrl-alt-j left workspace, k right workspace.
<^<!j:: {
    Send("{LWin down}{LCtrl down}{Left down}")
    Send("{LWin up}{LCtrl up}{Left up}")
    return
}
<^<!k:: {
    Send("{LWin down}{LCtrl down}{Right down}")			
    Send("{LWin up}{LCtrl up}{Right up}")
    return
}

;;; alt-enter is like ctrl-alt-tab.. .keep home keys when task switching
!Enter:: {
    Send("^!{Tab}")
    return
}

;;; ctrl-alt-enter is like windows-tab  .keep home keys when task switching
^!Enter:: {
    Send("{LWin Down}{Tab}{LWin Up}")
    return
}

;;; Convenience task bar focus on 't'			
!t::Send("{LWin Down}t{LWin Up}")

; Move mouse with VIM keys and shft/ctrl 100 pixels
; Move mouse more granular with u/i/o/p also

<+^j:: {
    MouseMove(0, 100, , "R")
    return
}

<+^u:: {
    MouseMove(0, 10, , "R")
    return
}

<+^k:: {
    MouseMove(0, -100, , "R")
    return
}

<+^i:: {
    MouseMove(0, -10, , "R")
    return
}

<+^h:: {
    MouseMove(-100, 0, , "R")
    return
}

<+^y:: {
    MouseMove(-10, 0, , "R")
    return
}

<+^l:: {
    MouseMove(100, 0, , "R")
    return
}

<+^o:: {
    MouseMove(10, 0, , "R")
    return
}

<+^>:: {
    MouseClick("right")
    return
}
<+^<:: {
    MouseClick("left")
    return
}

#HotIf
