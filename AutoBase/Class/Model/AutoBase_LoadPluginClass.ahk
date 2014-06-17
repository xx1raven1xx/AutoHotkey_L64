/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_LoadPluginClass{
  __local__ := Object()
  
  __New(_iniFilePath){
    this.loadIni(_iniFilePath)
    this.setFilePath()
  }
  
  init(_PluginsClass){
    this.setPluginsClass(_PluginsClass)
  }
  
  loadPlugins(){
    FileEncoding, UTF-8
    _line := _getLeftChar := _result := _$ := _$1 := _outFileName := _outNameNoExt := _PluginString := ""
    Loop, Read, % this.getPluginsAhkFilePath()
    {
      _line   := Trim(A_LoopReadLine)
      if(_line = "")
        Continue
      StringLeft, _getLeftChar, _line, 1
      if(_getLeftChar = ";"){
        Continue ;が最初に存在する行はコメントとみなす
      }
      _result := RegExMatch(_line, "i)\#include[\s\t]+(.*)", _$)
      if(_result){
        SplitPath, _$1,,,, _outNameNoExt
        _PluginString := _outNameNoExt
        this.addPlugin(_PluginString)
      }
    }
    
  }
  
  loadIni(_iniFilePath){
    _pluginsAhkFilePath := ""
    ;IniRead, _pluginsAhkFilePath, %_iniFilePath%, LoadPluginsClass, PluginsAhkFilePath, Plugins.ahk
    _pluginsAhkFilePath := IniRead(_iniFilePath, "LoadPluginsClass", "PluginsAhkFilePath", "Plugins.ahk")
    this.setPluginsAhkFilePath(_pluginsAhkFilePath)
  }
  
  getPluginsAhkFilePath(){
    return this.__local__.pluginsAhkFilePath
  }
  
  setPluginsAhkFilePath(_pluginsAhkFilePath){
    IfExist, %_pluginsAhkFilePath%
    {
      return this.__local__.pluginsAhkFilePath := _pluginsAhkFilePath
    }
    Throw, % _pluginsAhkFilePath " is not exist"
  }
  
  addPlugin(_PluginString){
    this.getPluginsClass().addPlugin(_PluginString)
  }
  
  getPluginsClass(){
    return this.__local__.PluginsClass
  }
  
  setPluginsClass(_PluginsClass){
    return this.__local__.PluginsClass := _PluginsClass
  }
}