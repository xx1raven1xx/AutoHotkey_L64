/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ModelClass{
  __local__ := Object()
  
  __New(){
    this.setIniFile(new FileClass("AutoBase.ini"))
    _plugin := new PluginIF()
    _plugin.__init() ; PluginIFの初期化
  }
  
  init(_ViewClass){
    this.setViewClass(_ViewClass)
    this.setGuiSettingClass(new AutoBase_GuiSettingClass(this))
    this.setLoadPluginClass(new AutoBase_LoadPluginClass(this.getIniFile().getFilePath()))
    this.setPluginsClass(new AutoBase_PluginsClass(this))
    this.setListViewClass(new AutoBase_ListViewClass(this))
    this.setSearchClass(new AutoBase_SearchClass(this.getIniFile().getFilePath()))
    this.setKeyClass(new AutoBase_KeyClass(this))
    
    this.start()
  }
  
  start(){
    this.getLoadPluginClass().init(this.getPluginsClass())
    this.getSearchClass().init(this.getListViewClass())
  }
  
  ; from operation
  ; to this
  loadAndMakeGui(){
    this.makeGui(this.getGuiSettingClass())
  }
  
  ; from this
  ; to view
  makeGui(_GuiSettingClass){
    this.getViewClass().makeGui(_GuiSettingClass)
  }
  
  ; from operation
  ; to loadPlugin
  loadPlugins(){
    this.getLoadPluginClass().loadPlugins()
  }
  
  ; from operation
  ; to search
  search(_searchString){
    this.getSearchClass().search(_searchString)
  }
  
  ; from ListView
  ; to ViewClass
  registerListView(_Array){
    this.getViewClass().registerListView(_Array)
  }
  
  ; from Operation
  ; to KeyClass
  keyEvent(_keyString){
    this.getKeyClass().keyEvent(_keyString)
  }
  
  ; from KeyClass
  ; to ViewClass
  moveListViewEvent(_direction, _repeatOn=0){
    this.getViewClass().moveListViewEvent(_direction, _repeatOn)
  }
  
  ; from KeyClass
  ; to ViewClass
  sendListViewKeyEvent(_event){
    this.getViewClass().sendListViewKeyEvent(_event)
  }
  
  ;*** getter setter ***;
  getViewClass(){
    return this.__local__.ViewClass
  }
  setViewClass(_ViewClass){
    return this.__local__.ViewClass := _ViewClass
  }
  getIniFile(){
    return this.__local__.iniFile
  }
  setIniFile(_iniFile){
    return this.__local__.iniFile := _iniFile
  }
  getGuiSettingClass(){
    return this.__local__.GuiSettingClass
  }
  setGuiSettingClass(_GuiSettingClass){
    return this.__local__.GuiSettingClass := _GuiSettingClass
  }
  getLoadPluginClass(){
    return this.__local__.LoadPluginClass
  }
  setLoadPluginClass(_LoadPluginClass){
    return this.__local__.LoadPluginClass := _LoadPluginClass
  }
  getPluginsClass(){
    return this.__local__.PluginsClass
  }
  setPluginsClass(_PluginsClass){
    return this.__local__.PluginsClass := _PluginsClass
  }
  getListViewClass(){
    return this.__local__.ListViewClass
  }
  setListViewClass(_ListViewClass){
    return this.__local__.ListViewClass := _ListViewClass
  }
  getSearchClass(){
    return this.__local__.SearchClass
  }
  setSearchClass(_SearchClass){
    return this.__local__.SearchClass := _SearchClass
  }
  getKeyClass(){
    return this.__local__.KeyClass
  }
  setKeyClass(_Class){
    return this.__local__.KeyClass := _Class
  }
}