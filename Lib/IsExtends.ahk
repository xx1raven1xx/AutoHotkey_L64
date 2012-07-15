/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
_SubClassが_SuperClassから継承されたものであるかを調べる
@return 0 false
@return 1 true
*/
IsExtends(_SubClass, _SuperClass){
  _Class := _SubClass
  Loop
  {
    _Class := _Class.base
    if(_Class.__Class = ""){
      return 0
    }
    if(_Class.__Class = _SuperClass.__Class){
      return 1
    }
  }
}