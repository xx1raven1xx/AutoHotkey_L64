/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_Class{
  __local__ := Object()
  
  __New(){
    _View := new AutoBase_ViewClass(this)
    this.setView(_View)
  }
  
  
  getModel(){
    return this.__local__.Model
  }
  setModel(_Model){
    this.__local__.Model := _Model
  }
  getOperation(){
    return this.__local__.Operation
  }
  setOperation(_Operation){
    this.__local__.Operation := _Operation
  }
  getView(){
    return this.__local__.View
  }
  setView(_View){
    this.__local__.View := _View
  }
  getEvent(){
    return this.__local__.Event
  }
  setEvent(_Event){
    this.__local__.Event := _Event
  }
}