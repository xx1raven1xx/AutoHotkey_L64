/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/

ArgArray := Object()
Loop, %0%
{
    arg := %A_Index%
    ArgArray.Insert(arg)
}

Main(ArgArray)
return

/*
gvimを起動する
*/
Main(_ArgArray){
    Global PPxWindow
    DllCall("RegisterShellHookWindow", "UInt",A_ScriptHwnd)
    _shellNum := DllCall("RegisterWindowMessage", "Str","SHELLHOOK")
    OnMessage(_shellNum, "ShellMessage")

    PPxWindow := new PPxWindow()
}

class PPxWindow{
    __local__ := Object()

    __New(){
        this.constructor()
    }

    constructor(){
        this.setPPxList(Array())
        this.makeGui()
        this.addPPxWindow()
    }

    makeGui(){
        _gui := _xedge := _yedge := _w := _h := 0
        SM_CXEDGE    := 45
        SM_CYEDGE    := 46
        SM_CYCAPTION := 4

        SysGet, _xedge, %SM_CXEDGE%
        SysGet, _yedge, %SM_CYEDGE%
        ;TODO Menuを追加
        ; PPx 追加
        ; PPx 削除
        ; 最小化
        ; PPx 開放
        ; 再レイアウト
        ; カスタマイズを開く（できるか？）
        SysGet, _titleHeight, %SM_CYCAPTION%
        _w := A_ScreenWidth - (_xedge * 8)
        ;_h := _titleHeight
        _h := A_ScreenHeight - (_yedge * 8 + _titleHeight * 3)
        Gui, Show, W%_w% H%_h% xCenter y0
        Gui, +LastFound
        _gui := WinExist()
        this.setGuiHwnd(_gui)
    }

    addPPxWindow(){
        _prev_DetectHiddenWindows := A_DetectHiddenWindows
        _prev_TitleMatchMode := A_TitleMatchMode
        SetTitleMatchMode, 2
        DetectHiddenWindows, On
        ;_ppxHwnd := WinExist("PPC[A]")
        ;this.addWindow(_ppxHwnd)
        ;_ppxHwnd := WinExist("PPC[B]")
        ;this.addWindow(_ppxHwnd)
        DetectHiddenWindows %_prev_DetectHiddenWindows%  ; Restore original setting for the caller.
        SetTitleMatchMode %_prev_TitleMatchMode%         ; Same.
    }

    addWindow(_hwnd){
        this.setParent(_hwnd)
        this.addPPxList(_hwnd)
        this.changeWindowSize()
    }
    
    removeWindow(_hwnd){
        this.removePPxList(_hwnd)
        this.changeWindowSize()
    }
    
    isPPxWindow(_hwnd){
        _list := this.getPPxList()
        Loop, % _list.MaxIndex()
        {
            if(_hwnd = _list[A_Index]){
                return 1
            }
        }
        return 0
    }

    setParent(_hwnd){
        _dllName := (A_PtrSize = 8) ? "SetWindowLongPtr" : "SetWindowLong"
        _ret := DllCall(_dllName, "Ptr",_hwnd, "Int",-8, "Ptr",this.getGuiHwnd(), "Ptr")
    }

    changeWindowSize(){
        ; 構造のもち方の工夫
        _gui := this.getGuiRect() ; return {x,y,w,h,t,r,b,l}
        _layout := Array()
        _layout[1]  := [1]
        _layout[2]  := [2]
        _layout[3]  := [3]
        _layout[4]  := [2, 2]
        _layout[5]  := [3, 2]
        _layout[6]  := [3, 3]
        _layout[7]  := [4, 3]
        _layout[8]  := [4, 4]
        _layout[9]  := [3, 3, 3]
        _layout[10] := [4, 3, 3]
        _layout[11] := [4, 4, 3]
        _layout[12] := [4, 4, 4]

        _list := this.getPPxList()
        _num  := _list.MaxIndex() ; PPxの枚数
        _aLayout := _layout[_num]
        ;if(_aLayout = "")
        ;    Throw, error
        _h := _gui.h / _aLayout.MaxIndex()
        _rPPx := 0 ; row
        _cPPx := 0 ; column
        _index := 0
        Loop, % _aLayout.MaxIndex()
        {
            _rPPx  += 1
            _cPPx  := 0
            _w := _gui.w / _aLayout[_rPPx]
            _y := _gui.t + _h * (_rPPx - 1)
            Loop, % _aLayout[_rPPx]
            {
                _index += 1
                _hwnd  := _list[_index]
                _cPPx += 1
                _x := _gui.x + _w * (_cPPx - 1)
                ;MsgBox, % "x = " _x ", y = " _y ", w = " _w ", h = " _h
                this.changeSizePPx(_hwnd, _x, _y, _w, _h) ; TODO
                WinActivate, ahk_id %_hwnd%
                ; TODO Active
            }
        }
    }

    changeSizePPx(_hwnd, _x, _y, _w, _h){
        WinMove, ahk_id %_hwnd%,, %_x%, %_y%, %_w%, %_h%
    }

    ;*** getter setter ***;
    getGuiHwnd(){
        return this.__local__.guiHwnd
    }
    setGuiHwnd(_uint){
        if _uint is integer
        {
            return this.__local__.guiHwnd := _uint
        }
    }
    getGuiRect(){
        _gui := this.getGuiHwnd()
        WinGetPos, _gx, _gy, _gw, _gh, ahk_id %_gui%
        return {x:_gx, y:_gy, w:_gw, h:_gh, t:_gy, r:_gx+_gw, b:_gy+_gh, l:_gx}
    }
    getPPxList(){
        return this.__local__.ppxList
    }
    setPPxList(_Array){
        if(IsObject(_Array)){
            return this.__local__.ppxList := _Array
        }
        Throw, % "_Array is not Object."
    }
    addPPxList(_hwnd){
        this.getPPxList().Insert(_hwnd)
        return this.getPPxList()
    }
    removePPxList(_hwnd){
        _Array := this.getPPxList()
        Loop, % _Array.MaxIndex()
        {
            if(_Array[A_Index] = _hwnd)
            {
                _Array.Remove(A_Index)
                return 0
            }
        }
        return 1
    }
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
    Global PPxWindow
    _hwnd := lParam
    if(wParam = 1) ;  HSHELL_WINDOWCREATED := 1
    {
        WinGetTitle, _title, ahk_id %_hwnd%
        WinGet, _pName, ProcessName, ahk_id %_hwnd%
        WinGetClass, _class, ahk_id %_hwnd%
        ;ToolTip, title = %Title% PName = %PName%
        ;If  ( Title = "Windows タスク マネージャー" )
        ;IfInString, _pName, PPCW.EXE
        if(_pName = "PPCW.EXE" && _class != "")
        {
            ; _class = "" だとPPxのサブウィンドウだと勝手な解釈
            PPxWindow.addWindow(_hwnd)
        }
    }else if(wParam = 2){
        ; window destroy
        ; TODO Check
        if(PPxWindow.isPPxWindow(_hwnd)){
            MsgBox, % "hello! hwnd = " . _hwnd
            PPxWindow.removeWindow(_hwnd)
        }
    }
}
