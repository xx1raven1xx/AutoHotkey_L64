/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
１つのIniファイルを完全に取り込み、
必要な値を取り出すことが出来るクラス
*/

class IniClass{
    __local__ := Object()

    __New(_filePath){
        this.setIniFilePath(_filePath)
        this.read()
    }

    read(){
        _iniObject := Object()
        _section := ""

        Loop, Read, % this.getIniFilePath()
        {
            _line := Trim(A_LoopReadLine)
            if(_line = "")
                Continue
            StringLeft, _char, _line, 1
            if(_char = "#")
                Continue ; comment
            _$1 := ""
            _ret := RegExMatch(_line, "^\[(.*)\]", _$)
            if(_$1 != "")
            {
                _section := _$1
                _iniObject[_section] := Object()
                _iniObject[_section]["nonHash"] := Object()
                _iniObject[_section]["hash"]    := Object()
                _iniObject[_section]["raw"]     := Object()
                Continue
            }
            _iniObject[_section]["raw"].Insert(_line)
            _$1 := _$2 := ""
            _ret := RegExMatch(_line, "^([^\=]*)\=(.*)", _$)
            if(_$1 != "")
            {
                _key := Trim(_$1)
                _value := Trim(_$2)
                _iniObject[_section]["hash"][_key] := _value
                Continue
            }
            ; ここまでくるとKey=Valueではなくなる
            _iniObject[_section]["nonHash"].Insert(_line)
        }
        this.setIniObject(_iniObject)
    }
    
    debug(){
        _s := ""
        _obj := this.getIniObject()
        for _key, _value in _obj
        {
            _s .= "[" _key "]`n"
            for _key2, _value2 in _obj[_key]["hash"]
            {
                _s .= _key2 " = " _value2 "`n"
            }
            Loop, % _obj[_key]["nonHash"].MaxIndex()
            {
                _s .= _obj[_key]["nonHash"][A_Index] "`n"
            }
        }
        MsgBox % _s
    }

    debug2(){
        _s := ""
        _sections := this.getSections()
        Loop, % _sections.MaxIndex()
        {
            _s .= "[" _sections[A_Index] "]`n"
            _sectionName := _sections[A_Index]
            _raws := this.getRawKeys(_sectionName)
            Loop, % _raws.MaxIndex()
            {
                _s .= _raws[A_Index] "`n"
            }
            _s .= "`n"
            _keys := this.getKeys(_sectionName)
            Loop, % _keys.MaxIndex()
            {
                _key := _keys[A_Index]
                _s .= "`tKEY = " _key "`n"
                _value := this.getValue(_sectionName, _key)
                _s .= "`tVALUE = " _value "`n"
            }
            _nonKeyValues := this.getNonKeyValues(_sectionName)
            Loop, % _nonKeyValues.MaxIndex()
            {
                _s .= "`t" _nonKeyValues[A_Index] "`n"
            }
        }
        MsgBox % _s
    }

    ;*** getter setter ***;
    getIniFilePath(){
        return this.__local__.iniFilePath
    }
    setIniFilePath(_string){
        IfExist, %_string%
        {
            return this.__local__.iniFilePath := _string
        }
        Throw, % _string " is not exist."
    }
    getIniObject(){
        return this.__local__.iniObject
    }
    setIniObject(_Object){
        if(IsObject(_Object))
            return this.__local__.iniObject := _Object
        Throw, % "_Object is not Object."
    }
    getSections(){
        _obj := this.getIniObject()
        _Array := Object()
        for _key in _obj
        {
            _Array.Insert(_key)
        }
        return _Array
    }
    getKeys(_sectionName){
        _obj := this.getIniObject()[_sectionName]["hash"]
        _Array := Object()
        for _key, _value in _obj
        {
            _Array.Insert(_key)
        }
        return _Array
    }
    getRawKeys(_sectionName){
        return this.getIniObject()[_sectionName]["raw"]
    }
    getValue(_sectionName, _keyName){
        return this.getIniObject()[_sectionName]["hash"][_keyName]
    }
    getNonKeyValues(_sectionName){
        return this.getIniObject()[_sectionName]["nonHash"]
    }
}

