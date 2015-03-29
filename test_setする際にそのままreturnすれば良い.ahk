/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
setする際にそのままreturnすれば良い
*/
Main(){
  point1 := new Point(1, 2)
  point2 := new Point3D(3, 4, 5)
  MsgBox % point2.__Class ", " point2.base.base.__Class
}

class Point{
  __local__ := Object()
  
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
    MsgBox % "z = " this.setZ(_z)
  }
  
  say(){ ; override
    MsgBox % "x = " this.getX() ", y = " this.getY() ", z = " this.z
  }
  
  getZ(){
    return this.z
  }
  setZ(_num){
    if(IsUInt(_num)){
      return this.__local__.z := _num
    }
    Throw, _num "is not number"
  }
}