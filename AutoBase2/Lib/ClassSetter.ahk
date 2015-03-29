/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2014/07/06 new
*/

#include <IsDuck>

classSetter(str_className, class_)
{

  ; クラスじゃなかったら失敗
  if (IsObject(class_) != 1)
  {
    Throw
  }

  if(IsDuck(str_className, class_))
  {
      return _class
  }
  
  Throw
}