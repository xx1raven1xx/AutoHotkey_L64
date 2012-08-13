/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
#SingleInstance Off
#Persistent

OutputDebug, % "app_MoveFiles.ahk run"

; TODO exe "path" "path" [ /m /c /h /o /i /s "-" ]

sourceDirPath = %1%
destDirPath  = %2%
mode = %3%
isOW = %4% 
; 0 = すでにそのファイル名が存在していた場合、ハッシュチェックで同一ファイルかどうかチェックし、違うファイルならば別名で保存する(default)
; 1 = すでにそのファイル名が存在していた場合、同一ファイルかチェックを行わずに上書きする
; 2 = すでにそのファイル名が存在していた場合、同一ファイルかチェックを行わずにCopy（or Move）を中止する
sameFileNameChar = %5%
; isOWが0のときでファイル名を変更する際のファイル名に付ける装飾名(うまく説明できない)
; ex) 「-」ならば、ファイル名-1.exe といった感じに「-」+数字が新しいファイル名となる。（default 「-」）
; ただし、ファイル名に使えない文字列は使ってはいけない

isOW := (isOW) ? isOW : 0
sameFileNameChar := (sameFileNameChar) ? sameFileNameChar : "-"
sendString := sourceDirPath destDirPath mode isOW sameFileNameChar
if(IsInString(sendString, "|")){
  ; もし「|」がどれかに含まれていた場合は綺麗に分割できないため失敗
  Throw, % "パラメータに「|」が含まれている"
}
sendString := sourceDirPath "|" destDirPath "|" mode "|" isOW "|" sameFileNameChar
checkAndSendMsgExistThisScriptInProcess(sendString)
; もし、すでにこのスクリプトが動いていたらここでExitApp

Global_StringArray := Array() ; FIFO
GC := new GlobalClass()
MF := new MoveFilesClass(GC, sourceDirPath, destDirPath, mode, isOW, sameFileNameChar)
return

#include .\Lib\FileClass.ahk
#include <HashFile>
#include <IsInString>
#include <IsExtends>

/*
TODO

BatchArrayをグローバルに
*/

class MoveFilesClass{
  __local__ := Object()
  
  __New(_GC, _sourceDirPath, _destDirPath, _mode, _isOW, _sameFileNameChar){
    this.setGlobalClass(_GC)
    this.getGlobalClass().queueBatch(queueBatch(_sourceDirPath, _destDirPath, _mode, _isOW, _sameFileNameChar))
    ;this.queueBatch(_sourceDirPath, _destDirPath, _mode, _isOW, _sameFileNameChar)
    this.startBatch()
  }
  
  startBatch(){
    _BatchArray := this.getGlobalClass().getBatchArray()
    Loop
    {
      OutputDebug, % "batch = " _BatchArray.MaxIndex() " count,  " this.getGlobalClass().getBatchArray().MaxIndex()
      if(_BatchArray.MaxIndex() = ""){
        Break
      }
      _BatchClass := _BatchArray[1]
      _BatchClass.exec()
      this.dequeueBatch()
      ;MsgBox, % "batch = " this.getBatchArray().MaxIndex() " count"
      OutputDebug, % "startBatch loop"
    }
    OutputDebug, % "end"
    ExitApp
  }
  
  dequeueBatch(){
    _BatchClass := this.getGlobalClass().dequeueBatch()
    return _BatchClass
  }
  
  ;*** getter setter ***;
  getGlobalClass(){
    return this.__local__.GlobalClass
  }
  setGlobalClass(_Class){
    if(IsExtends(_Class, GlobalClass)){
      return this.__local__.GlobalClass := _Class
    }
    Throw, % "_Class doesn't extends GlobalClass"
  }
}

class MF_Batch{
  __local__ := Object()
  static MODE_COPY := 0
  static MODE_MOVE := 1
  static ISOW_MD5       := 0
  static ISOW_OVERWRITE := 1
  static ISOW_IGNORE    := 2
  
  __New(_sourcePattern, _destDirPath, _mode, _isOW, _sameFileNameChar){
    OutputDebug, % "MF_Batch new"
    this.setSourcePattern(_sourcePattern)
    this.setDestDir(_destDirPath "\")
    this.setMode(_mode)
    this.setIsOW(_isOW)
    this.setSameFileNameChar(_sameFileNameChar)
    this.makeTargetFiles()
  }
  
  makeTargetFiles(){
    Global GC
    this.setTargetFiles(Array())
    Loop, % this.getSourcePattern(), 0
    {
      OutputDebug, % "makeFile [" A_LoopFileFullPath "]"
      _TargetFilesArray := GC.getTargetFilesArray()
      Loop, % _TargetFilesArray.MaxIndex()
      {
        ; TargetFileを全部調べる
        _filePath := _TargetFilesArray[A_Index]
        OutputDebug, % "check file [" _filePath "]"
        if(_filePath = A_LoopFileFullPath){
          OutputDebug, % "same file[" _filePath "]"
          Continue, 2
        }
      }
      OutputDebug, % "make insert[" A_LoopFileFullPath "]"
      this.getTargetFiles().Insert(A_LoopFileFullPath)
    }
  }
  
  ; @return 0 no same file
  ; @return 1 same file exists
  isSameFile(_filePath){
    Loop, % this.getTargetFiles().MaxIndex()
    {
      if(this.getTargetFiles()[A_Index] = _filePath){
        return 1
      }
    }
    return 0
  }
  
  exec(){
    OutputDebug, % "exec and ["  this.getTargetFiles().MaxIndex() "] loop"
    Loop, % this.getTargetFiles().MaxIndex()
    {
      _source := this.getTargetFiles()[A_Index]
      _file := new FileClass(_source)
      _dest   := this.getDestDir() "\" _file.getFileName()
      
      if(this.getIsOW() = this.ISOW_MD5){
        _dest := this.checkAndChangeDest(_source, _dest)
        if(_dest = ""){
          ; same file exists
          if(this.getMode() = this.MODE_MOVE){
            FileDelete, %_source%
          }else{
            Continue
          }
        }
      }
      this.copyOrMove(_source, _dest)
    }
  }
  
  ; @return "" same file
  checkAndChangeDest(_source, _dest){
    IfExist, %_dest%
    {
      _hash1 := HashFile(_source)
      _hash2 := HashFile(_dest)
      if(_hash1 = _hash2){
        ; same file
        return ""
      }else{
        SplitPath, _dest, _outFileName, _outDir, _outExt, _outNameNoExt
        _char := this.getSameFileNameChar()
        _pattern = %_char%(\d+)$
        _ret := RegExMatch(_outNameNoExt, _pattern, _$)
        if(_$1 = ""){
          ; まだ数字がない
          _name := this.addStringFileName(_outFileName, _char "1")
        }else{
          _num := _$1 + 1
          _ret := RegExReplace(_outNameNoExt, _pattern, _char _num)
          _name := (IsInString(_outFileName, ".")) ? _ret "." _outExt : _ret
        }
        return this.checkAndChangeDest(_source, _outDir "\" _name)
      }
    }else{
      ; dest is not exist
      return _dest
    }
  }
  
  copyOrMove(_source, _dest){
    OutputDebug, % "s = " _source ", `nd = " _dest 
    Sleep, 20000
    ;MsgBox, % "s = " _source ", `nd = " _dest 
    _flg := (this.getIsOW() = this.ISOW_OVERWRITE) ? 1 : 0
    if(this.getMode() = this.MODE_COPY){
      FileCopy, %_source%, %_dest%, %_flg%
    }else if(this.getMode() = this.MODE_MOVE){
      FileMove, %_source%, %_dest%, %_flg%
    }else{
      Throw, % "mode = " this.getMode()
    }
    
    if(ErrorLevel != 0){
      ; failed
      ; TODO
    }
    OutputDebug, % "copy or move complete!"
  }
  
  ; ファイル名に文字列を追加する際に、「.」の扱いに対してセーフティ
  addStringFileName(_fileName, _string){
    if(IsInString(_fileName, ".")){
      SplitPath, _fileName, _outFileName,, _outExt, _outNameNoExt
      _fileName := _outNameNoExt _string "." _outExt
    }else{
      _fileName := _fileName _string
    }
    return _fileName
  }
  
  ;*** getter setter ***;
  getSourcePattern(){
    return this.__local__.sourcePattern.getFullPath()
  }
  setSourcePattern(_sourcePattern){
    return this.__local__.sourcePattern := new FileClass(_sourcePattern)
  }
  getDestDir(){
    return this.__local__.destDir.getDirPath()
  }
  setDestDir(_destDirPath){
    return this.__local__.destDir := new FileClass(_destDirPath)
  }
  getTargetFiles(){
    return this.__local__.targetFiles
  }
  setTargetFiles(_Array){
    if(IsObject(_Array)){
      return this.__local__.targetFiles := _Array
    }
    Throw, % "_Array is not Array"
  }
  getMode(){
    return this.__local__.mode
  }
  setMode(_mode){
    if(_mode = "copy"){
      _mode := this.MODE_COPY
    }else if(_mode = "move"){
      _mode := this.MODE_MOVE
    }
    
    if(_mode != this.MODE_COPY && _mode != this.MODE_MOVE){
      Throw, % _mode " is undefined mode"
    }
    return this.__local__.mode := _mode
  }
  getIsOW(){
    return this.__local__.isOW
  }
  setIsOW(_uint){
    if(_uint = "md5" || _uint = "hash"){
      _uint := this.ISOW_MD5
    }else if(_uint = "ow" || _uint = "overwrite"){
      _uint := this.ISOW_OVERWRITE
    }else if(_uint = "ignore"){
      _uint := this.ISOW_IGNORE
    }
    if(_uint = this.ISOW_MD5 || _uint = this.ISOW_OVERWRITE || _uint = this.ISOW_IGNORE){
      return this.__local__.isOW := _uint
    }
    Throw, % _uint " is undefined"
  }
  getSameFileNameChar(){
    return this.__local__.sameFileNameChar
  }
  setSameFileNameChar(_string){
    if(IsFileNameUsingString(_string)){
      return this.__local__.sameFileNameChar := _string
    }
    Throw, % _string " don't use filename"
  }
}

class GlobalClass{
  __local__ := Object()
  
  __New(){
    this.setBatchArray(Array())
  }
  
  queueBatch(_MF_Batch){
    if(IsExtends(_MF_Batch, MF_Batch)){
      return this.getBatchArray().Insert(_MF_Batch)
    }
    Throw, % "_MF_Batch doesn't extend MF_Batch"
  }
  
  dequeueBatch(){
    _MF_Batch := this.getBatchArray()[1]
    this.getBatchArray().Remove(1)
    return _MF_Batch
  }
  
  getTargetFilesArray(){
    OutputDebug, % "getTargetFilesArray"
    _Array := Array()
    _num := this.getBatchArray().MaxIndex()
    Loop, % _num
    {
      _BatchClass := this.getBatchArray()[A_Index]
      if(_BatchClass.getMode() = _BatchClass.MODE_COPY){
        Continue
      }
      _TargetFilesArray := _BatchClass.getTargetFiles()
      Loop, % _TargetFilesArray.MaxIndex()
      {
        _Array.Insert(_TargetFilesArray[A_Index])
      }
    }
    return _Array
  }
  
  ;*** getter setter ***;
  getBatchArray(){
    return this.__local__.batchArray
  }
  setBatchArray(_Array){
    if(IsObject(_Array)){
      return this.__local__.batchArray := _Array
    }
    Throw, % "_Array is not Object"
  }
}

checkAndSendMsgExistThisScriptInProcess(_string){
  _winCount := 0
  _sendWin  := _winList := ""
  _return   := 0
  _prevDetectHiddenWindows := A_DetectHiddenWindows
  _prevTitleMatchMode      := A_TitleMatchMode
  
  SetTitleMatchMode 2
  DetectHiddenWindows On
  
  WinGet, _winCount, Count, %A_ScriptName% ahk_class AutoHotkey
  if (_winCount > 1){
    WinGet, _winList, List, %A_ScriptName% ahk_class AutoHotkey
    _sendWin := "ahk_id " _winList%_winCount%
    Send_WM_COPYDATA(_string, _sendWin)
    DetectHiddenWindows %_prevDetectHiddenWindows% ; Restore original setting for the caller.
    SetTitleMatchMode %_prevTitleMatchMode%        ; Same.
    
    ExitApp
  }
  
  DetectHiddenWindows %_prevDetectHiddenWindows% ; Restore original setting for the caller.
  SetTitleMatchMode %_prevTitleMatchMode%        ; Same.
  OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA
}

; copy from http://www.autohotkey.com/community/viewtopic.php?t=76704 and edit
Receive_WM_COPYDATA(wParam, lParam)
{
  Global Global_StringArray
   PtrSize:=A_PtrSize ? A_PtrSize : 4
   StringAddress := NumGet(lParam + 2*PtrSize)  ; lParam+8 is the address of CopyDataStruct's lpData member.
   CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
   ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
   ;ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
   Global_StringArray.Insert(CopyOfData)
   SetTimer, Label_Timer_MF_Receive, 0
   return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}

; copy from http://www.autohotkey.com/community/viewtopic.php?t=76704
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)
{
   PtrSize:=A_PtrSize ? A_PtrSize : 4
   VarSetCapacity(CopyDataStruct, 3*PtrSize, 0)  ; Set up the structure's memory area.
   ; First set the structure's cbData member to the size of the string, including its zero terminator:
   SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
   NumPut(SizeInBytes, CopyDataStruct, PtrSize)  ; OS requires that this be done.
   NumPut(&StringToSend, CopyDataStruct, 2*PtrSize)  ; Set lpData to point to the string itself.
   Prev_DetectHiddenWindows := A_DetectHiddenWindows
   Prev_TitleMatchMode := A_TitleMatchMode
   DetectHiddenWindows On
   SetTitleMatchMode 2
   SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%  ; 0x4a is WM_COPYDATA. Must use Send not Post.
   DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
   SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
   return ErrorLevel  ; Return SendMessage's reply back to our caller.
}

Label_Timer_MF_Receive:
  OutputDebug, % "SendMessage"
  SetTimer, Label_Timer_MF_Receive, Off
  ;MF.queueBatch(Global_StringArray[1])
  GC.queueBatch(queueBatch(Global_StringArray[1]))
  Global_StringArray.Remove(1)
return

queueBatch(_Params*){
  if(_Params.MaxIndex() = 5){
    _sourceDirPath    := _Params[1]
    _destDirPath      := _Params[2]
    _mode             := _Params[3]
    _isOW             := _Params[4]
    _sameFileNameChar := _Params[5]
  }else if(_Params.MaxIndex() = 1){
    _string := _Params[1]
    StringSplit, _$, _string, |
    _sourceDirPath    := _$1
    _destDirPath      := _$2
    _mode             := _$3
    _isOW             := _$4
    _sameFileNameChar := _$5
  }else{
    Throw, % _Params.MaxIndex()
  }
  return new MF_Batch(_sourceDirPath, _destDirPath, _mode, _isOW, _sameFileNameChar)
}