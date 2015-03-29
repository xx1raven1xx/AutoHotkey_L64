CreateScript(script){
  static mScript
  StringReplace,script,script,`n,`r`n,A
  StringReplace,script,script,`r`r,`r,A
  If RegExMatch(script,"m)^[^:]+:[^:]+|[a-zA-Z0-9#_@]+\{}$"){
    If !(mScript){
      If (A_IsCompiled){
         lib := DllCall("GetModuleHandle", "ptr", 0, "ptr")
        If !(res := DllCall("FindResource", "ptr", lib, "str", ">AUTOHOTKEY SCRIPT<", "ptr", Type:=10, "ptr"))
          If !(res := DllCall("FindResource", "ptr", lib, "str", ">AHK WITH ICON<", "ptr", Type:=10, "ptr")){
            MsgBox Could not extract script!
            return
          }
        DataSize := DllCall("SizeofResource", "ptr", lib, "ptr", res, "uint")
        hresdata := DllCall("LoadResource", "ptr", lib, "ptr", res, "ptr")
        pData := DllCall("LockResource", "ptr", hresdata, "ptr")
        If (DataSize){
          mScript:=StrGet(pData,"UTF-8")
          StringReplace,mScript,mScript,`n,`r`n,A
          StringReplace,mScript,mScript,`r,`r`n,A
          StringReplace,mScript,mScript,`r`r,`r,A
          StringReplace,mScript,mScript,`n`n,`n,A
          mScript .="`r`n"
        }
      } else {
        FileRead,mScript,%A_ScriptFullPath%
        StringReplace,mScript,mScript,`n,`r`n,A
        StringReplace,mScript,mScript,`r`r,`r,A
        mScript .= "`r`n"
        Loop,Parse,mScript,`n,`r
        {
          If A_Index=1
            mScript:=""
          If RegExMatch(A_LoopField,"i)^\s*#include"){
            temp:=RegExReplace(A_LoopField,"i)^\s*#include[\s+|,]")
            If InStr(temp,"%"){
              Loop,Parse,temp,`%
              {
                If (A_Index=1)
                  temp:=A_LoopField
                else if !Mod(A_Index,2)
                  _temp:=A_LoopField
                else {
                  _temp:=%_temp%
                  temp.=_temp A_LoopField
                  _temp:=""
                }
              }
            }
            If (SubStr(temp,1,1) . SubStr(temp,0) = "<>")
              temp:=SubStr(A_AhkPath,1,InStr(A_AhkPath,"\",1,0)) "lib\" trim(temp,"<>") ".ahk"
            FileRead,_temp,%temp%
            mScript.= _temp "`r`n"
          } else mScript.=A_LoopField "`r`n"
        }
      }
    }
    Loop,Parse,script,`n,`r
    {
      If A_Index=1
        script=
      else If A_LoopField=
        Continue
      If (RegExMatch(A_LoopField,"^[^:\s]+:[^:\s=]+$")){
        StringSplit,label,A_LoopField,:
        Clipboard:=mScript
        If (label0=2 and IsLabel(label1) and IsLabel(label2)){
          script .=SubStr(mScript
            , h:=InStr(mScript,"`r`n" label1 ":`r`n")
            , InStr(mScript,"`r`n" label2 ":`r`n")-h) . "`r`n"
        }
      } else if RegExMatch(A_LoopField,"^[^\{}\s]+\{}$"){
        StringTrimRight,label,A_LoopField,2
        script .= SubStr(mScript
          , h:=RegExMatch(mScript,"i)\n" label "\([^\)\n]*\)\n?\s*\{")
          , RegExMatch(mScript,"\n}\s*\K\n",1,h)-h) . "`r`n"
      } else
        script .= A_LoopField "`r`n"
    }
  }
  StringReplace,script,script,`r`n,`n,All
  Return Script
}