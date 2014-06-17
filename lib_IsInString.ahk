/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
普通に文字列を渡す間隔でよい
*/
Main(){
  _string := "aaaaaaaaaaaaaaaabbbbc"
  MsgBox, % IsInString(_string, "c")
  MsgBox, % IsInString("abc", "c")
}