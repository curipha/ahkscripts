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
  MsgBox, 0x30
        , Error
        , Cannot find "sap_launcher.ini.ahk".`nYou have to set up this file correctly.

  ExitApp
}

#Include %A_ScriptDir%\sap_launcher.ini.ahk

; Abort {{{
Abort(msg)
{
  MsgBox, Abort: %msg% ...
  ExitApp
}
;}}}
; OpenSAPConnection {{{
;  %console% = %system%/%client%|%command% (%system%/%client% is mandatory.)
OpenSAPConnection(console, user, password = "", language = "")
{
  sapshcut = C:\Program Files\SAP\FrontEnd\SAPgui\sapshcut.exe
  workdir  = %A_Desktop%
  deflang  = JA

  IfNotInString, console, /
    Abort("The first argument of OpenSAPConnection should be a string which concatenates SID and client with a slash.")

  cc := console2concmd(console)
  connect := cc["connect"]
  command := cc["command"]

  sc := connect2syscli(connect)
  system := sc["system"]
  client := sc["client"]

  If language =
    language = %deflang%


  arg = -system="%system%" -client="%client%" -reuse=1 -workdir="%workdir%" -language="%language%" -user="%user%"

  If password !=
    arg = %arg% -pw="%password%"
  If command !=
    arg = %arg% -command="%command%"

  exec = "%sapshcut%" %arg%

  Run, %exec%
  Sleep, 800
}
;}}}
; console2concmd {{{
console2concmd(console)
{
  IfInString, console, |
  {
    StringSplit, console_a, console, |

    connect := Trim(console_a1)
    command := Trim(console_a2)
  }
  Else
  {
    connect := Trim(console)
    command := ""
  }

  Return { "connect": connect, "command": command }
}
;}}}
; connect2syscli {{{
connect2syscli(connect)
{
  IfInString, connect, /
  {
    StringSplit, connect_a, connect, /

    system := Trim(connect_a1)
    client := Trim(connect_a2)
  }
  Else
  {
    system := Trim(connect)
    client := ""
  }

  Return { "system": system, "client": client }
}
;}}}

; getpassword {{{
getpassword()
{
  InputBox, password, , Please enter your SAP password:, HIDE, 320, 120

  If (ErrorLevel != 0 or StrLen(password) < 1)
    Msgbox Cancel or password is empty

  Return password
}
;}}}
; showhelp {{{
showhelp(map)
{
  mykeym =

  For k, v in map
  {
    c := v["connect"]
    u := v["user"]
    l := v["language"]

;   mykeym = %mykeym%`n* %c% (%u%)
    mykeym = %mykeym%`n* %c% @%u%

    If (l != "")
      mykeym = %mykeym% (%l%)

    mykeym = %mykeym% : %k%
  }

  Msgbox, 
(
 SAP Launcher
==============

Tip: Command is case-insensitive.

[ User key mappings ]
%mykeym%

[ System key mappings ]

* Exit the application : BYE, EXIT, Q, QUIT
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

  SetTimer, AutoHide, -3000
}
;}}}
; hidegui {{{
hidegui()
{
  Gui, Hide

  SetTimer, AutoHide, Off
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
  ; Only for one character command (e.g. "Q") should be an exact match to avoid an accidental strike.
  If (RegExMatch(Command, "S)^(BYE|EXIT|Q$|QUIT)") > 0)
  {
    ExitApp
    Return
  }

  If (RegExMatch(Command, "S)^(R$|RE(LOAD|START|BOOT)?)") > 0)
  {
    Reload
    Return
  }

  If (RegExMatch(Command, "S)^(H$|HELP)") > 0)
  {
    showhelp(keymap)
    Return
  }

  If (RegExMatch(Command, "S)^(CLEAR|RESET)") > 0)
  {
    password =
    Msgbox, On-memory password is cleared.
    Return
  }

  key := keymap[Command]

  If (key = "")
  {
    Msgbox, Unknown command: %Command%

    showgui()
  }
  Else
  {
    connect := key["connect"]

    IfNotInString, connect, |
      connect .= "|SESSION_MANAGER"


    volatilepass =

    If (key["password"] = "")
    {
      If (password = "")
        password := getpassword()

      volatilepass = %password%
    }
    Else
    {
      volatilepass := key["password"]
    }


    OpenSAPConnection(connect, key["user"], volatilepass, key["language"])
  }
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


Ctrl::
  If (A_PriorHotkey = A_ThisHotKey && A_TimeSincePriorHotkey < 400 && A_TimeSincePriorHotkey > 80)
  {
    IfWinActive, ahk_class AutoHotkeyGUI
    {
      hidegui()
    }
    Else
    {
      showgui()
    }
  }

  KeyWait, Ctrl
Return

