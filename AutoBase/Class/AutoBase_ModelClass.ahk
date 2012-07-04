/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ModelClass{
  __local__ := Object()
  
  __New(){
    this.setIniFileClass("AutoBase.ini")
    this.setGuiSettingClass(new AutoBase_GuiSettingClass())
  }
  
  getIniFileClass(){
    return this.__local__.iniFile
  }
  
  setIniFileClass(_iniFilePath){
    return this.__local__.iniFile := new FileClass(_iniFilePath)
  }
  
  getGuiSettingClass(){
    return this.__local__.GuiSettingClass
  }
  
  setGuiSettingClass(_GuiSettingClass){
    return this.__local__.GuiSettingClass := _GuiSettingClass
  }
}