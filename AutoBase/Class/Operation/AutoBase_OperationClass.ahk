/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_OperationClass{
  __local__ := Object()
  
  __New(){
    _ViewClass := new AutoBase_ViewClass(this)
    _ModelClass := new AutoBase_ModelClass(this)
    
    this.setModelClass(_ModelClass)
    this.setViewClass(_ViewClass)
    this.init()
    this.start()
  }
  
  init(){
    this.getModelClass().init(this.getViewClass())
    this.getViewClass().init(this)
  }
  
  start(){
    this.getModelClass().loadAndMakeGui()
    this.getModelClass().loadPlugins()
    this.search("")
  }
  
  ; from class
  ; to model
  search(_searchString){
    this.getModelClass().search(_searchString)
  }
  
  ; from class
  ; to Model
  keyEvent(_keyString){
    this.getModelClass().keyEvent(_keyString)
  }
  
  ;*** getter setter ***;
  getModelClass(){
    return this.__local__.ModelClass
  }
  setModelClass(_ModelClass){
    return this.__local__.ModelClass := _ModelClass
  }
  getViewClass(){
    return this.__local__.ViewClass
  }
  setViewClass(_ViewClass){
    return this.__local__.ViewClass := _ViewClass
  }
}