/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2014/01/05 new
*/

/*
クラス作成を手助けするクラス
便利関数等を実装
*/
class EClass
{
  __local__  := Object()
  
  __New()
  {
  }
  
  ; 存在しない関数呼び出しを防ぐ処理
  ; 使い方）
  ; EClass.__Call(this, aName)
  __Call(parent, aName)
  {
/*
; 昔のもの
    if(!ObjHasKey(this.base, aName))
    {
      MsgBox, % this.__Class
      Throw, this.__Class . " has not " . aName . " function."
    }
*/
    if(!ObjHasKey(parent.base, aName))
    {
      Throw, parent.__Class . " has not " . aName . " function."
    }
  }
}