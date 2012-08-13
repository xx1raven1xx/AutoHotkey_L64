/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
*/
#include %A_ScriptDir%
#include .\Lib\FileClass.ahk

Main(){
  SetWorkingDir, %A_ScriptDir%
  ;_t := new FileClass("D:\Dropbox\GitHub\AutoHotkey_L64\")
  ;_t.debug()
  ;_t := new FileClass("..\....\ttt\test.jpg")
  ;_t.debug()
  ;_t := new FileClass("\\shared\temp\test.jpg")
  ;_t.debug()
  ;_t := new FileClass("Z:\dir\temp\test.jpg")
  ;_t.debug()
  ;_t := new FileClass("\\shared\dir\..\temp\..\test.jpg")
  ;_t.debug()
  ;_t := new FileClass("\\shared\dir\..\temp\test\")
  ;_t.debug()
  ;_t := new FileClass("\\shared\dir\......\temp\test\")
  ;_t.debug()
  _t := new FileClass("X:\dir\......\temp\test\")
  _t.debug()
}