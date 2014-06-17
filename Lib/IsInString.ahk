/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
IfInStringのラッパー
*/
IsInString(_var, _searchString){
  IfInString, _var, %_searchString%
  {
    return 1
  }else{
    return 0
  }
}