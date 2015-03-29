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
/*
RGB値かどうかの判断
*/
Main(Params){
    str := ""
    Loop, % Params.MaxIndex()
    {
        str .= Params[A_Index] . "`n"
    }
    
    MsgBox, %str%
}
