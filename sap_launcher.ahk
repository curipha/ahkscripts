;  ___   _   ___   _                      _
; / __| /_\ | _ \ | |   __ _ _  _ _ _  __| |_  ___ _ _
; \__ \/ _ \|  _/ | |__/ _` | || | ' \/ _| ' \/ -_) '_|
; |___/_/ \_\_|   |____\__,_|\_,_|_||_\__|_||_\___|_|

;; Preferences
#Persistent
#SingleInstance force

#Hotstring C

SetWorkingDir, %UserProfile%

user = %A_UserName%
password =

keymap := { "PR" : { "connect": "PRD/100", "user": user, "language": "EN" }
;             - Hot key is "PR"
;             - Sign-in to the system whose SID = "PRD" and client = 100 using the same username as Windows
;             - Password is used which will be prompt (it stores on memory)
;             - Session language is "EN" (English)

          , "QA" : { "connect": "QAS/200|VA01", "user": "QA", "password": "P@ssw0rd", "language": "JA" } }
;             - Hot key is "QA"
;             - Sign-in to the system whose SID = "QAS" and client = 200 using username = "QA" and password = "P@ssw0rd"
;             - After sign-in, open transaction VA01 immediately
;             - Session language is "JA" (Japanese)

; Abort {{{
Abort(msg)
{
  MsgBox, Abort: %msg% ...
  ExitApp
}
;}}}
; OpenSAPConnection {{{
;  %console% = %system%/%client%|%command% (%system%/%client% is required.)
OpenSAPConnection(console, user, password = "", language = "JA")
{
  sapshcut = C:\Program Files\SAP\FrontEnd\SAPgui\sapshcut.exe
  workdir  = %A_Desktop%

  IfNotInString, console, /
    Abort("Illegal call of OpenSAPConnection")

  cc := console2concmd(console)
  connect := cc["connect"]
  command := cc["command"]

  sc := connect2syscli(connect)
  system := sc["system"]
  client := sc["client"]

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

  ; Be careful, it is a foward match only. It means "BYEFOOBAR" matches this pattern.
  ; Only for one character command (e.g. "Q") should be an exact match to avoid an accidential strike.
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

    If (InStr(key["connect"], "|") = 0)
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
  If (A_PriorHotkey = A_ThisHotKey && A_TimeSincePriorHotkey < 250 && A_TimeSincePriorHotkey > 80)
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

