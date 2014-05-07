;       _    _     _             __  __ _
;  __ _| |_ | |__ (_)_ _    ___ / _|/ _(_)__ ___
; / _` | ' \| / / | | ' \  / _ \  _|  _| / _/ -_)
; \__,_|_||_|_\_\ |_|_||_| \___/_| |_| |_\__\___|

;; Key remapping

; Kill F1
F1::Esc

; exceptions {{{
; SAP GUI
#IfWinActive ahk_class SAP_FRONTEND_SESSION
F1::F1
; MFC Dialog (Pop-up window from SAP GUI)
#IfWinActive ahk_class #32770
F1::F1
#IfWinActive
;}}}


; Application specific

; SAP GUI {{{
#IfWinActive ahk_class SAP_FRONTEND_SESSION
; Ctrl + /
^/::
  Send, ^/

  If (IME_GET() = 1) {
    IME_SET(0)
  }

  Send, /
Return


; VD03 w/o org proposal
:?:nvd03::nvd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;
:?:ovd03::ovd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;

; XD03 w/o org proposal
:?:nxd03::nxd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;
:?:oxd03::oxd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;
#IfWinActive
;}}}

; Notes {{{
#IfWinActive ahk_class SWT_Window0
; Direct assign Shift + -
^-::
  If (IME_GET() = 1) {
    IME_SET(0)
  }

  Send, +{NumpadSub}
Return

; Hotstring
:C1:br::Best regards,{Enter}Taichi
#IfWinActive
;}}}

