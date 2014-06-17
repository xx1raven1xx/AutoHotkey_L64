return

class AutoBase_Hook{
  static __static__ := new AutoBase_Hook_Memory()
  __local__ := Object()
  
  
  __New(){
    
  }
  
  addHook(){
    
  }
  
  execHook(_eventName, _params){
    
  }
  
  getMemoryClass(){
    return this.__static__
  }
}

/*
Developer は気にしなくて良いクラス
*/
class AutoBase_Hook_Memory{
  __local__ := Object()
  
  __New(){
    
  }
}