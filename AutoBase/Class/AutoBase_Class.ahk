/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_Class{
  __local__ := Object()
  
  __New(){
    _OperationClass := new AutoBase_OperationClass()
    this.setOperationClass(_OperationClass)
  }
  
  ; from global
  ; to operation
  search(){
    GuiControlGet, _edit,, AUTOBASE_Gui_Edit
    this.getOperationClass().search(_edit)
  }
  
  ; from global
  ; to operation
  keyEvent(_keyString){
    this.getOperationClass().keyEvent(_keyString)
  }
  
  getHwnd(){
    return this.getOperationClass().getViewClass().getGuiClass().getHwnd()
  }
    
  ;*** getter setter ***;
  getOperationClass(){
    return this.__local__.OperationClass
  }
  setOperationClass(_OperationClass){
    return this.__local__.OperationClass := _OperationClass
  }
}