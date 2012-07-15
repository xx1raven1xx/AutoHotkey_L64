/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_LangClass{
  static __static__ := new AutoBase_LangClass_Memory("jp")
  __local__ := Object()
  
  __New(){
  }
  
  getMessage(_messagePattern){
    return this.getMemory().getMessage(_messagePattern)
  }
  
  setMessage(_messagePattern, _messageText){
    
  }
  
  getMemory(){
    return this.__static__
  }
  
  getCountry(){
    return this.getMemory().getCountry()
  }
  
  setCountry(_countryChars){
    return this.getMemory().setCountry(_countryChars)
  }
}

class AutoBase_LangClass_Memory{
  __local__ := Object()
  
  __New(_countryChars="jp"){
    this.setCountry(_countryChars)
    this.setDict(Object()) ; TODO
  }
  
  getMessage(_messagePattern){
    ; TODO
    ;return this.__local__.
  }
  
  setMessage(_messagePattern, _messageText){
    
  }
  
  getCountry(){
    return this.__local__.country
  }
  setCountry(_countryChars){
    return this.__local__.country := _countryChars
  }
  getDict(){
    return this.__local__.dict
  }
  setDict(_dict){
    return this.__local__.dict := _dict
  }
}