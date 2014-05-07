;       _    _
;  __ _| |_ | |__
; / _` | ' \| / /
; \__,_|_||_|_\_\

;; Preferences
#Persistent
#SingleInstance force

#Hotstring C

#Include %A_ScriptDir%\IME.ahk

SetWorkingDir, %UserProfile%


;; Key remapping

; CapsLock(Eisuu) -> Tab
vkF0sc03A::
  Send, {Tab}
Return


; Plain text paste (Ctrl + Shift + V)
^+v::
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


; Application specific

; Google Chrome {{{
#IfWinActive ahk_class Chrome_WidgetWin_1
^d::^f
#IfWinActive
;}}}


;; Hot keys

; Win + E
#e::
  Run, explorer %A_Desktop%
Return

