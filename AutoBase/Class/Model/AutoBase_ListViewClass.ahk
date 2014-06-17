/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ListViewClass{
  __local__ := Object()
  
  __New(_ModelClass){
    this.setModelClass(_ModelClass)
    this.setNormalList(new AutoBase_ModeListClass())
    this.setCommandList(new AutoBase_ModeListClass())
    this.setMenuList(new AutoBase_ModeListClass())
  }
  
  ; from PluginsClass
  ; to ModeListClass
  addPlugin(_Plugin){
    this.getNormalList().addPlugin(_Plugin, _Plugin.getNormalList())
    this.getCommandList().addPlugin(_Plugin, _Plugin.getCommandList())
    ; TODO Menuはどうする？
  }
  
  ; from search
  ; to model
  ; mode 0 normal
  ; mode 1 command
  search(_mode, _patternsArray){
    _targetList := this.getNormalList()
    _flg_last := _ret := 0
    
    if(this.getIsMenuMode()){
      ; menu mode
      _targetList := this.getMenuList()
    }else if(_mode = 1){
      _targetList := this.getCommandList()
    }
    
    _Array := _targetList.search(_patternsArray[1])
    
    Loop, % _patternsArray.MaxIndex()-1
    {
      B_Index := A_Index - 1
      _NewArray := Array()
      Loop, % _Array.MaxIndex()
      {
        _ret := RegExMatch(_Array[A_Index].getSearchText(), _patternsArray[B_Index])
        if(_ret){
          _NewArray.Insert(_Array[A_Index])
        }
      }
      _Array := _NewArray
    }
    
    this.getModelClass().registerListView(_Array)
  }
  
  ;*** getter setter ***;
  getModelClass(){
    return this.__local__.ModelClass
  }
  setModelClass(_ModelClass){
    return this.__local__.ModelClass := _ModelClass
  }
  getNormalList(){
    return this.__local__.normalList
  }
  setNormalList(_ModeListClass){
    if(_ModeListClass.__Class = "AutoBase_ModeListClass"){
      return this.__local__.normalList := _ModeListClass
    }
    Throw, % "_ModeListClass don't extends AutoBase_ModeListClass"
  }
  getCommandList(){
    return this.__local__.commandList
  }
  setCommandlList(_ModeListClass){
    if(_ModeListClass.__Class = "AutoBase_ModeListClass"){
      return this.__local__.commandList := _ModeListClass
    }
    Throw, % "_ModeListClass don't extends AutoBase_ModeListClass"
  }
  getMenuList(){
    return this.__local__.menuList
  }
  setMenuList(_ModeListClass){
    if(_ModeListClass.__Class = "AutoBase_ModeListClass"){
      return this.__local__.menuList := _ModeListClass
    }
    Throw, % "_ModeListClass don't extends AutoBase_ModeListClass"
  }
  getIsMenuMode(){
    return this.__local__.isMenuMode
  }
  setIsMenuMode(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isMenuMode := _bool
    }
    Throw, % _bool " is not boolean"
  }
}

/*
ListClassをPluginごとに複数持つクラス
NormalList
CommandList
MenuList
用に3つ作成している
*/
class AutoBase_ModeListClass{
  __local__ := Object()
  
  __New(){
    this.setPluginArray(Array())
    this.setPluginIndexArray(Array()) ; PluginをIndexごとに整列させるときに使う
  }
  
  ; from ListViewClass
  addPlugin(_Plugin, _ListPtr){
    this.getPluginArray()[_Plugin.__Class] := _ListPtr ; Listのポインタと結びつける
    this.getPluginIndexArray().Insert(_Plugin.__Class) ; _Pluginの名前をIndexに登録
  }
  
  removePlugin(_pluginName){
    ; TODO
  }
  
  ;TODO
  ; 検索ついでに一次元配列にする
  search(_pattern){
    _Array := Array()
    
    Loop, % this.getPluginIndexArray().MaxIndex()
    {
      _pluginName  := this.getPluginIndexArray()[A_Index]
      _pluginArray := this.getPluginArray()[_pluginName]
      Loop, % _pluginArray.MaxIndex()
      {
        _ret := RegExMatch(_pluginArray[A_Index].getSearchText(), _pattern)
        if(_ret){
          ; hit
          _Array.Insert(_pluginArray[A_Index])
        }
      }
    }
    return _Array
  }
  
  ;*** getter setter ***;
  getPluginArray(){
    return this.__local__.pluginArray
  }
  setPluginArray(_pluginArray){
    return this.__local__.pluginArray := _pluginArray
  }
  getPluginIndexArray(){
    return this.__local__.pluginIndexArray
  }
  setPluginIndexArray(_pluginIndexArray){
    return this.__local__.pluginIndexArray := _pluginIndexArray
  }
}

/*
このクラスが実際にListViewに一個一個並ぶ
*/
class AutoBase_ListClass{
  __local__ := Object()
  
  __New(_Plugin, _icon, _displayText, _searchText, _keyPressFunctionName, _dragAndDropFunctionName, _otherParams){
    this.setPlugin(_Plugin)
    this.setIcon(_icon)
    this.setDisplayText(_displayText)
    this.setSearchText(_searchText)
    this.setKeyPressFunctionName(_keyPressFunctionName)
    this.setDragAndDropFunctionName(_dragAndDropFunctionName)
    this.setOtherParams(_otherParams)
  }
  
  ; TODO key, ev
  execKeyPress(){
    _Plugin := this.getPlugin()
    _func := _plugin[this.getKeyPressFunctionName()]
    _funcArg := IsFunc(_func)
    if(_funcArg){
      ; TODO num
      %_func%()
    }
  }
  
  execDragAndDrop(){
    ; TODO same execKeyPress
  }
  
  getPlugin(){
    return this.__local__.Plugin
  }
  setPlugin(_Plugin){
    if(IsExtends(_Plugin, AutoBase_PluginIF)){
      return this.__local__.Plugin := _Plugin
    }
    Throw, % _Plugin.__Class " don't extend AutoBase_PluginIF"
  }
  getIcon(){
    return this.__local__.icon
  }
  setIcon(_icon){
    return this.__local__.icon := _icon
  }
  getDisplayText(){
    return this.__local__.displayText
  }
  setDisplayText(_displayText){
    return this.__local__.displayText := _displayText
  }
  getSearchText(){
    return this.__local__.searchText
  }
  setSearchText(_searchText){
    return this.__local__.searchText := _searchText
  }
  getKeyPressFunctionName(){
    return this.__local__.keyPressFunctionName
  }
  setKeyPressFunctionName(_keyPressFunctionName){
    return this.__local__.keyPressFunctionName := _keyPressFunctionName
  }
  getDragAndDropFunctionName(){
    return this.__local__.dragAndDropFunctionName
  }
  setDragAndDropFunctionName(_dragAndDropFunctionName){
    return this.__local__.dragAndDropFunctionName := _dragAndDropFunctionName
  }
  getOtherParams(){
    return this.__local__.otherParams
  }
  setOtherParams(_otherParams){
    return this.__local__.otherParams := _otherParams
  }
}