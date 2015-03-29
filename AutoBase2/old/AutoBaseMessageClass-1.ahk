/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/01/06 new
*/

#include <EClass>

class AutoBaseMessageClass extends EClass
{
  __local__ := Object({
    lang: ""
  })
  
  __New(str_lang)
  {
    this.setLang(str_lang)
  }
  
  Init(str_lang)
  {
    this.setLang(str_lang)
  }
  
  ; debug copy
  __Call(aName)
  {
    EClass.__Call(this, aName)
  }
  
  ; 例）
  ; message({"ja": "日本語", "en": "english"})
  message(dic)
  {
    if(ObjHasKey(dic, this.getLang()))
    {
      return dic[this.getLang()]
    }
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
  
  ;alias
  M(dic)
  {
    return this.message(dic)
  }
}