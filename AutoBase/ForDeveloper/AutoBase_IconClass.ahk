/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
ex)
new AutoBase_IconClass({filePath: "filePath", iconNum: 0, isScale: 0})
 or
new AutoBase_IconClass("filePath", 0, 0)
*/

class AutoBase_IconClass{
  static __static__ := new AutoBase_IconClass_MemoryClass()
  __local__ := Object()
  
  __New(_params*){
    _filePath := _ret := "", _iconNum := _isScale := 0
    _num := _params.MaxIndex()
    if(_num = 1){
      if(IsObject(_params.1)){
        _filePath := _params.1.filePath
        _iconNum  := (_params.1.iconNum) ? _params.1.iconNum : 0
        _isScale  := (_params.1.isScale) ? _params.1.isScale : 0
      }else{
        _filePath := _params.1
        _iconNum  := (_params.2) ? _params.2 : 0
        _isScale  := (_params.3) ? _params.3 : 0
      }
    }else{
      return
    }
    this.setFilePath(_filePath)
    this.setIconNum(_iconNum)
    this.setIsScale(_isScale)
    _ret := this.getMemoryClass().searchMemory(this)
    this.setIcon(_ret)
  }
  
  __Delete(){
    this.getMemoryClass().__Delete.()
  }
  
  getIcon(){
    return this.__local__.icon
  }
  setIcon(_icon){
    return this.__local__.icon := _icon
  }
  getFilePath(){
    return this.__local__.filePath
  }
  setFilePath(_string){
    IfExist, %_string%
    {
      return this.__local__.filePath := _string
    }
    Throw, % _string " is not exist."
  }
  getIconNum(){
    return this.__local__.iconNum
  }
  setIconNum(_uint){
    if(IsUInt(_uint)){
      return this.__local__.iconNum := _uint
    }
    Throw, % _uint " is not UInteger."
  }
  getIsScale(){
    return this.__local__.isScale
  }
  setIsScale(_boolean){
    if(IsBoolean(_boolean)){
      return this.__local__.isScale := _boolean
    }
    Throw, % _boolean " is not boolean."
  }
  getMemoryClass(){
    return this.__static__
  }
  
}

; Developer は気にしなくて良いクラス
class AutoBase_IconClass_MemoryClass{
  __local__ := Object()
  
  __New(){
    this.setMemory(Object())
    _imageList := DllCall("ImageList_Create", Int,18, Int,18, UInt,0x21, Int,30, Int,30, UInt) ; アイコンを入れておくためのハンドル
    this.setImageList(_imageList)
  }
  
  __Delete(){
    IL_Destroy(this.getImageList())
  }
  
  getMemory(){
    return this.__local__.memory
  }
  
  setMemory(_obj){
    if(IsObject(_obj)){
      return this.__local__.memory := _obj
    }
    Throw, _obj is not Object
  }
  
  /*
  @return ""   failure
  @return uint success
  */
  searchMemory(_IconClass){
    _filePath := _IconClass.getFilePath()
    _iconNum  := _IconClass.getIconNum()
    _isScale  := _IconClass.getIsScale()
    
    if(this.getMemory()[_filePath][_iconNum][_isScale]){
      ; すでに登録済み
      return this.getMemory()[_filePath][_iconNum][_isScale]
    }else{
      _ret := this.addImageList(_IconClass)
      if(!_ret){
        this.addMemory(_ret, _IconClass)
        return _ret
      }
      ; failure
      return
    }
  }
  
  addMemory(_icon, _IconClass){
    _memory   := this.getMemory()
    _filePath := _IconClass.getFilePath()
    _iconNum  := _IconClass.getIconNum()
    _isScale  := _IconClass.getIsScale()
    if(!IsObject(_memory[_filePath])){
      _memory[_filePath] := Object()
    }
    if(!IsObject(_memory[_filePath][_iconNum])){
      _memory[_filePath][_iconNum] := Object()
    }
    _memory[_filePath][_iconNum][_isScale] := _icon
  }
  
  getImageList(){
    return this.__local__.imageList
  }
  
  setImageList(_imageList){
    return this.__local__.imageList := _imageList
  }
  
  addImageList(_IconClass){
    _imageList := this.getImageList()
    _filePath  := _IconClass.getFilePath()
    _iconNum   := _IconClass.getIconNum()
    _isScale   := _IconClass.getIsScale()
    
    _ret := IL_Add(_imageList, _filePath, _iconNum, _isScale)
    if(_ret = 0){
      ; failure
      return
    }else{
      ; success
      return _ret
    }
  }
}

class IconClass extends AutoBase_IconClass{ ; wrpper
}