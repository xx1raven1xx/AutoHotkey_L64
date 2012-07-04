/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ViewClass{
  __local__ := Object()
  
  __New(_parent){
    this.setParent(_parent)
    _GuiClass := new AutoBase_GuiClass()
  }
  
  initialize(){
    
  }
  
  makeGui(){
  }
  
  getParent(){
    return this.__local__.parent
  }
  
  setParent(_AutoBase){
    return this.__local__.parent := _AutoBase
  }
  
  getGuiClass(){
    return this.__local__.GuiClass
  }
  
  setGuiClass(_GuiClass){
    return this.__local__.GuiClass := _GuiClass
  }
}