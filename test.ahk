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
  
  point2 := new Point3D(3, 4, 5)
  point2.say()
}

class Point{
  __New(_x, _y){
    this.x := _x
    this.y := _y
  }
  
  say(){
    MsgBox % "_x = " this.x ", y  = " this.y
  }
  
  ; error
  ;say(_int){
    ;MsgBox % x, y
  ;}
}

class Point3D extends Point{
  __New(_x, _y, _z){
    Point.__New(_x, _y) ; super constructor
    this.z := _z
  }
  
  say(){
    MsgBox % "x = " this.x ", y = " this.y ", z = " this.z
  }
}