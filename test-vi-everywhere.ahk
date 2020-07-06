;zim up and down ... vi like keys on ALT + 'j' and 'k'
;=====================================================
; alt +
;	'j' goes up, 'k' goes down, 'l' right, 'h', left
;	'y' Ctrl/Home   'p' Ctrl/End
;	',' Ctrl/left   '.' Ctrl/Right
!j::
;if winactive(zim) or winactive(zimtasks)  
;{
Send {Down}
;}
return

!k::
;if winactive(zim) or winactive(zimtasks)  
;{
Send {Up}
;}
return
!h::
;IfWinActive, %zim% 
;{
Send {Left}
;}
return
!l::
;IfWinActive, %zim% 
;{
Send {Right}
;}
return
!u::
;IfWinActive, %zim% 
;{
Send {Home}
;}
return
!p::
;IfWinActive, %zim% 
;{
Send {End}
;}
return
!y::
;IfWinActive, %zim% 
;{
Send {PgUp}
;}
return
!n::
;IfWinActive, %zim% 
;{
Send {PgDn}
;}
return
!,::
;IfWinActive, %zim% 
;{
Send {Control down}{Left}{Control up}
;}
return
!.::
;IfWinActive, %zim% 
;{
Send {Control down}{Right}{Control up}
;}
return

;=======================================================

