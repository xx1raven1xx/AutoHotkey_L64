/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/

/*
this.baseの中身の調査
*/

obj := Object()

for _index, _param in obj.base
{
  MsgBox, key = %_index% val = %_param%
}

return