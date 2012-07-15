/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

class FileClass{
  __local__ := object()
  
  __New(_params*){
    if(_params.1){
      this.setFilePath(_params.1)
    }
  }
  
  makePath(){
    ; TODO 絶対パス
    _filePath := _absolutePath := _outFileName := _outDir := _outExt := _outNameNoExt := _outDrive := ""
    _filePath := this.getFilePath()
    SplitPath, _filePath, _outFileName, _outDir, _outExt, _outNameNoExt, _outDrive
    if(_outDrive = ""){
      ; _filePath is relative
    }
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
}