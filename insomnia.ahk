#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%

#Persistent
#SingleInstance force

interval := 18 ; Check interval (seconds)

SetTimer, Nightmare, % interval * 1000
Return

Nightmare:
If (A_TimeIdle > interval * 1000)
{
  Send, {LShift}

  MouseMove,  200,  200, 0, R
  MouseMove, -200, -200, 0, R
}
