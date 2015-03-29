return
/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2013/05/16 new
*/

#include <Receive_WM_COPYDATA>

/*
プロセス間でメッセージをやり取りするクラス
*/
class InterprocessClass
{
  __local__  := Object()
  
  __New()
  {
  }
  
  __Call(aName, params*)
  {
/*
    if(aName = "")
    {
      return this.get()
    }
*/
    if(!ObjHasKey(this.base, aName))
    {
      Throw, this.__Class . " has not " . aName . " function."
    }else{
      MsgBox, % ObjHasKey(this.base, aName)
    }
  }
  
  startOnMessage(str_funcName)
  {
    ;Receive_WM_COPYDATA("init", str_funcName) ; 関数名を登録
    OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA
  }
  
  ; wrapper
  send(ByRef StringToSend, ByRef TargetScriptTitle)
  {
    return this.Send_WM_COPYDATA(StringToSend, TargetScriptTitle)
  }
  sendData(ByRef StringToSend, ByRef TargetScriptTitle)
  {
    return this.Send_WM_COPYDATA(StringToSend, TargetScriptTitle)
  }
  
  Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)  ; ByRef saves a little memory in this case.
  ; This function sends the specified string to the specified window and returns the reply.
  ; The reply is 1 if the target window processed the message, or 0 if it ignored it.
  {
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  ; Set up the structure's memory area.
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  ; OS requires that this be done.
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  ; Set lpData to point to the string itself.
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%  ; 0x4a is WM_COPYDATA. Must use Send not Post.
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
  }
  
/*
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
*/
}

/*
Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
    ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
    ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
    return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}
*/