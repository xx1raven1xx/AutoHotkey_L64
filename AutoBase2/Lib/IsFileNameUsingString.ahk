/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
@return 1 ファイル名に使える文字列
@return 0 ファイル名に使えない文字列
*/
IsFileNameUsingString(_string){
  _pattern = [\\/:\*\?"<>|]
  _return := RegExMatch(_string, _pattern)
  if(_return = 0){
    return 1
  }else{
    return 0
  }
}