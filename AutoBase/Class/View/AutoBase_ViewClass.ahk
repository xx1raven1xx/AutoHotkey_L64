/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ViewClass{
  __local__ := Object()
  
  __New(){
    _GuiClass := new AutoBase_GuiClass()
    this.setGuiClass(_GuiClass)
  }
  
  init(_OperationClass){
    this.setOperationClass(_OperationClass)
  }
  
  ; from model
  ; to child
  makeGui(_GuiSettingClass){
    this.getGuiClass().makeGui(_GuiSettingClass)
  }
  
  getOperationClass(){
    return this.__local__.OperationClass
  }
  
  setOperationClass(_OperationClass){
    return this.__local__.OperationClass := _OperationClass
  }
  
  getGuiClass(){
    return this.__local__.GuiClass
  }
  
  setGuiClass(_GuiClass){
    return this.__local__.GuiClass := _GuiClass
  }
}