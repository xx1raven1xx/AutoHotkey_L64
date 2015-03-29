/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
*/
#include %A_ScriptDir%
#include .\Lib\IniClass.ahk

Main(){
    SetWorkingDir, %A_ScriptDir%
    iniFileClass := new IniClass("./testini.ini")
    iniFileClass.debug2()
}
