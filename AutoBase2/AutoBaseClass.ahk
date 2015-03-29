/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/07/06 new
*/

#include ./AutoBaseSettingClass.ahk
#include ./AutoBaseOnMessageClass.ahk
#include ./AutoBaseMessageClass.ahk
#include ./AutoBaseListViewClass.ahk


class AutoBaseClass
{
  __local__ := Object()
  ; SettingClass
  ; MessageClass
  ; OnMessageClass
  ; ListViewClass

  __New()
  {
    this.__local__.SettingClass := new AutoBaseSettingClass()
    this.__local__.OnMessageClass := new AutoBaseOnMessageClass()
    this.__local__.MessageClass := new AutoBaseMessageClass(this.getSettingClass().getLang())
    
    this.__local__.ListViewClass := new AutoBaseListViewClass()
    this.__local__.ListViewClass.makeGui()
  }

  ; getter setter
  getSettingClass()
  {
    return this.__local__.SettingClass
  }
  
  getMessageClass()
  {
    return this.__local__.MessageClass
  }
  
  getOnMessageClass()
  {
    return this.__local__.OnMessageClass
  }
  
  getListViewClass()
  {
    return this.__local__.ListViewClass
  }
  
  ; alias
  setting()
  {
    return this.getSettingClass()
  }
  
  M(dic)
  {
    return this.getMessageClass().message(dic)
  }
}