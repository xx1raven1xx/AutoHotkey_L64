return
/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2013/05/09 add __Call
2013/05/05 new
*/

class ArrayClass
{
  __local__             := Object()
  __local__.array       := Array()
  __local__.typeClass   := "" ; 型指定用
  
  __New(typeClass="", params*)
  {
    if(typeClass != ""){
      this.setTypeClass(typeClass)
    }
  }
  
  __Call(aName)
  {
    if(aName = "")
    {
      return this.get()
    }
    if(!ObjHasKey(this.base, aName))
    {
      Throw, this.__Class . " has not " . aName . " function."
    }
  }
  
  get()
  {
    return this.__local__.array
  }
  getArray()
  {
    return this.get()
  }
  
  set(array)
  {
    if(IsObject(array)){
      return this.__local__.array := array
    }
  }
  setArray(array)
  {
    return this.set(array)
  }
  
  add(elem)
  {
    if(this.getTypeClass() != ""){
      if(IsDuck(this.getTypeClass(), elem)){
        return this.get().Insert(elem)
      }else{
        Throw, "Error: class type error."
      }
    }else{
      return this.get().Insert(elem)
    }
  }
  
  remove(index)
  {
    return this.get().Remove(index)
  }
  
  ; getter setter
  getTypeClass()
  {
    return this.__local__.typeClass
  }
  setTypeClass(typeClass)
  {
    if(IsObject(typeClass)){
      return this.__local__.typeClass := typeClass
    }else{
      Throw, "not Object."
    }
  }
}