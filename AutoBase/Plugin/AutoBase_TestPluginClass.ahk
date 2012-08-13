/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class AutoBase_TestPluginClass extends PluginIF{
  __local__ := Object()
  __New(){
    PluginIF.__New.(this) ; Developerはプラグインを作る際必ず実行すること
    
    Loop, 10
    {
      this.addNormalList({icon: ""
                          , displayText: this.__Class " " A_Index
                          , searchText:  this.__Class " " A_Index})
    }
    
  }
}