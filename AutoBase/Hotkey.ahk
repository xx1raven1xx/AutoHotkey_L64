/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

#If (WinActive("ahk_id " AUTOBASE.getHwnd()))
Up up::   AUTOBASE.keyEvent("upoff")
UP::      AUTOBASE.keyEvent("up")
Down up:: AUTOBASE.keyEvent("downoff")
DOWN::    AUTOBASE.keyEvent("down")
Escape::  AUTOBASE.keyEvent("escape")
*Enter::  AUTOBASE.keyEvent("enter")
#r::      Reload

#If