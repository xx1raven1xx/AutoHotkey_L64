/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/

#persistent
SetWorkingDir, %A_ScriptDir%

AUTOBASE := new AutoBase_Class()
return

#include %A_ScriptDir%

; top
#include Class\AutoBase_Class.ahk

; for developer
#include ForDeveloper\AutoBase_IconClass.ahk
#include ForDeveloper\AutoBase_PluginIF.ahk

; global
;#include Class\Global\AutoBase_Hook.ahk
;#include Class\Global\AutoBase_LangClass.ahk

; model
#include Class\Model\AutoBase_GuiSettingClass.ahk
#include Class\Model\AutoBase_ListViewClass.ahk
#include Class\Model\AutoBase_LoadPluginClass.ahk
#include Class\Model\AutoBase_ModelClass.ahk
#include Class\Model\AutoBase_PluginsClass.ahk
#include Class\Model\AutoBase_SearchClass.ahk

; operation
#include Class\Operation\AutoBase_OperationClass.ahk

; view
#include Class\View\AutoBase_GuiClass.ahk
#include Class\View\AutoBase_ViewClass.ahk

; lib class
#include Lib\FileClass.ahk

; plugin
#include Plugins.ahk