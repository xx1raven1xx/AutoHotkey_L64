/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
*/

Main(){
  _testDir := "D:\test\test_app_MoveFiles"
  
  _ahk           := "W:\Software\Program\AutoHotkey_L64\AutoHotkey.exe"
  _sourceDir     := _testDir "\source"
  _sourcePattern := _sourceDir "\*"
  _destDir       := _testDir "\test"
  _mode          := "move"
  _isOW          := "md5"
  _char          := "-"
  
  ;FileCopy, %_testDir%\yellow.bmp, %_sourceDir%\color.bmp
  ;Run, %_ahk% %A_ScriptDir%\app_MoveFiles.ahk %_sourcePattern% %_destDir% %_mode% %_isOW% %_char%, %A_ScriptDir%
  
  ;Sleep, 10000
  ;FileCopy, %_testDir%\blue.bmp, %_sourceDir%\color2.bmp
  ;Run, %_ahk% %A_ScriptDir%\app_MoveFiles.ahk %_sourcePattern% %_destDir% %_mode% %_isOW% %_char%, %A_ScriptDir%
  
  ;Sleep, 10000
  ;FileCopy, %_testDir%\pink.bmp, %_sourceDir%\color3.bmp
  ;Run, %_ahk% %A_ScriptDir%\app_MoveFiles.ahk %_sourcePattern% %_destDir% %_mode% %_isOW% %_char%, %A_ScriptDir%
  
  ;Sleep, 10000
  FileCopy, %_testDir%\pink.bmp, %_sourceDir%\color2.bmp
  Run, %_ahk% %A_ScriptDir%\app_MoveFiles.ahk %_sourcePattern% %_destDir% %_mode% %_isOW% %_char%, %A_ScriptDir%
}