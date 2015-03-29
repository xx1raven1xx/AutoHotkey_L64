/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

/*
現状はただのIniReadを関数化しただけだが、
後々はここに環境変数展開などを組み込む
*/
IniRead(_fineName, _section, _key, _default=""){
  IniRead, _out, %_fileName%, %_section%, %_key%, %_default%
  return _out
}