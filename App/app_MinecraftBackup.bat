@ECHO OFF

cd %~p0
start app_MinecraftBackup.exe /src "D:\test\Minecraft\cliant_1.4.7\.minecraft" /new "D:\test\MinecraftBackup_new" /old "D:\test\MinecraftBackup_old" /interval 1
pause
exit