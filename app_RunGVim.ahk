/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/

ArgArray := Object()
Loop, %0%
{
    arg := %A_Index%
    ArgArray.Insert(arg)
}

Main(ArgArray)
return

#include %A_ScriptDir%
#include Lib/FileClass.ahk
#include Lib/IniClass.ahk

/*
gvimを起動する
*/
Main(_ArgArray){
    SetWorkingDir, %A_ScriptDir%
    _scriptFileClass := new FileClass("%A_ScriptName%")
    _iniPath := _scriptFileClass.getFileNameNoExt() ".ini"
    _iniClass := new IniClass(_iniPath)

    _PATHS := _iniClass.getNonKeyValues("PATH")
    _path := ""
    Loop, % _PATHS.MaxIndex()
    {
        _fileClass := new FileClass(_PATHS[A_Index])
        if(_fileClass.isExist()){
            _path .= _fileClass.getFullPath() "`;"
        }
    }

    _gvimPath        := "gvim.exe"
    _gitFileClass    := new FileClass("..\..\Git\PortableGit\bin")
    _gitPath         := _gitFileClass.getFullPath()
    _ctagsFileClass  := new FileClass("W:\Software\Program\ctags")
    _ctagsPath       := _ctagsFileClass.getFullPath()
    _runAltFileClass := new FileClass("W:\Software\AHK\RunAlt")
    _runAltPath      := _runAltFileClass.getFullPath()


    EnvSet, HOME, %A_WorkingDir%\HOME
    EnvSet, PATH, %PATH%`;%_gitPath%`;%_ctagsPath%`;%_runAltPath%

    MsgBox, % "HOME = " HOME "`nPATH = " PATH

    ; if not exist gvim size

    Loop, % _ArgArray.MaxIndex()
    {
        _argFile := _ArgArray[A_Index]
        Run, %_gvimPath% --remote-silent %_argFile%
        Sleep, 100
    }
}
