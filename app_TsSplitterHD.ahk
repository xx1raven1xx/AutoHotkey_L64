/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/

Params := Object()

Loop, %0%
{
    Params.Insert(%A_Index%)
}

Main(Params)
return

#include %A_ScriptDir%
#include ./Lib/IniClass.ahk
#include ./Lib/FileClass.ahk

Main(Params){
    _iniFile  := new FileClass(A_ScriptName)
    _iniPath  := _iniFile.getDir() "\" _iniFile.getFileNameNoExt() ".ini"
    _iniFile  := new FileClass(_iniPath)
    if(!_iniFile.isExist())
        Throw, % _iniFile.getFullPath() " is not exist."
    _iniClass := new IniClass(_iniFile.getFullPath())

    _tsSplitterPath  := _iniClass.getValue("TsSplitter", "path")
    _tsSplitterParam := _iniClass.getValue("TsSplitter", "param")
    _tsAppClass      := new AppClass(_tsSplitterPath, _tsSplitterParam)
    _DGIndexPath  := _iniClass.getValue("DGIndex", "path")
    _DGIndexParam := _iniClass.getValue("DGIndex", "param")
    _DGIAppClass  := new AppClass(_DGIndexPath, _DGIndexParam)
    _sinkuSuperLitePath  := _iniClass.getValue("SinkuSuperLite", "path")
    _sinkuSuperLiteParam := _iniClass.getValue("SinkuSuperLite", "param")
    _SSLAppClass         := new AppClass(_sinkuSuperLitePath, _sinkuSuperLiteParam)

    Loop, % Params.MaxIndex()
    {
        _argFile   := Params[A_Index]
        _fileClass := new FileClass(_argFile)
        _filePath  := _fileClass.getFullPath()
        IfNotExist, %_argFile%
            Continue
        ;RunWait, %_tsSplitterPath% %_tsSplitterParam% "%_filePath%",,, _pid
        _tsAppClass.runWait("", _filePath)
        ;MsgBox, %_tsSplitterPath% %_tsSplitterParam% "%_filePath%"
        _hdPath := _fileClass.getDirPath() "\" _fileClass.getFileNameNoExt() "_HD.ts"
        ;MsgBox, HDpath = %_hdPath%
        _tsPath := ""
        IfNotExist, %_hdPath%
            _tsPath := _filePath
        else
            _tsPath := _hdPath

        _tsFileClass := new FileClass(_tsPath)

        _SSLAppClass.runWait(_tsFileClass.getFullPath())
        _PIDobj := GetPID()
        _audioPID := _PIDobj.audioPID
        _videoPID := _PIDobj.videoPID
        ;MsgBox, % "video = " _PIDobj.videoPID "`naudioPID = " _PIDobj.audioPID

        _DGIndexOut  := _tsFileClass.getDir() "\" _tsFileClass.getFileNameNoExt()
        _DGIndexIO = -i "%_tsPath%" -o "%_DGIndexOut%" -ap %_audioPID% -vp %_videoPID%
        ;RunWait, %_DGIndexPath% %_DGIndexIO% %_DGIndexParam%,,, _pid
        _DGIAppClass.runWait(_DGIndexIO)
        ;MsgBox,  %_DGIndexPath% %_DGIndexIO% %_DGIndexParam%
    }
    MsgBox, 処理すべて終了
}

class AppClass{
    __local__ := Object()

    __New(_path, _param){
        this.setPath(_path)
        this.setParam(_param)
    }

    runWait(_beforeParam="", _afterParam=""){
        _path  := this.getPath()
        _param := this.getParam()
        RunWait, %_path% %_beforeParam% %_param% "%_afterParam%",,, _pid
    }

    ;*** getter setter ***;
    getPath(){
        return this.__local__.path
    }
    setPath(_string){
        IfNotExist, %_string%
            Throw, % _string " is not exist."
        return this.__local__.path := _string
    }
    getParam(){
        return this.__local__.param
    }
    setParam(_string){
        return this.__local__.param := _string
    }
}

GetPID(){
    _str := Clipboard
    _videoPID := ""
    _audioPID := ""

    Loop, Parse, _str, `n
    {
        ;MsgBox, %A_LoopField%
        if(A_Index = 2)
        {
            _$1 =
            RegExMatch(A_LoopField, "^([0-9a-f]+)\s", _$)
            _videoPID := _$1
            Continue
        }
        _$1 = 
        RegExMatch(A_LoopField, "^([0-9a-f]+)\s*AAC", _$)
        if(_$1 != "")
        {
            _audioPID := _$1
            Break
        }
    }
    
    ;MsgBox % "Video PID = " _videoPID "`nAudio PID = " _audioPID
    return {"videoPID": _videoPID, "audioPID": _audioPID}
}
