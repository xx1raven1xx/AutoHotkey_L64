/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/07/07 new
*/

SetWorkingDir, %A_ScriptDir%
; #include
#include %A_ScriptDir%


main()

return

main()
{
  checkAndSendMsgExistThisScriptInProcess("aaaoaoaoaoa", "AutoBase2")
  return
}

checkAndSendMsgExistThisScriptInProcess(str_message, str_title){
  _winCount := 0
  _sendWin  := _winList := ""
  _return   := 0
  _prevDetectHiddenWindows := A_DetectHiddenWindows
  _prevTitleMatchMode      := A_TitleMatchMode
  
  SetTitleMatchMode 2
  DetectHiddenWindows On
  
  WinGet, _winCount, Count, %str_title% ahk_class AutoHotkey
  if (_winCount > 1){
    WinGet, _winList, List, %str_title% ahk_class AutoHotkey
    _sendWin := "ahk_id " _winList%_winCount%
    Send_WM_COPYDATA(str_message, _sendWin)
    DetectHiddenWindows %_prevDetectHiddenWindows% ; Restore original setting for the caller.
    SetTitleMatchMode %_prevTitleMatchMode%        ; Same.
  }
  
  DetectHiddenWindows %_prevDetectHiddenWindows% ; Restore original setting for the caller.
  SetTitleMatchMode %_prevTitleMatchMode%        ; Same.
}


; copy from http://www.autohotkey.com/community/viewtopic.php?t=76704
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)
{
   PtrSize:=A_PtrSize ? A_PtrSize : 4
   VarSetCapacity(CopyDataStruct, 3*PtrSize, 0)  ; Set up the structure's memory area.
   ; First set the structure's cbData member to the size of the string, including its zero terminator:
   SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
   NumPut(SizeInBytes, CopyDataStruct, PtrSize)  ; OS requires that this be done.
   NumPut(&StringToSend, CopyDataStruct, 2*PtrSize)  ; Set lpData to point to the string itself.
   Prev_DetectHiddenWindows := A_DetectHiddenWindows
   Prev_TitleMatchMode := A_TitleMatchMode
   DetectHiddenWindows On
   SetTitleMatchMode 2
   SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%  ; 0x4a is WM_COPYDATA. Must use Send not Post.
   DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
   SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
   return ErrorLevel  ; Return SendMessage's reply back to our caller.
}