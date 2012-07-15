/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_ModelClass{
  __local__ := Object()
  
  __New(){
    this.setIniFile(new File("AutoBase.ini"))
    _plugin := new PluginIF()
    _plugin.__init() ; PluginIFの初期化
  }
  
  init(_ViewClass){
    this.setViewClass(_ViewClass)
    this.setGuiSettingClass(new AutoBase_GuiSettingClass(this))
    this.setLoadPluginClass(new AutoBase_LoadPluginClass(this.getIniFile().getFilePath()))
    this.setPluginsClass(new AutoBase_PluginsClass(this))
    this.setListViewClass(new AutoBase_ListViewClass())
    
    this.start()
  }
  
  start(){
    this.getLoadPluginClass().init(this.getPluginsClass())
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
}