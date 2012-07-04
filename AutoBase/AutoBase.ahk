#persistent
SetWorkingDir, %A_ScriptDir%

AUTOBASE := new AutoBase_Class()
return

#include %A_ScriptDir%

#include ForDeveloper\AutoBase_IconClass.ahk

#include Class\AutoBase_Class.ahk
#include Class\AutoBase_ModelClass.ahk
#include Class\AutoBase_ViewClass.ahk

#include Class\Model\AutoBase_GuiSettingClass.ahk
#include Class\View\AutoBase_GuiClass.ahk