; IME Control functionality
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

