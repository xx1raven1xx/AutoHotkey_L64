/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/01/05 new
*/

#include <EClass2>

class AutoBaseSettingClass extends EClass2
{
  __local__ := Object()
  __local__.lang := ""
  __local__.test := ""
  ; lang 国コード 本来なら国識別用のクラスが必要
  
  __New()
  {
    ; 初期設定
    this.setLang("ja")
    ;this.test := "aaa"
    ;MsgBox, % this.test
  }
  
  ; debug copy
  __Call(aName)
  {
    EClass2.__Call(this, aName)
  }
  
  ; getter setter
  getLang()
  {
    return this.__local__.lang
  }
  setLang(str_lang)
  {
    return this.__local__.lang := str_lang
  }
}