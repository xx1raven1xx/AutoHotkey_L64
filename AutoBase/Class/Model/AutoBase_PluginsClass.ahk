/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_PluginsClass{
  __local__ := Object()
  
  __New(_ModelClass){
    this.setModelClass(_ModelClass)
    this.setPlugins(Array())
  }
  
  addPlugin(_PluginString){
    _Plugin := new %_PluginString%()
    if(IsExtends(_Plugin, AutoBase_PluginIF)){
      this.getModelClass().getListViewClass().addPlugin(_Plugin)
      this.getPlugins().Insert(_Plugin)
    }
  }
  
  getModelClass(){
    return this.__local__.ModelClass
  }
  setModelClass(_ModelClass){
    return this.__local__.ModelClass := _ModelClass
  }
  getPlugins(){
    return this.__local__.Plugins
  }
  setPlugins(_Plugins){
    return this.__local__.Plugins := _Plugins
  }
}