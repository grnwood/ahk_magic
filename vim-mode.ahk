; Hands free navigation.
;
; Major mouse movement, additional editing, and taskbar stuff
; Added by Joe Greenwood
;
; The rest largely borrowed from:
;   Modal_Vim.ahk
;  Initial Build: Rich Alesi
;  Friday, May 29, 2009
;
;  Modified for AHK_L by Andrej Mitrovic
;  August 10, 2010

#Persistent
#SingleInstance, Force
SetKeyDelay, -1
CoordMode, Tooltip, Screen

;; globals
inputNumber := " "
modal := false
shifton := false

;;; GUI
notifyvim(time=300)
{
   ; Progress, y280 b2 fs10 zh0 WS800, %text%, , , Verdana
   Progress, cwMaroon ctFFFFFF y10 b2 fs10 zh0 W100 WS700, nav, , , Verdana 
   ;Progress, Off
   return
}
notifyinsert(time=300)
{
   ; Progress, y120 b2 fs10 zh0 WS800, %text%, , , Verdana
   Progress, cwGreen ctFFFFFF y10 b2 fs10 zh0 W100 WS700, edit, , , Verdana 
   Sleep, %time%
   Progress, Off
   return
}


;;; Mode-Switch key
CAPSLOCK::
if (modal == false)
{
   vimize()
}
else
{
   unvimize()
}
return

;;; Mode-Switch and Cleanup Functions
vimize()    ;; Enter Vim mode
{
   global
   modal := true
   notifyvim()
   return
}

unvimize()  ;; Exit Vim mode, do cleanup
{
   global
   modal := false
   notifyinsert()
   resetInputNumber()
   return
}

resetInputNumber()
{
   global
   inputNumber := " "
}


;;; Modal Commands
#If (modal == true)


;;; The following allows appending numbers before a command, 
;;; e.g. 2, 4, w == 24w which can then be used throughout the rest of the commands.
;;; The number is usually reset to 0 by a move/modify command or jk.

;Esc::
;{
;   unvimize()
;   return
;}

; On enter task switcher.

0::
{
   inputNumber = %inputNumber%0
   return
}

1::
{
   inputNumber = %inputNumber%1
   return
}

2::
{
   inputNumber = %inputNumber%2
   return
}

3::
{
   inputNumber = %inputNumber%3
   return
}

4::
{
   inputNumber = %inputNumber%4
   return
}

5::
{
   inputNumber = %inputNumber%5
   return
}

6::
{
   inputNumber = %inputNumber%6
   return
}

7::
{
   inputNumber = %inputNumber%7
   return
}

8::
{
   inputNumber = %inputNumber%8
   return
}

9::
{
   inputNumber = %inputNumber%9
   return
}

;;; Delete key on 'd'
d::
{
   Send, {Del}
   return
}

;;; Delete a whole line on shift-d
+d::
{
   Send, {Home}{Shift Down}{End}{Shift Up}{Del}{Del}{Home}{Home}
}
return

;;; Navigation via vim like keys
h::
{
   Send, {Left %inputNumber%} 
   resetInputNumber()
   return
}

l::
{
   Send, {Right %inputNumber%} 
   resetInputNumber()
   return
}

+k::
{
   Send, {PgUp}
   return
}

k::
{
   Send, {Up %inputNumber%} 
   resetInputNumber()
   return
}

j::
{
   Send, {Down %inputNumber%} 
   resetInputNumber()
   return
}

+j::
{
   Send, {PgDn}
   return
}

; Control arrows on 'Alt' (e.g. alt-j is alt-down)
!k::
Send !{Up}
return

!j::
Send !{Down}
return

!h::
Send !{Left}
return

!l::
Send !{Right}
return

;So, 'a' goes to home of line, ';' goes to end of line
;And Shift-; selects the whole line!
a::Send, {Home}
`;::Send, {End}
<+;::Send, {Shift Down}{End}{Shift up}
w::
{
   Send, ^{Right %inputNumber%}
   resetInputNumber()
   return
}

b::
{
   Send, ^{Left %inputNumber%}
   resetInputNumber()
   return
}

;shift-b and shift-t do multi line select (up/down respectively)
;shift-l and shift-h also select
<+n::
{
   Send, {Shift Down}{Down}{Shift up}
   return
}
<+u::
{
   Send, {Shift Down}{Up}{Shift up}

   return
}
<+h::
{
   Send, {Shift Down}{Left}{Shift up}

   return
}
<+l::
{
   Send, {Shift Down}{Right}{Shift up}

   return
}


;;; let's try leaving ctrl-f on slash... might still be usefull.
;;; Searching (not needed, ctrl-f is easy enough and search is diff in each app anyway)
/::Send, ^f     ;; Search
;n::Send {F3}    ;; Search next
;+n::Send +{F3}  ;; Search previous
;^/::Send, ^h    ;; Replace

;;; cut
x::
Send, ^x
return

;;; copy no (support for vi multi as not needed or desired)
c::     ;; Paste at new line
Send, ^c
return

;;; Pasting  (support for vi multi as not needed or desired)
p::     ;; Paste at new line
   Send, ^v
return

;+p::    ;; Paste at beginning of line (does not work for some reason)
;IfInString, clipboard, `n
;{
;   Send, {Home}^v
;}
;Else
;{
;   Send, ^v
;}
;return

;;; Indent and jjj (not needed)
;+.::Send, {Home}`t                      ;; Indent  
;+,::Send, {Shift Down}{Tab}{Shift Up}   ;; Un-indent

;;; undo and redo key feature when forgetting to turn off nav mode
u::Send, ^z     ;; Undo
y::Send, ^y    ;; Redo

; Hot key desktop switch ctrrl-alt-j left workspace, k right workspace.
<^<!j::
	;MsgBox 'ctrl alt left'
	Send, {LWin down}{LCtrl down}{Left down}
	Send, {LWin up}{LCtrl up}{Left up}
return
<^<!k::
	;MsgBog 'ctrl alt left'
	Send, {LWin down}{LCtrl down}{Right down}			
	Send, {LWin up}{LCtrl up}{Right up}	
return

;;; alt enter is like ctrl alt tab.. .keep home keys when task switching
!Enter::
   Send, ^!{Tab}
return

;;; ctrl-alt-enter is like windows-tab  .keep home keys when task switching
^!Enter::
   Send, {LWin Down}{Tab}{LWin Up}
return


;;; Conviennce task bar focus on 't'			
!t::
   Send, {LWin Down}t{LWin Up}
return

;Move mouse with VIM keys and shft/ctrl 100 pixels
   ;Move mouse more granular with u/i/o/p also

<+^j::
{
   ;msgbox "okay"
   MouseMove, 0, 100, , R     
   return
}

<+^u::
{
   ;msgbox "okay"
   MouseMove, 0, 10, , R     
   return
}

<+^k::
{
   ;msgbox "okay"
   MouseMove, 0, -100, , R    
   return
}

<+^i::
{
   ;msgbox "okay"
   MouseMove, 0, -10, , R    
   return
}

<+^h::
{
   ;msgbox "okay"
   MouseMove, -100, 0, , R    
   return
}

<+^y::
{
   ;msgbox "okay"
   MouseMove, -10, 0, , R    
   return
}


<+^l::
{
   ;msgbox "okay"
   MouseMove, 100, 0, , R     
   return
}


<+^o::
{
   ;msgbox "okay"
   MouseMove, 10, 0, , R     
   return
}


<+^>::
{
   ;msgbox "okay"
   MouseClick, right
   return
}
<+^<::
{
   ;msgbox "okay"
   MouseClick, left
   return
}

;

#If


