#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#ifWinActive, ahk_class GxWindowClass


$q::
If (A_TimeSincePriorhotkey<300&&A_PriorHotkey=A_ThisHotkey)
     SEND {3}{2}{1}
else
 send {q}
    RETURN