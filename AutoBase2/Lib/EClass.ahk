/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2014/01/06 new
*/

/*
クラス作成を手助けするクラス
便利関数等を実装
*/

#include <IsDuck>

class EClass
{
  __local__  := Object()
  
  __New()
  {
  }
  
  ; 存在しない関数呼び出しを防ぐ処理
  __Call(aName)
  {
    if(aName != "_NewEnum"){ ; これでよいのか
      if(!ObjHasKey(this.base, aName))
      {
        ;MsgBox, % this.__Class
        Throw, this.__Class . " has not " . aName . " function."
      }
    }
  }
  
  __Get(aName)
  {
    ; 予約済みオブジェクトを連ねる(増える度に増やす必要あり)
    if(  aName != "__local__"
      && aName != "base"
      && aName != "__Call"
      && aName != "__Get"
      && aName != "__Set"
      && aName != "__Delete"
      && aName != "__Init")
    {
      if(ObjHasKey(this.__local__, aName)){
        ;MsgBox, % this.__Class . "  = " . aName . "[" . this.__local__[aName] . "]"
        return this.__local__[aName]
      }
      Throw, this.__Class . " don't have " . aName . " key."
    }
  }
  
  ; 先に__local__で定義した変数にのみSetできるようにする
  __Set(aName, aValue)
  {
    if(aName != "__local__"){
      if(ObjHasKey(this.__local__, aName)){
        if(IsObject(aValue)){
          ; object
           ;MsgBox, % "aaa - " . this.__local__[aName].__Class
          if(IsDuck(this.__local__[aName].__Class, aValue)){
            return this.__local__[aName] := aValue
          }
          Throw, "not match object"
        }else{
          ; not object
          return this.__local__[aName] := aValue
        }
      }else{
        Throw, this.__Class . " don't have " . aName . " key."
      }
    }
  }
}