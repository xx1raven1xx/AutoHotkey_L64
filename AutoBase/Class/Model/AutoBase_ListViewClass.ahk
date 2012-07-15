/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ListViewClass{
  __local__ := Object()
  
  __New(){
    this.setNormalList(new AutoBase_ModeListClass())
    this.setCommandList(new AutoBase_ModeListClass())
    this.setMenuList(new AutoBase_ModeListClass())
  }
  
  addPlugin(_Plugin){
    this.getNormalList().addPlugin(_Plugin, _Plugin.getNormalList())
    this.getCommandList().addPlugin(_Plugin, _Plugin.getCommandList())
    ; TODO Menuはどうする？
  }
  
  ;*** getter setter ***;
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
  
  addPlugin(_Plugin, _ListPtr){
    this.getPluginArray().Insert(_ListPtr) ; Listのポインタと結びつける
    this.getPluginIndexArray().Insert(_Plugin.__Class) ; _Pluginの名前をIndexに登録
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