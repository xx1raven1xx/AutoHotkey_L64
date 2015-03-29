return
/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2013/05/18 new
*/

/**
初期化時：
wParam="init"
lParam=Function name

初期化時に登録した(lParam)関数に文字列データを渡す
関数名は文字列で渡すこと
関数名の変わりにクラス名を渡しても良い
その際は__Call("", CopyOfData)が呼ばれるので注意
*/
/*
Receive_WM_COPYDATA(wParam, lParam)
{
  static funcName
  if(wParam = "init"){
    funcName := lParam
    MsgBox, func = %funcName%
    return
  }
  
  PtrSize:=A_PtrSize ? A_PtrSize : 4
  StringAddress := NumGet(lParam + 2*PtrSize)  ; lParam+8 is the address of CopyDataStruct's lpData member.
  CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
  ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
  ;ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
  MsgBox, come %funcName%
  funcName.(CopyOfData)
  return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}
*/

Receive_WM_COPYDATA(wParam, lParam)
{
  static funcName
  if(wParam != 0){
    obj := Object(wParam)
    if(IsObject(obj)){
      
    }
    funcName := lParam
    MsgBox, func = %funcName%
    return
  }

  StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
  CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
  ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
  ;ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
  ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%`nwParam[%wParam%]
  return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}

; 参考
/*
; copy from http://www.autohotkey.com/community/viewtopic.php?t=76704
Receive_WM_COPYDATA(wParam, lParam)
{
   PtrSize:=A_PtrSize ? A_PtrSize : 4
   StringAddress := NumGet(lParam + 2*PtrSize)  ; lParam+8 is the address of CopyDataStruct's lpData member.
   CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
   ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
   ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
   return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}
*/