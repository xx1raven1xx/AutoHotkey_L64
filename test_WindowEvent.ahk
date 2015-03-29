/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
#Persistent
SetBatchLines, -1

Main()
return
/*
WindowEventをトリガーにして動作するスクリプト
参考URL
http://www.autohotkey.com/community/viewtopic.php?p=123323#123323
*/
Main(){
    Process, Priority,, High
/*
Hwndが取得できれば問題ない
    Gui +LastFound
    hWnd := WinExist()

    MsgBox, hWnd=%hWnd% script=%A_ScriptHwnd%
*/
    hWnd := A_ScriptHwnd

    DllCall("RegisterShellHookWindow", UInt,hWnd)
    MsgNum := DllCall("RegisterWindowMessage", Str,"SHELLHOOK")
    ;MsgBox, %MsgNum%
    OnMessage(MsgNum, "ShellMessage")
}

ShellMessage(wParam, lParam){
/*
    wParam = 1  : HSHELL_WINDOWCREATED
    wParam = 2  : HSHELL_WINDOWDESTROYED
    wParam = 3  : HSHELL_ACTIVATESHELLWINDOW
    wParam = 4  : HSHELL_WINDOWACTIVATED
    wParam = 5  : HSHELL_GETMINRECT
    wParam = 6  : HSHELL_REDRAW
    wParam = 7  : HSHELL_TASKMAN
    wParam = 8  : HSHELL_LANGUAGE
    wParam = 9  : HSHELL_SYSMENU
    wParam = 10 : HSHELL_ENDTASK
    wParam = 11 : HSHELL_ACCESSIBILITYSTATE
    wParam = 12 : HSHELL_APPCOMMAND
    wParam = 13 : HSHELL_WINDOWREPLACED
    wParam = 14 : HSHELL_WINDOWREPLACING
    wParam = 15 : HSHELL_HIGHBIT
    wParam = 16 : HSHELL_FLASH
    wParam = 17 : HSHELL_RUDEAPPACTIVATED
*/
    if(wParam = 1) ;  HSHELL_WINDOWCREATED := 1
    {
        WinGetTitle, Title, ahk_id %lParam%
        WinGet, PName, ProcessName, ahk_id %lParam%
        ToolTip, title = %Title% PName = %PName%
        ;If  ( Title = "Windows タスク マネージャー" )
        IfInString, Title, PPC
        {
            Msgbox, OK!
            ;WinClose, ahk_id %lParam%
            ; Run, Calc.exe              ; instead
        }
    }
}
