;       _    _     _             __  __ _
;  __ _| |_ | |__ (_)_ _    ___ / _|/ _(_)__ ___
; / _` | ' \| / / | | ' \  / _ \  _|  _| / _/ -_)
; \__,_|_||_|_\_\ |_|_||_| \___/_| |_| |_\__\___|

;; Fucntions
; IME Control {{{
; http://www6.atwiki.jp/eamat/

;-----------------------------------------------------------
; Get status of IME
;   WinTitle="A"    Target window (default = active window)
;   Return          1:ON / 0:OFF
;-----------------------------------------------------------
IME_GET(WinTitle="A") {
  ControlGet,hwnd,HWND,,,%WinTitle%

  if (WinActive(WinTitle)) {
    ptrSize := !A_PtrSize ? 4 : A_PtrSize

    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
    NumPut(cbSize, stGTI, 0, "UInt")  ;   DWORD   cbSize;

    hwnd := DllCall("GetGUIThreadInfo", Uint, 0, Uint, &stGTI)
              ? NumGet(stGTI, 8+PtrSize, "UInt") : hwnd
  }

  return DllCall("SendMessage"
    , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint, hwnd)
    , UInt, 0x0283 ;Message : WM_IME_CONTROL
    ,  Int, 0x0005 ;wParam  : IMC_GETOPENSTATUS
    ,  Int, 0)     ;lParam  : 0
}

;-----------------------------------------------------------
; Set status of IME
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    Target window (default = active window)
;   Return          0:Success / Non-0:Failure
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle="A") {
  ControlGet,hwnd,HWND,,,%WinTitle%

  if (WinActive(WinTitle)) {
    ptrSize := !A_PtrSize ? 4 : A_PtrSize

    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
    NumPut(cbSize, stGTI, 0, "UInt")  ;   DWORD   cbSize;

    hwnd := DllCall("GetGUIThreadInfo", Uint, 0, Uint,&stGTI)
              ? NumGet(stGTI, 8+PtrSize, "UInt") : hwnd
  }

  return DllCall("SendMessage"
    , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint, hwnd)
    , UInt, 0x0283  ;Message : WM_IME_CONTROL
    ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
    ,  Int, SetSts) ;lParam  : 0 or 1
}

;}}}

;; Preferences
#Persistent
#SingleInstance force

#Hotstring C

SetWorkingDir, %UserProfile%


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

