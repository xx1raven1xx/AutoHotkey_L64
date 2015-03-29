/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
classのテスト
オーバーロードはできない
オーバーライドはできる
*/
Main(){
  point1 := new Point(1, 2)
  point1.say()
  point1.setY(6)
  point1.say()
  
  point2 := new Point3D(3, 4, 5)
  point2.say()
  point2.setY(7)
  point2.say()
  point2.setZ("aa")
  point2["say"]() ; これも使える
  MsgBox % point2.x ; これも使える。が、private的に考えると使うべきではない。
}

class Point{
  __New(_x, _y){ ; constructor
    this.x := _x
    this.y := _y
  }
  
  say(){
    MsgBox % "_x = " this.x ", y  = " this.y
  }
  
  getX(){
    return this.x
  }
  setX(_num){
    if _num is number
      this.x := _num
    else
      MsgBox % _num " is not number."
  }
  getY(){
    return this.y
  }
  setY(_num){
    if _num is number
      this.y := _num
    else
      MsgBox % _num " is not number."
  }
  
  ; error overload
  ;say(_int){
    ;MsgBox % x, y
  ;}
}

class Point3D extends Point{
  __New(_x, _y, _z){
    Point.__New(_x, _y) ; super constructor
    this.z := _z
  }
  
  say(){ ; override
    MsgBox % "x = " this.x ", y = " this.y ", z = " this.z
  }
  
  getZ(){
    return this.y
  }
  setZ(_num){
    if _num is number
      this.z := _num
    else
      MsgBox % _num " is not number."
  }
}