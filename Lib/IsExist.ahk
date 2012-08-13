/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
ただのIfExistのラッパー
@return 0 not exist
@return 1 exist
*/
IsExist(_filePath){
  IfExist, %_filePath%
  {
    return 1
  }else{
    return 0
  }
}