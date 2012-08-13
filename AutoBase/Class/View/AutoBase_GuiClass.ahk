/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_GuiClass{
  __local__ := Object()
  
  __New(){
    _scrollWidth := DllCall("GetSystemMetrics", UInt,3, UInt) ; SM_CXVSCROLL
    _windowEdgeX := DllCall("GetSystemMetrics", UInt,45, UInt) ; SM_CXEDGE
    this.setScrollWidth(_scrollWidth)
    this.setWindowEdgeX(_windowEdgeX)
    this.setListViewClassArray(Array())
  }
  
  makeGui(_GuiSettingClass){
    Global AUTOBASE_Gui_Edit
    Global AUTOBASE_Gui_ListView
    Global AUTOBASE_Gui_Text
    _hwnd := _pid := _height := _textY := _posEdit := _posText := 0
    this.applySetting(_GuiSettingClass) ; 設定の適用
    _w           := this.getWidth()
    _h           := this.getHeight()
    _fc          := this.getFontColor()
    _bc          := this.getBackgroundColor()
    _scrollWidth := this.getScrollWidth()
    _windowEdgeX := this.getWindowEdgeX()
    
    Gui, Margin, 0, 0
    Gui, Add, Edit, gAUTOBASE_Gui_Edit_Change vAUTOBASE_Gui_Edit x0 y0 w%_w% r1
    Gui, Add, ListView, vAUTOBASE_Gui_ListView -Hdr x0 y+0 w%_w% -Multi c%_fc% Background%_bc%, display
    Gui, Add, Text, vAUTOBASE_Gui_Text y+1 r2 w%_w%, % ""
    Gui, +Resize LastFound 0x00CF0000
    LV_ModifyCol(1,_w-_scrollWidth-_windowEdgeX*2) ; サイズに、スクロールバーの幅とウィンドウの枠幅*2を引くことにより横スクロールバーを出さないようにしている。
    LV_SetImageList(new IconClass().getMemoryClass().getImageList(), 1) ; TODO ok?
    Gui, Show, XCenter YCenter w%_w% h%_h% Hide, AutoBase
    GuiControlGet, _posEdit, Pos, AUTOBASE_Gui_Edit
    GuiControlGet, _posText, Pos, AUTOBASE_Gui_Text
    _height := _h-_posEditH-_posTextH
    _textY := _posEditH+_height
    GuiControl, Move, AUTOBASE_Gui_ListView, h%_height%
    GuiControl, Move, AUTOBASE_Gui_Text, y%_textY%
    Gui, Show
    _hwnd := WinExist()
    this.setHwnd(_hwnd)
    WinGet, _pid, PID, ahk_id %_hwnd%
    this.setPid(_pid)
  }
  
  applySetting(_GuiSettingClass){
    this.setWidth(_GuiSettingClass.getWidth())
    this.setHeight(_GuiSettingClass.getHeight())
    this.setFontColor(_GuiSettingClass.getFontColor())
    this.setBackgroundColor(_GuiSettingClass.getBackgroundColor())
  }
  
  ; from ViewClass
  registerListView(_Array){
    ; _Array[] is ListClass from AutoBase_ListViewClass.ahk
    this.setListViewClassArray(_Array)
    GuiControl, -Redraw, AUTOBASE_Gui_ListView
    LV_Delete()
    Loop, % _Array._MaxIndex()
    {
      _ListViewClass := _Array[A_Index]
      LV_Add("Icon" . _ListViewClass.getIcon(), _ListViewClass.getDisplayText())
    }
    GuiControl, +Redraw, AUTOBASE_Gui_ListView
    this.moveListView(1)
  }
  
  ; from ViewClass
  moveListViewEvent(_direction="", _repeatOn=0){
    _d             := _direction
    _content       := LV_GetNext()
    _listViewCount := LV_GetCount()
    if(_d = ""){
    }else if(_d = "up" || _d = "up"){
      if(_content = ){
        _content := 1
      }else{
        _content -= 1
        if(_content = 0){
          if(_repeatOn = 1){
            ; リピート時は停止
            _content := 1
          }else{
            _content := _listViewCount
          }
        }
      }
    }else if(_d = "down" || _d = "d"){
      if(_content = ){
        _content := 1
      }else{
        _content += 1
        if(_content = (_listViewCount+1)){
          if(_repeatOn = 1){
            _content := _listViewCount
          }else{
            _content := 1
          }
        }
      }
    }else{
      ; 数値入力
      _int := Ceil(_d)
      if(_int < 1){
        _int := 1
      }else if(_listViewCount < _int){
        _int := _listViewCount
      }
      _content := _int
    }
    
    LV_Modify(_content, "Select Vis")
  }
  
  ; from ViewClass
  ; TODO このままだとmodeが変更できない
  sendListViewKeyEvent(_event){
    if(_event = "enter"){
      _index   := LV_GetNext()
      _ListClass := this.getListView()[_index]
      this.getListPlugin().setMode("normal") ; モードを戻す
      this.search("")
    }else if(_event = "escape"){
      this.getListPlugin().setMode("normal") ; モードを戻す
      this.search("")
    }
  }
  
  ;*** getter setter ***;
  getWidth(){
    return this.__local__.width
  }
  setWidth(_uint){
    if(IsUInt(_uint)){
      return this.__local__.width := _uint
    }
    Throw, % _uint "is not UInteger."
  }
  getHeight(){
    return this.__local__.height
  }
  setHeight(_uint){
    if(IsUInt(_uint)){
      return this.__local__.height := _uint
    }
    Throw, % _uint "is not UInteger."
  }
  getFontColor(){
    return this.__local__.fontColor
  }
  setFontColor(_xdigit){
    if(IsRGB(_xdigit)){
      return this.__local__.fontColor := _xdigit
    }
    Throw, % _xdigit " is not RGB"
  }
  getBackgroundColor(){
    return this.__local__.backgroundColor
  }
  setBackgroundColor(_xdigit){
    if(IsRGB(_xdigit)){
      return this.__local__.backgroundColor := _xdigit
    }
    Throw, % _xdigit " is not RGB"
  }
  getScrollWidth(){
    return this.__local__.scrollWidth
  }
  setScrollWidth(_uint){
    if(IsUInt(_uint)){
      return this.__local__.scrollWidth := _uint
    }
    Throw, % _uint " is not UInteger."
  }
  getWindowEdgeX(){
    return this.__local__.windowEdgeX
  }
  setWindowEdgeX(_uint){
    if(IsUInt(_uint)){
      return this.__local__.windowEdgeX := _uint
    }
    Throw, % _uint " is not UInteger."
  }
  getHwnd(){
    return this.__local__.hwnd
  }
  setHwnd(_uint){
    if(IsUInt(_uint)){
      return this.__local__.hwnd := _uint
    }
    Throw, % _uint " is not UInteger."
  }
  getPid(){
    return thi.__local__.pid
  }
  setPid(_uint){
    if(IsUInt(_uint)){
      return this.__local__.pid := _uint
    }
    Throw, % _uint " is not UInteger."
  }
  getListViewClassArray(){
    return this.__local__.ListViewClassArray
  }
  setListViewClassArray(_Array){
    return this.__local__.ListViewClassArray := _Array
  }
}

;*** Label ***;
AUTOBASE_Gui_Edit_Change:
  AUOTOBASE.search()
  return