/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/01/05 new
*/

#Persistent On

SetWorkingDir, %A_ScriptDir%

ABC := new AutoBaseClass()

ABC.getListViewClass().addList("aaaaaa")

OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA

return

; #include
#include %A_ScriptDir%
#include AutoBaseClass.ahk

;On Message ====================================================================

; copy from http://www.autohotkey.com/community/viewtopic.php?t=76704
Receive_WM_COPYDATA(wParam, lParam)
{
   Global ABC
   PtrSize:=A_PtrSize ? A_PtrSize : 4
   StringAddress := NumGet(lParam + 2*PtrSize)  ; lParam+8 is the address of CopyDataStruct's lpData member.
   CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
   ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
   ;ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
   ABC.getOnMessageClass().test(CopyOfData)
   return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}