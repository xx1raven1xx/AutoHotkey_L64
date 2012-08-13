/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
インスタンス化しないと使えない？
*/
Main(){
  MsgBox, % Member.getPROP()
  MsgBox, % Member.STATIC_PROP
}

class Member{
  __local__ := Object()
  static STATIC_PROP := tttt
  PROP := test
  
  __New(){
    
  }
  
  getPROP(){
    return this.PROP
  }
  getSTATIC_PROP(){
    return this.STATIC_PROP
  }
}