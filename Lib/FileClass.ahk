/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

#include <IsBoolean>
/*
    @1  file path
    @2  AnyDrive機能を使うかどうか(0:使わない, !0:使う)
*/
class FileClass{
  __local__ := object()
  
  __New(_Params*){
    this.setIsAnyDrive(_Params.2)
    if(_Params.1){
      this.constructor(_Params.1)
    }
  }

  constructor(_filePath){
      this.setParam(_filePath)
      this.setIsNetworkDrive(0)
      this.setIsDir(0)
      this.setIsDrive(0)
      
      this.makePath(_filePath)
  }
  
  makePath(_filePath){
    _trimLeft := _trimRight := _dot := _len := _tempPath := ""
    _split := _tempSplit := ""
    _outFileName := _outDir := _outExt := _outNameNoExt := _outDrive := ""
    _loop := 0
    
    StringLeft, _trimLeft, _filePath, 2
    if(_trimLeft = "\\" || _trimLeft = "//"){
      ; ネットワークドライブのときはベースをネットワークドライブ名にする
      StringTrimLeft, _filePath, _filePath, 2 ; ネットワークドライブであることを示す最初の\\を取り除く
      this.setIsNetworkDrive(1)
    }
    
    StringRight, _trimRight, _filePath, 1
    if (_trimRight = "\" || _trimRight = "/"){
      ; 最後がセパレートだった(フォルダ記述)
      StringTrimRight, _filePath, _filePath, 1
      this.setIsDir(1)
    }
    
    _filePath := RegExReplace(_filePath, "\/", "\") ; すべてのセパレートを\に統一
    StringSplit, _split, _filePath, `\
    
    ; 分岐の作成（もう少し簡単になる）
    if (this.getIsNetworkDrive() = 1){
      ; network drive
      _tempPath := _split1 . "\"
    }else{
      IfInString, _split1, :
      {
        ; 先頭がドライブ文字である
        this.setIsDrive(1)
        _tempPath := _split1 . "\"
      }else{
        ; 相対パスで記述されていた
        _tempPath := A_WorkingDir . "\"
      }
    }
    
    ; FullPathの作成
    Loop, %_split0%
    {
      if (A_Index = 1){
        if (this.getIsDrive() = 1 || this.getIsNetworkDrive() = 1){
          ; 最初を無視
          Continue
        }
      }
      
      _dot := RegExReplace(_split%A_Index%, "\.+", ".") ; .を１つにまとめる（比較用）
      if(_dot = "."){
        ; _dotが.だけならば、_split%A_Index%は.+であったはずである。つまりは相対記述。
        _len := StrLen(_split%A_Index%)
        Loop, % (_len-1)
        {
          StringSplit, _tempSplit, _tempPath, `\
          _tempPath := ""
          _loop := ((_tempSplit0 - 2) <= 0) ? 1 : _tempSplit0 - 2
          Loop, % _loop
          {
            _tempPath .= _tempSplit%A_Index% . "\"
          }
        }
      }else{
        ; 相対記述じゃなかった 
        _tempPath .= _split%A_Index% . "\"
      }
    }
    
    ; 間違って\\と、\を連ねて記述したとこがあればこちらで修正(おせっかい)
    _tempPath := RegExReplace(_tempPath, "\+", "\", "", -1)
    
    if (this.getIsNetworkDrive() = 1){
      _tempPath := "\\" . _tempPath
    }
    if(this.getIsDir() != 1){
      StringTrimRight, _tempPath, _tempPath, 1
    }

    ; _tempPath でファイルパスが完成
    ; AnyDrive
    if(this.getIsAnyDrive()){
        
    }


    SplitPath, _tempPath, _outFileName, _outDir, _outExt, _outNameNoExt, _outDrive
    this.setFullPath(_tempPath)
    this.setDirPath(_outDir)
    this.setFileName(_outFileName)
    this.setExt(_outExt)
    this.setFileNameNoExt(_outNameNoExt)
    this.setDrivePath(_outDrive)
    IfInString, _outFileName, `.
    {
      this.setDot(".")
    }
  }
  
  isExist(){
    IfExist, % this.getFullPath()
    {
      return 1
    }else{
      return 0
    }
  }
  
  debug(_easy=0){
    _d := "param [" this.getParam() "]`n"
    _d .= "FullPath [" this.getFullPath() "]`n"
    _d .= "FileName [" this.getFileName() "]`n"
    _d .= "Ext [" this.getExt() "]`n"
    _d .= "FileNameNoExt [" this.getFileNameNoExt() "]`n"
    _d .= "DirPath [" this.getDirPath() "]`n"
    _d .= "DrivePath [" this.getDrivePath() "]`n"
    _d .= "Dot [" this.getDot() "]`n"
    _d .= "isNetworkDrive = " this.getIsNetworkDrive() "`n"
    if(_easy){
      _d .= "isExist = " this.isExist() "`n"
    }
    
    MsgBox, % "Debug `n" _d
  }
  
  ;*** getter setter ***;
  getIsAnyDrive(){
    return this.__local__.isAnyDrive
  }
  setIsAnyDrive(_bool=0){
    if(_bool = 0)
        return this.__local__.isAnyDrive := _bool
    else
        return this.__local__.isAnyDrive := 1
  }
  getFullPath(){
    return this.__local__.fullPath
  }
  setFullPath(_string){
    return this.__local__.fullPath := _string
  }
  getFilePath(){
    return this.getFullPath()
  }
  setFilePath(_string){
    return this.setFullPath(_string)
  }
  getPath(){
    return this.getFullPath()
  }
  setPath(_string){
    return this.setFullPath(_string)
  }
  getFileName(){
    return this.__local__.fileName
  }
  setFileName(_string){
    return this.__local__.fileName := _string
  }
  getExt(_includeDot=0){
    if(_includeDot){
      _string := this.getDot() . this.__local__.ext
      return _string
    }else{
      return this.__local__.ext
    }
  }
  setExt(_string){
    return this.__local__.ext := _string
  }
  getFileNameNoExt(){
    return this.__local__.fileNameNoExt
  }
  setFileNameNoExt(_string){
    return this.__local__.fileNameNoExt := _string
  }
  getDirPath(_includeSep=0){
    _string := this.__local__.dirPath
    if(_includeSep){
      _string .= "\"
    }
    return _string
  }
  setDirPath(_string){
    return this.__local__.dirPath := _string
  }
  getDir(_includeSep=0){
    return this.getDirPath(_includeSep)
  }
  setDir(_string){
    return this.setDirPath(_string)
  }
  getDrivePath(_includeSep=0){
    _string := this.__local__.drivePath
    if(_includeSep){
      _string .= "\"
    }
    return _string
  }
  setDrivePath(_string){
    return this.__local__.drivePath := _string
  }
  getDrive(_includeSep=0){
    return this.getDrivePath(_includeSep)
  }
  setDrive(_string){
    return this.setDrivePath(_string)
  }
  getDot(){
    return this.__local__.dot
  }
  setDot(_char){
    return this.__local__.dot := _char
  }
  getIsNetworkDrive(){
    return this.__local__.isNetworkDrive
  }
  setIsNetworkDrive(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isNetworkDrive := _bool
    }
    Throw, % _bool " is not Boolean"
  }
  getIsDir(){
    return this.__local__.isDir
  }
  setIsDir(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isDir := _bool
    }
    Throw, % _bool " is not Boolean"
  }
  getIsDrive(){
    return this.__local__.isDrive
  }
  setIsDrive(_bool){
    if(IsBoolean(_bool)){
      return this.__local__.isDrive := _bool
    }
    Throw, % _bool " is not Boolean"
  }
  getParam(){
    return this.__local__.param
  }
  setParam(_string){
    return this.__local__.param := _string
  }
}
