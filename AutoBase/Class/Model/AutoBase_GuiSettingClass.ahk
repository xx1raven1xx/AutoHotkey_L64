/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_GuiSettingClass{
  __local__ := Object()
  
  __New(_Parent){
    this.setParent(_Parent)
    this.loadSetting()
  }
  
  loadSetting(){
    _iniPath := this.getIniFilePath()
    IniRead, _w,  %_iniPath%, GuiClass, Width,  500
    IniRead, _h,  %_iniPath%, GuiClass, Height, 300
    IniRead, _fc, %_iniPath%, GuiClass, FontColor, FFFFFF
    IniRead, _bc, %_iniPath%, GuiClass, BackgroundColor, 313131
    this.setWidth(_w)
    this.setHeight(_h)
    this.setFontColor(_fc)
    this.setBackgroundColor(_bc)
  }
  
  getIniFilePath(){
    return this.getParent().getIniFileClass().getFilePath()
  }
  
  getParent(){
    return this.__local__.Parent
  }
  
  setParent(_Parent){
    return this.__local__.Parent := _Parent
  }
  
  getWidth(){
    return this.__local__.width
  }
  
  setWidth(_uint){
    if(IsUInt(_uint)){
      return this.__local__.width := _uint
    }
    Throw, % _uint " is not UInteger"
  }
  
  getHeight(){
    return this.__local__.height
  }
  
  setheight(_uint){
    if(IsUInt(_uint)){
      return this.__local__.height := _uint
    }
    Throw, % _uint " is not UInteger"
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
}