/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
Main()
return
/*
継承されたものであるかの調査
*/
Main(){
  class1 := new SuperClass()
  class2 := new SubClass()
  class3 := new SubSubClass()
  class4 := new OtherClass()

  MsgBox % IsExtends(class1, class1)
  MsgBox % IsExtends(class2, class1)
  MsgBox % IsExtends(class3, class2)
  MsgBox % IsExtends(class3, class1)
  MsgBox % IsExtends(class4, class1)
  MsgBox % IsExtends(class2, SuperClass)
  MsgBox % IsExtends(class3, SuperClass)
}

class SuperClass{
  __New(){
  }
}

class SubClass extends SuperClass{
  __New(){
  }
}

class SubSubClass extends SubClass{
  __New(){
  }
}

class OtherClass{
  __New(){
  }
}