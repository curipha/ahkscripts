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

; Plain text paste (Ctrl + Shift + V)
^+V::
  evclip := ClipboardAll

  If (IME_GET() = 1) {
    IME_SET(0)
    imerestore = 1
  }

  clipboard = %clipboard%
  Send, ^v

  Sleep, 20

  If (imerestore = 1) {
    IME_SET(1)
    imerestore = 0
  }

  Clipboard := evclip
  evclip =
Return


; Google Chrome {{{
#IfWinActive ahk_class Chrome_WidgetWin_1

; Kill Ctrl + D
^D::^f

; Open Secret mode by same key as Firefox
^+P::^+n

; CTRL + L deactivate IME to set search keyword easily
^L::
  IME_SET(0)
  Send, ^l
Return
#IfWinActive
;}}}

#Include *i %A_ScriptDir%\my_office.ahk
