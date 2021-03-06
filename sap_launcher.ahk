;  ___   _   ___   _                      _
; / __| /_\ | _ \ | |   __ _ _  _ _ _  __| |_  ___ _ _
; \__ \/ _ \|  _/ | |__/ _` | || | ' \/ _| ' \/ -_) '_|
; |___/_/ \_\_|   |____\__,_|\_,_|_||_\__|_||_\___|_|

;; Preferences
#Persistent
#SingleInstance force

SetWorkingDir, %UserProfile%

IfNotExist, %A_ScriptDir%\sap_launcher.ini.ahk
{
  MsgBox, 0x10
        , Error
        , Cannot find "sap_launcher.ini.ahk".`nYou have to set up this file correctly.
  ExitApp
}

#Include *i %A_ScriptDir%\sap_launcher.ini.ahk

; OpenSAPConnection {{{
OpenSAPConnection(system, client, command, user, password = "", language = "", reuse = "1")
{
  sapshcut = C:\Program Files\SAP\FrontEnd\SAPgui\sapshcut.exe
  workdir  = %A_Desktop%

  arg = -system="%system%" -client="%client%" -reuse="%reuse%" -workdir="%workdir%" -user="%user%"

  If (language != "")
    arg = %arg% -language="%language%"
  If (password != "")
    arg = %arg% -pw="%password%"
  If (command != "")
    arg = %arg% -command="%command%"

  exec = "%sapshcut%" %arg%

  Run, %exec%
  Sleep, 800
}
;}}}

; getpassword {{{
getpassword()
{
  InputBox, password, Enter your password, Please enter your SAP password:, HIDE, 320, 120

  If (ErrorLevel != 0 or StrLen(password) < 1)
    MsgBox, 0x40, Information, Cancel or password is empty.`nIt does NOT store the password.

  Return password
}
;}}}
; showhelp {{{
showhelp(map, defuser, deflang)
{
  mykeym =

  For k, v in map
  {
    c := v["connect"]
    u := v["user"]
    l := v["language"]

    If (u = "")
      u = %defuser%
    If (l = "")
      l = %deflang%

    mykeym = %mykeym%`n* %c% @%u% (%l%) : %k%
  }

  Msgbox, 0x20, SAP Launcher: Help,
(
Tip: Command is case-insensitive.

[ User key mappings ]
%mykeym%

[ System key mappings ]

* Exit the application : BYE, EXIT, QUIT
* Restart the application : R, RE, RELOAD, RESTART, REBOOT
* Show this help: H, HELP
* Clear registered password: CLEAR, RESET
)
}
;}}}

; showgui {{{
showgui()
{
  GuiControl, Text, Command, 
  Gui, Show

  SetTimer, AutoHide, -4000
}
;}}}
; hidegui {{{
hidegui()
{
  SetTimer, AutoHide, Off
  Gui, Hide
}
;}}}

SetupGUI:
  Gui, +AlwaysOnTop +ToolWindow
  Gui, Font, S9
  Gui, Add, Edit, vCommand X0 Y0 W180 H20
  Gui, Show, Hide X0 Y0 W180 H20, SAP Launcher
Return


#IfWinActive ahk_class AutoHotkeyGUI
Enter::
  Gui, Submit

  If (Command = "")
  {
    hidegui()
    Return
  }


  StringUpper, Command, Command

  ; Be careful, it is a forward match only. It means "BYEFOOBAR" matches this pattern.
  ; Only for one character command (e.g. "R") should be an exact match to avoid an accidental strike.
  If (RegExMatch(Command, "S)^(?:BYE|EXIT|QUIT)") > 0)
  {
    ExitApp
    Return
  }

  If (RegExMatch(Command, "S)^(?:R$|RE(?:LOAD|START|BOOT)?)") > 0)
  {
    Reload
    Return
  }

  If (RegExMatch(Command, "S)^(?:H$|HELP)") > 0)
  {
    showhelp(keymap, user, language)
    Return
  }

  If (RegExMatch(Command, "S)^(?:CLEAR|RESET)") > 0)
  {
    password =
    MsgBox, 0x40, Information, The password stored in the memory has been cleared.
    Return
  }


  key := keymap[Command]

  If (key = "")
  {
    If (RegExMatch(Command, "S)^([[:alnum:]]{3})([[:digit:]]{3})$", $) > 0)
    {
      s_system  := $1
      s_client  := $2
      s_command := "SESSION_MANAGER"
    }
    Else
    {
      MsgBox, 0x30, Unknown command, Unknown command: %Command%
      Return
    }
  }
  Else
  {
;   %connect% = %system%/%client%|%command% (%system%/%client% is mandatory.)
    connect := key["connect"]

    IfNotInString, connect, /
    {
      MsgBox, 0x30
            , Misconfiguration
            , The "connect" string for keymap "%Command%" should be a string which concatenates SID and client with a slash.
      Return
    }

    IfNotInString, connect, |
      connect .= "|SESSION_MANAGER"

    c := StrSplit(connect, "|")
    server    := c[1]
    s_command := c[2]

    s := StrSplit(server, "/")
    s_system := s[1]
    s_client := s[2]
  }

  s_user := (key["user"] = "")      ? user     : key["user"]
  s_lang := (key["language"] = "" ) ? language : key["language"]

  If (key["password"] = "")
  {
    If (password = "")
      password := getpassword()

    s_pass := password
  }
  Else
  {
    s_pass := key["password"]
  }

  s_reuse = 1
  If (maxsession > 0)
  {
    SetTitleMatchMode, RegEx
    WinGet, sessions, Count, ^%s_system%\(\d+\)\/%s_client%\b ahk_class \ASAP_FRONTEND_SESSION\z
    SetTitleMatchMode, 1

    If (sessions >= maxsession)
      s_reuse = 0
  }

  OpenSAPConnection(s_system, s_client, s_command, s_user, s_pass, s_lang, s_reuse)
Return
#IfWinActive


GuiEscape:
  hidegui()
Return

GuiClose:
  hidegui()
;  ExitApp
Return

AutoHide:
  hidegui()
Return


keyfireable := True

Ctrl::
  If (keyfireable && A_PriorHotkey = A_ThisHotKey && A_TimeSincePriorHotkey < 240)
  {
    IfWinActive, ahk_class AutoHotkeyGUI
      hidegui()
    Else
      showgui()

    keyfireable := False
  }
  Else
  {
    keyfireable := True
  }
Return
