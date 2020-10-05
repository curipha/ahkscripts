;       _    _
;  __ _| |_ | |__
; / _` | ' \| / /
; \__,_|_||_|_\_\

;; Preferences
#NoEnv
#Warn
#Persistent
#SingleInstance force

SendMode Input
SetWorkingDir %A_ScriptDir%

#Include %A_ScriptDir%\IME.ahk

; Set lockstate
SetCapsLockState, AlwaysOff
SetNumLockState, AlwaysOn
SetScrollLockState, AlwaysOff

; Display desktop w/ Win + E
#e::
  Run, explorer %A_Desktop%
Return

; CapsLock -> Tab (only for JIS keyboard)
vkF0::Tab


; Google Chrome {{{
#IfWinActive ahk_class Chrome_WidgetWin_1

; Kill Ctrl + D
^D::^f

; Open incognito mode in the same key as Firefox
^+P::^+n

; Deactivate IME when editing URI
^L::
  IME_SET(0)
  Send, ^l
Return

#IfWinActive
;}}}

#Include *i %A_ScriptDir%\my_office.ahk
