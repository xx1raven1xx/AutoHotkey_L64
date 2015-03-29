/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
#Persistent
Main()
return
/*
RegisterCallBackのテスト
idProcessにPIDを指定することで特定のウィンドウにのみ反応させることができる
*/
Main(){
    SetTitleMatchMode, 2
    DetectHiddenWindows, On
    _hwnd := WinExist("Pale Moon")
    WinGet, _pid, PID, ahk_id %_hwnd%
    MsgBox, %_hwnd% %_pid%

    myFunc := RegisterCallback("WinActivateHandler")

    myHook := DllCall("SetWinEventHook"
    , "UInt", 0x00000003 ; eventMin      : EVENT_SYSTEM_FOREGROUND
    , "UInt", 0x00000003 ; eventMax      : EVENT_SYSTEM_FOREGROUND
    , "UInt", 0          ; hModule       : self
    , "UInt", myFunc     ; hWinEventProc : 
    , "UInt", _pid          ; idProcess     : All process
    , "UInt", 0          ; idThread      : All threads
    , "UInt", 0x0001     ; dwFlags       : WINEVENT_SKIPOWNTHREAD
    , "UInt")

}

WinActivateHandler(hWinEventHook, event, hwnd, idObject, idChild, thread, time) {
    ;WinGetTitle, title, ahk_id %hwnd%
    ;WinGetClass, class, ahk_id %hwnd%
    ;Tooltip, 「%title% ahk_class %class%」がアクティブになった
    ToolTip, [%hwnd%]
}
