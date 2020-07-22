#Persistent                 ; Keeps script running persisitantly 
SetTimer, HotCorners, 0         ; HotCorners is name of timer, will be reset every 0 seconds until process is killed
return
HotCorners:                 ; Timer content 
CoordMode, Mouse, Screen        ; Coordinate mode - coords will be passed to mouse related functions, with coords relative to entire screen 

IsCorner(cornerID)
{
    WinGetPos, X, Y, Xmax, Ymax, Program Manager        ; get desktop size
    MouseGetPos, MouseX, MouseY                             ; Function MouseGetPos retrieves the current position of the mouse cursor
    T = 5                                               ; adjust tolerance value (pixels to corner) if desired
    CornerTopLeft := (MouseY < T and MouseX < T)                    ; Boolean stores whether mouse cursor is in top left corner
    CornerTopRight := (MouseY < T and MouseX > Xmax - T)            ; Boolean stores whether mouse cursor is in top right corner
    CornerBottomLeft := (MouseY > Ymax - T and MouseX < T)          ; Boolean stores whether mouse cursor is in bottom left corner
    CornerBottomRight := (MouseY > Ymax - T and MouseX > Xmax - T)  ; Boolean stores whether mouse cursor is in top left corner
    
    if (cornerID = "TopLeft"){
        return CornerTopLeft
    }
    else if (cornerID = "TopRight"){
        ;return CornerTopRight
    }
    else if (cornerID = "BottomLeft"){
        ;return CornerBottomLeft
    }
    else if  (cornerID = "BottomRight") {
        ;return CornerBottomRight
    }
}

; Show Task View (Open Apps Overview)
if IsCorner("TopLeft")
{
    Send, {LWin down}{tab down}
    Send, {LWin up}{tab up} 
    Loop 
    {
        if ! IsCorner("TopLeft")
            break ; exits loop when mouse is no longer in the corner
    }
}

; Show Action Center
if IsCorner("TopRight")
{   
    Send, {LWin down}{a down}
    Send, {LWin up}{a up}
    Loop
    {
        if ! IsCorner("TopRight")
            break ; exits loop when mouse is no longer in the corner
    }   
}

; Press Windows 
if IsCorner("BottomLeft")
{   
    Send, {LWin down}
    Send, {LWin up}
    Loop
    {
        if ! IsCorner("BottomLeft")
            break ; exits loop when mouse is no longer in the corner
    }   
}

; Show Desktop
if IsCorner("BottomRight")
{   
    Send, {LWin down}{d down}
    Send, {LWin up}{d up}
    Loop
    {
        if ! IsCorner("BottomRight")
            break ; exits loop when mouse is no longer in the corner
    }   
}

; Hot key desktop switch
<^<!Left::
    ;MsgBox 'ctrl alt left'
    Send, {LWin down}{LCtrl down}{Left down}
    Send, {LWin up}{LCtrl up}{Left up}
    return
<^<!Right::
    ;MsgBox 'ctrl alt left'
    Send, {LWin down}{LCtrl down}{Right down}
    Send, {LWin up}{LCtrl up}{Right up} 
    return
<^<!Down::
    ;MsgBox 'ctrl alt left'
    Send, {LWin down}{tab down}
    Send, {LWin up}{tab up} 
    return
return


; This script was inspired by and built on many like it
; in the forum. Thanks go out to ck, thinkstorm, Chris,
; and aurelian for a job well done.

; Change history:
; November 07, 2006: Optimized resizing code in !RButton, courtesy of bluedawn.
; February 05, 2006: Fixed double-alt (the ~Alt hotkey) to work with latest versions of AHK.

; The Double-Alt modifier is activated by pressing
; Alt twice, much like a double-click. Hold the second
; press down until you click.
;
; The shortcuts:
;  Alt + Left Button  : Drag to move a window.
;  Alt + Right Button : Drag to resize a window.
;  Double-Alt + Left Button   : Minimize a window.
;  Double-Alt + Right Button  : Maximize/Restore a window.
;  Double-Alt + Middle Button : Close a window.
;
; You can optionally release Alt after the first
; click rather than holding it down the whole time.

If (A_AhkVersion < "1.0.39.00")
{
    MsgBox,20,,This script may not work properly with your version of AutoHotkey. Continue?
    IfMsgBox,No
    ExitApp
}


; This is the setting that runs smoothest on my
; system. Depending on your video card and cpu
; power, you may want to raise or lower this value.
SetWinDelay,2

CoordMode,Mouse
return

!LButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id
    ; This message is mostly equivalent to WinMinimize,
    ; but it avoids a bug with PSPad.
    PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position.
WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
Loop
{
    GetKeyState,KDE_Button,LButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
    KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
    WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
}
return

!RButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id
    ; Toggle between maximized and restored state.
    WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    If KDE_Win
        WinRestore,ahk_id %KDE_id%
    Else
        WinMaximize,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position and size.
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
; Define the window region the mouse is currently in.
; The four regions are Up and Left, Up and Right, Down and Left, Down and Right.
If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
   KDE_WinLeft := 1
Else
   KDE_WinLeft := -1
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
   KDE_WinUp := 1
Else
   KDE_WinUp := -1
Loop
{
    GetKeyState,KDE_Button,RButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    ; Get the current window position and size.
    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    ; Then, act according to the defined region.
    WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of resized window
                            , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                            , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                            , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
    KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
    KDE_Y1 := (KDE_Y2 + KDE_Y1)
}
return

; "Alt + MButton" may be simpler, but I
; like an extra measure of security for
; an operation like this.
!MButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id
    WinClose,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
return

; This detects "double-clicks" of the alt key.
~Alt::
DoubleAlt := A_PriorHotKey = "~Alt" AND A_TimeSincePriorHotkey < 400
Sleep 0
KeyWait Alt  ; This prevents the keyboard's auto-repeat feature from interfering.
return

