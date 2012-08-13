/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_SearchClass{
  __local__ := Object()
  
  __New(_iniFilePath){
    this.setIniFilePath(_iniFilePath)
    this.loadSetting()
  }
  
  init(_ListViewClass){
    this.setListViewClass(_ListViewClass)
  }
  
  loadSetting(){
    _iniFilePath := this.getIniFilePath()
    _useMigemo      := IniRead(_iniFilePath, "Search", "UseMigemo", 0)
    _migemoDllPath  := IniRead(_iniFilePath, "Search", "MigemoDllPath", "")
    _migemoDictPath := IniRead(_iniFilePath, "Search", "MigemoDictPath", "")
    this.setUseMigemo(_useMigemo)
    this.setMigemoDllPath(_migemoDllPath)
    this.setMigemoDictPath(_migemoDictPath)
  }
  
  ; from model
  ; to ListViewClass
  search(_searchString){
    _mode := 0
    StringLeft, _leftChar, _searchString, 1
    if(_leftChar = "/"){
      _mode := 1
    }
    if(_searchString)
    StringSplit, _$, _searchString, %A_Space%
    _patterns := Array()
    Loop, %_$0%
    {
      if(this.getUseMigemo()){
        ; use migemo
      }else{
        ; non't use migemo
        _regStr := _$%A_Index%
        _regStr := "i)" _regStr
        _patterns.Insert(_regStr)
      }
    }
    this.getListViewClass().search(_mode, _patterns)
  }
  
  ;*** getter setter ***;
  getIniFilePath(){
    return this.__local__.iniFilePath
  }
  setIniFilePath(_iniFilePath){
    if(IsExist(_iniFilePath)){
      return this.__local__.iniFilePath := _iniFilePath
    }
    Throw, % _iniFilePath " is not exist"
  }
  getListViewClass(){
    return this.__local__.ListViewClass
  }
  setListViewClass(_ListViewClass){
    return this.__local__.ListViewClass := _ListViewClass
  }
  getUseMigemo(){
    return this.__local__.useMigemo
  }
  setUseMigemo(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.useMigemo := _bool
    }
    Throw, % _bool " is not boolean"
  }
  getMigemoDllPath(){
    return this.__local__.migemoDllPath
  }
  setMigemoDllPath(_migemoDllPath){
    if(_migemoDllPath = ""){
      return
    }
    if(IsExist(_migemoDllPath)){
      return this.__local__.migemoDllPath := _migemoDllPath
    }
    Throw, % _migemoDllPath " is not exist"
  }
  getMigemoDictPath(){
    return this.__local__.migemoDictPath
  }
  setMigemoDictPath(_migemoDictPath){
    if(_migemoDllPath = ""){
      return
    }
    if(IsExist(_migemoDictPath)){
      return this.__local__.migemoDictPath := _migemoDictPath
    }
    Throw, % _migemoDictPath " is not exist"
  }
}