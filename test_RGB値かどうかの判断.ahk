/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
RGB値かどうかの判断
*/
Main(){
  color := "123ABC"
  IsColor(color)
  IsColor("FFFFFF1")
  color1 := 0xFFFFFF1
  color2 := 0xFFFFFF
  IsColor(color1)
  IsColor(color2)
}

IsColor(_xdigit){
  StringLeft, _out, _xdigit, 2
  if(_out != "0x"){
    _xdigit := "0x" _xdigit
  }
  _xdigit += 0
  if _xdigit is xdigit
  {
    if _xdigit between 0 and 0xFFFFFF
    {
      MsgBox % _xdigit " is ok1"
      return
    }
  }
  MsgBox % _xdigit " is no"
}