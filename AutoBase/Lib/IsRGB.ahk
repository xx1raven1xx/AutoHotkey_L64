/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
@return 1 success
@return 0 failure
*/
IsRGB(_xdigit){
  _out := ""
  if _xdigit is xdigit
  {
    StringLeft, _out, _xdigit, 2
    if(_out != "0x"){
      _xdigit := "0x" _xdigit
    }
    _xdigit += 0
    if _xdigit between 0 and 0xFFFFFF
    {
      return 1
    }
  }
  return 0
}