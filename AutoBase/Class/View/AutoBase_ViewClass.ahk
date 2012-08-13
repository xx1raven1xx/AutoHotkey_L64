/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ViewClass{
  __local__ := Object()
  
  __New(){
    this.setGuiClass(new AutoBase_GuiClass())
  }
  
  init(_OperationClass){
    this.setOperationClass(_OperationClass)
  }
  
  ; from model
  ; to child
  makeGui(_GuiSettingClass){
    this.getGuiClass().makeGui(_GuiSettingClass)
  }
  
  ; from ModelClass
  ; to Gui
  registerListView(_Array){
    this.getGuiClass().registerListView(_Array)
  }
  
  ; from ModelClass
  ; to GuiClass
  moveListViewEvent(_direction="", _repeatOn=0){
    this.getGuiClass().moveListViewEvent(_direction, _repeatOn)
  }
  
  ; from ModelClass
  ; to GuiClass
  sendListViewKeyEvent(_event){
    this.getGuiClass().sendListViewKeyEvent(_event)
  }
  
  ;*** getter setter ***;
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