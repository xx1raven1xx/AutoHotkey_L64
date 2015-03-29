/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_KeyClass{
  __local__ := Object()
  
  __New(_ModelClass){
    this.setModelClass(_ModelClass)
    this.setIsDownPress(0)
    this.setIsDownRepeat(0)
    this.setIsUpPress(0)
    this.setIsUpRepeat(0)
  }
  
  ; from ModelClass
  ; TODO NOW
  keyEvent(_key){
    if(_key = "escape" || _key = "esc"){
      this.keyEscape()
    }else if(_key = "enter"){
      this.keyEnter()
    }else if(_key = "up"){
      this.keyUpDown(1)
    }else if(_key = "down"){
      this.keyUpDown(0)
    }else if(_key = "upoff"){
      this.keyUpDownOff(1)
    }else if(_key = "downoff"){
      this.keyUpDownOff(0)
    }else{
      Throw, % _key " is undefined keyEvent"
    }
  }
  
  keyUpDown(_isUp){
    if(this.getIsUpDownPress(_isUp) = 1){
      this.keyUpDownRepeat(_isUp)
    }
    this.setIsUpDownPress(_isUp, 1)
  }
  
  keyUpDownRepeat(_isUp){
    this.setIsUpDownRepeat(_isUp, 1)
    if(_isUp = 0){
      this.getModelClass().moveListViewEvent("down", 1)
    }else if(_isUp = 1){
      this.getModelClass().moveListViewEvent("up", 1)
    }
  }
  
  keyUpDownOff(_isUp){
    if(this.getIsUpDownRepeat(_isUp)){
      this.setIsUpDownRepeat(_isUp, 0)
    }else{
      if(_isUp = 0){
        this.getModelClass().moveListViewEvent("down")
      }else if(_isUp = 1){
        this.getModelClass().moveListViewEvent("up")
      }
    }
    this.setIsUpDownPress(_isUp, 0)
  }
  
  ; to ModelClass
  keyEscape(){
    this.getModelClass().sendListViewKeyEvent("escape")
  }
  
  ; to ModelClass
  keyEnter(){
    this.getModelClass().sendListViewKeyEvent("enter")
  }
  
  ;*** getter setter ***;
  getModelClass(){
    return this.__local__.ModelClass
  }
  setModelClass(_Class){
    if(IsExtends(_Class, AutoBase_ModelClass)){
      return this.__local__.ModelClass := _Class
    }
    Throw, % "This _Class don't extend AutoBase_ModelClass"
  }
  getIsUpPress(){
    return this.__local__.isUpPress
  }
  setIsUpPress(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isUpPress := _bool
    }
    Throw, % _bool " is not boolean"
  }
  getIsDownPress(){
    return this.__local__.isDownPress
  }
  setIsDownPress(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isDownPress := _bool
    }
    Throw, % _bool " is not boolean"
  }
  getIsUpRepeat(){
    return this.__local__.isUpRepeat
  }
  setIsUpRepeat(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isUpRepeat := _bool
    }
    Throw, % _bool " is not boolean"
  }
  getIsDownRepeat(){
    return this.__local__.isDownRepeat
  }
  setIsDownRepeat(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isDownRepeat := _bool
    }
    Throw, % _bool " is not boolean"
  }
  getIsUpDownRepeat(_isUp){
    if(_isUp = 0){
      return this.getIsDownRepeat()
    }else if(_isUp = 1){
      return this.getIsUpRepeat()
    }
    Throw, % _isUp " is not boolean"
  }
  setIsUpDownRepeat(_isUp, _bool){
    if(_isUp = 0){
      return this.setIsDownRepeat(_bool)
    }else if(_isUp = 1){
      return this.setIsUpRepeat(_bool)
    }
    Throw, % _isUp " is not boolean"
  }
  getIsUpDownPress(_isUp){
    if(_isUp = 0){
      return this.getIsDownPress()
    }else if(_isUp = 1){
      return this.getIsUpPress()
    }
    Throw, % _isUp " is not boolean"
  }
  setIsUpDownPress(_isUp, _bool){
    if(_isUp = 0){
      return this.setIsDownPress(_bool)
    }else if(_isUp = 1){
      return this.setIsUpPress(_bool)
    }
    Throw, % _isUp " is not boolean"
  }
}
