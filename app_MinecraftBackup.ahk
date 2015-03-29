/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/

#Persistent
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
  global GLOBAL_OBJ
  
  GLOBAL_OBJ := Object()
  GLOBAL_OBJ.intervalMinute := 10 ; 10分間隔で実行
  GLOBAL_OBJ.lastDir        := "D:\test\MinecraftBackup_new"
  GLOBAL_OBJ.oldDir         := "D:\test\MinecraftBackup_old"
  GLOBAL_OBJ.srcDir         := "D:\test\Minecraft\cliant_1.4.7\.minecraft"
  
  Loop, % Params.MaxIndex()
  {
    _param := Params[A_Index]
    if(_param = "/src"){
      GLOBAL_OBJ.srcDir := Params[A_Index + 1]
      continue
    }
    if(_param = "/new"){
      GLOBAL_OBJ.lastDir := Params[A_Index + 1]
      continue
    }
    if(_param = "/old"){
      GLOBAL_OBJ.oldDir := Params[A_Index + 1]
      continue
    }
    if(_param = "/interval"){
      GLOBAL_OBJ.intervalMinute := Params[A_Index + 1]
      continue
    }
  }
  
  _time := GLOBAL_OBJ.intervalMinute * 60000
  SetTimer, Label_Timer, %_time%
  return
}


timer(GLOBAL_OBJ){
  changeOldDir(GLOBAL_OBJ.lastDir, GLOBAL_OBJ.oldDir)
  FileCopyDir, % GLOBAL_OBJ.srcDir, % GLOBAL_OBJ.lastDir, 1
}

/*
今までnewだったフォルダをoldにする
*/
changeOldDir(_lastDir, _oldDir){
  IfExist, %_oldDir%
  {
    FileRemoveDir, %_oldDir%, 1
  }
  FileMoveDir, %_lastDir%, %_oldDir%, 2
}

Label_Timer:
  timer(GLOBAL_OBJ)
  return