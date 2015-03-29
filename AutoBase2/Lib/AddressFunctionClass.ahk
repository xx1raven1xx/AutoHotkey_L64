return
/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2013/06/11 add call
2013/06/06 new
*/

#include <IsUInt>

/*
関数等の1つの引数でクラスメソッドを実行するためのクラス
引数を渡す際に注意が必要
例）3942835094.member.func(param)
*/
;TODO 引数のObjectに追加、変更する関数が必要？
;TODO 要実験
class AddressFunctionClass
{
  ; 文字列から解析し、callに渡すFunction
  toCall(str_)
  {
    RegExMatch(str_, "\(([0-9]+)\)$", $)
    if($1 = ""){
      param := "null"
    }else{
      param := this.toObj($1)
    }
    rep_ := RegExReplace(str_, "\([0-9]+\)$", "")
    RegExMatch(rep_, "^([0-9]+)", $)
    obj := this.toObj($1)
    str_member := RegExReplace(rep_, "^([0-9]+)", "")
    return this.call(obj, str_member, param)
  }
  
  ; 実行させたいFunctionを渡すための文字列に変換するFunction
  toString(class_, str_member, param="null")
  {
    str := this.toAddr(class_) "." str_member
    if(param = "null"){
      str .= "()"
    }else{
      str .= "(" this.toAddr(param) ")"
    }
    return str
  }
  
  ; 実行のためだけのFunction
  call(class_, str_member, param="null")
  {
    obj := class_
    StringSplit, split, str_member, .
    Loop, % split0
    {
      if(A_Index = split0 && IsFunc(obj[split%A_Index%])){
        ; 最後のobj
        if(param = "null"){
          obj := obj[split%A_Index%]()
        }else{
          obj := obj[split%A_Index%](param)
        }
      }
      obj := obj[split%A_Index%]
    }
    return obj
  }
  
  ; 以前の
  callOld(str)
  {
    StringSplit, split, str, .
    obj := this.toObject(split1)
    if(1 < split0){
      Loop, % split0
      {
        if(A_Index = 1) 
          continue
          ; TODO ifFUnction
        if(split0 = A_Index){
          obj := obj[split%A_Index%]()
        }else{
          obj := obj[split%A_Index%]
        }        
      }
      return obj
    }else{
      ; objのみ渡された
      return obj
    }
  }
  
  toAddress(class_)
  {
    if(IsObject(class_)){
      return Object(class_)
    }else{
      Throw, "class_ is not class or object." 
    }
  }
  toAddr(class_)
  {
    return this.toAddress(class_)
  }
  
  toObject(uint_address)
  {
    if(isUInt(uint_address)){
      obj := Object(uint_address)
      if(IsObject(obj)){
        return obj
      }else{
        Throw, "not object."
      }
    }else{
      Throw, "not address."
    }
  }
  toObj(uint_address)
  {
    return this.toObject(uint_address)
  }
  
}