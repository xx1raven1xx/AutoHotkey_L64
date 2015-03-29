return
/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2013/05/18 new
*/

class InterprocessClass
{
  __local__  := Object()
  
  __New()
  {
  }
  
  __Call(aName)
  {
/*
    if(aName = "")
    {
      return this.get()
    }
*/
    if(!ObjHasKey(this.base, aName))
    {
      Throw, this.__Class . " has not " . aName . " function."
    }
  }
}