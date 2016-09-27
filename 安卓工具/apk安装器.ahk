#Persistent
#SingleInstance force

Run, %comspec% /c adb devices, ,Hide,EXEPID

Gui, Add, Button, w240 h30 gtest vtest, 检查设备连接...
;~ Gui, Add, Text,, 安装文件路径：
Gui, Add, Edit, r3 w200 vlujin Disabled, 请选择apk文件路径...
Gui, Add, Button, x+1 h50 gxuanz vxuanz Disabled, 浏览
Gui, Add, Edit, x10 r13 w240 vlianjie
Gui, Add, Button, w240 h40 ginstall vinstall Disabled, 安装
Gui, Show, AutoSize, apk安装器1.0
return

GuiClose:
GuiEscape:
	RunWait, %comspec% /c adb kill-server, ,Hide,EXEPID
	ExitApp

test:
	GuiControl, ,lianjie, 正在检测...
	check_adb := cmd("adb devices")
	IfInString, check_adb, 不是内部或外部命令
	{
		GuiControl, ,lianjie, adb支持文件不存在，请安装adb驱动相关文件！
	}
	check_adb2 := StrSplit(check_adb,"`n","`r")
	if (!check_adb2[2])
		GuiControl, ,lianjie, 正在检测...`n`nADB未检测到设备连接，请检查！
	else
	{
		aaa :=check_adb2[2]
		GuiControl, ,lianjie, 正在检测...`n`n%aaa%`n`n设备连接成功...
		GuiControl, Enable, lujin
		GuiControl, Enable, xuanz
	}
return

GuiDropFiles:
	if %A_GuiEvent% contains .apk
	{
		GuiControl, Disable, xuanz
		GuiControl, ,lianjie, 正在安装...
		bbb = adb install %A_GuiEvent%
		check_adb3 := cmd(bbb)
		check_adb4 := StrSplit(check_adb3,"`n","`r")
		check_adb5 := check_adb4[2]
		;~ MsgBox, % check_adb5
		IfInString, check_adb5, Success
		{
			GuiControl, ,lianjie, 正在安装...`n`n%check_adb3%`n`n安装成功...
			Gui, Flash
		}
		else
		{
			GuiControl, ,lianjie, 正在安装...`n`n%check_adb3%`n`n安装失败...
		}
		
		Run, %comspec% /c adb install %A_GuiEvent% >cmd.temp, ,Hide,EXEPID
		result =
		FileRead, result, cmd.temp
		FileDelete, cmd.temp
		GuiControl, ,lianjie, %result%
	}
	else
		GuiControl, ,lianjie, 非apk文件...
return

install:
	if (!lujin1)
		GuiControl, ,lianjie, apk文件未选择...
	else
	{
		;~ GuiControl, Disable, test
		GuiControl, Disable, xuanz
		GuiControl, ,lianjie, 正在安装...
		;~ bbb = adb install %lujin1%
		check_adb3 := cmd("adb install " lujin)
		check_adb4 := StrSplit(check_adb3,"`n","`r")
		check_adb5 := check_adb4[2]
		;~ MsgBox, % check_adb5
		IfInString, check_adb5, Success
		{
			GuiControl, ,lianjie, 正在安装...`n`n%check_adb3%`n`n安装成功...
			Gui, Flash
		}
		else
		{
			GuiControl, ,lianjie, 正在安装...`n`n%check_adb3%`n`n安装失败...
		}
	}
return

xuanz:
	FileSelectFile, lujin1, 3, , , apk (*.apk)
	if lujin1
	{
		GuiControl, , lujin, % lujin1
		GuiControl, ,lianjie, 准备安装...
		GuiControl, Enable, install
	}
	else
		GuiControl, ,lianjie, apk文件未选择...
return

cmd(command){
	static i
	i++
	RunWait, %ComSpec% /c %command% >%A_Temp%\%i%.tmp, , Hide
	FileRead, content, %A_Temp%\%i%.tmp
	StringReplace, content, content, `r, , All
	return content
}