﻿/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
SuperConstructorは.__New.(this, _x, _y)
*/
Main(){
  point1 := new Point(1, 2)
  point1.say()
  point2 := new Point3D(3, 4, 5)
  point2.say()
}

class Point{
  __local__ := Object() ; local object
  
  __New(_x, _y){ ; constructor
    this.setX(_x)
    this.setY(_y)
  }
  
  say(){
    MsgBox % "_x = " this.getX() ", y  = " this.getY()
  }
  
  getX(){
    return this.__local__.x
  }
  setX(_num){
    if _num is number
      this.__local__.x := _num
    else
      Throw, _num "is not number"
  }
  getY(){
    return this.__local__.y
  }
  setY(_num){
    if _num is number
      this.__local__.y := _num
    else
      Throw, _num "is not number"
  }
  getCount(){
    return Point.Count ; static
  }
}

class Point3D extends Point{
  __New(_x, _y, _z){
    Point.__New.(this, _x, _y) ; super constructor
    this.z := _z
  }
  
  say(){ ; override
    MsgBox % "x = " this.getX() ", y = " this.getY() ", z = " this.z
  }
  
  getZ(){
    return this.z
  }
  setZ(_num){
    if _num is number
      this.z := _num
    else
      Throw, _num "is not number"
  }
}