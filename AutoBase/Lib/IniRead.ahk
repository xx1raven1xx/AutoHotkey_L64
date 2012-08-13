/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
現状はただのIniReadを関数化しただけだが、
後々はここに環境変数展開などを組み込む
変数展開もする
*/
IniRead(_fineName, _section, _key, _default=""){
  if(_default != "ERROR"){
    _error := "ERROR"
  }else{
    ; ERROR
    _error := "IniRead ERROR"
  }
  IniRead, _out, %_fileName%, %_section%, %_key%, %_error%
  if(_out = _error){
    _out := _default
  }
  Transform, _out, Deref, %_out%
  return _out
}