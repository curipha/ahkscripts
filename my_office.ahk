;       _    _     _             __  __ _
;  __ _| |_ | |__ (_)_ _    ___ / _|/ _(_)__ ___
; / _` | ' \| / / | | ' \  / _ \  _|  _| / _/ -_)
; \__,_|_||_|_\_\ |_|_||_| \___/_| |_| |_\__\___|

; Kill F1
F1::Esc

; exceptions of killing F1 in SAP GUI
#IfWinActive ahk_exe saplogon.exe
F1::F1
#IfWinActive

; SAP GUI {{{
#IfWinActive ahk_class SAP_FRONTEND_SESSION

; Ctrl + R
^R::F8

; Ctrl + /
^/::
  IME_SET(0)
  Send, ^//
Return


; Ctrl + Q
^Q::
  IME_SET(0)
  Send, ^//nex{Enter}
Return

; Ctrl + W
^W::
  IME_SET(0)
  Send, ^//i{Enter}
Return


; VD03 w/o org proposal
:?:nvd03::nvd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;
:?:ovd03::ovd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;

; XD03 w/o org proposal
:?:nxd03::nxd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;
:?:oxd03::oxd03 RF02D-VKORG=;RF02D-VTWEG=;RF02D-SPART=;

; SE16N/SE16H
:?:nse16n::nse16h DYNP_CURSOR=GD-TAB;
:?:ose16n::ose16h DYNP_CURSOR=GD-TAB;
:?:nse16h::nse16h DYNP_CURSOR=GD-TAB;
:?:ose16h::ose16h DYNP_CURSOR=GD-TAB;

#IfWinActive
;}}}

; Lotus Notes {{{
#IfWinActive ahk_class SWT_Window0

; Shift + - (In JIS keyborad, Shift + - means "=")
^-::
  IME_SET(0)
  Send, +{NumpadSub}
Return

; Signature
:C:br::Best regards,{Enter}Taichi{Enter}

#IfWinActive
;}}}

