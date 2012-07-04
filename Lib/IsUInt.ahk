/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
@return 1 success
@return 0 failure
*/
IsUInt(_uint){
  if _uint is integer
  {
    if(_uint >= 0){
      return 1
    }
  }
  return 0
}