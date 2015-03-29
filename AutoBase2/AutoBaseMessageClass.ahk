/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/07/06 new
*/

class AutoBaseMessageClass
{
  __local__ := {lang: ""}
  
  __New(str_lang)
  {
    this.Init(str_lang)
  }
  
  Init(str_lang)
  {
    this.lang := str_lang
  }
  
  ; 例）
  ; message({"ja": "日本語", "en": "english"})
  message(dic)
  {
    if(ObjHasKey(dic, this.lang))
    {
      return dic[this.lang]
    }
  }
  
  ;alias
  M(dic)
  {
    return this.message(dic)
  }
}