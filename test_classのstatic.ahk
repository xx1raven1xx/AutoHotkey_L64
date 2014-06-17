/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
classのstatic
*/
Main(){
  point1 := new Point(1, 2)
  MsgBox % point1.getCount()
  point2 := new Point(3, 4)
  MsgBox % point1.getCount() ", " point2.getCount() ", " Point.Count ", " Point.getCount() ; 全部使える
  MsgBox % Point3D.getCount() ", " Point3D.Count ; 継承もされる
}

class Point{
  static Count := 0
  instance := 0
  __New(_x, _y){ ; constructor
    this.x := _x
    this.y := _y
    
    Point.Count += 1 ; static
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
  getCount(){
    return Point.Count ; static
  }
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