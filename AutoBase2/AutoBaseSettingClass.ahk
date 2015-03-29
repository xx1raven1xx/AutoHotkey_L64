/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/07/06 new
*/

class AutoBaseSettingClass
{
  __local__ := {lang : ""} 
  
  __New()
  {
    ; 初期設定
    this.__local__.lang := "ja"
  }
  
  ; getter setter
  getLang()
  {
    return this.__local__.lang
  }
}