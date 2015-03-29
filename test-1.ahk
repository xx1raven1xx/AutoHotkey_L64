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
    _i := 1
    _sum := 0
    Loop, 1000
    {
        _sum += _i
        _i += 1
    }
    MsgBox, % _sum
}

class TestClass{
  __local__ := Object()
  __New(){
    __local__.Object
  }
}
