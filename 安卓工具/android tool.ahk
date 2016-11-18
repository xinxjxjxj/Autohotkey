#Persistent
#SingleInstance force

Gui, Add, Button, w240 h30 gtest vtest, 检查设备连接...
;Gui, Add, Edit, r3 w200 vlujin Disabled, 请选择apk文件路径...
Gui, Add, Button,x10 w120 h30 gxuanz vxuanz Disabled, 选择apk文件...
gui, add, button,x+1 w120 h30 gfile vfile Disabled, 截屏保存路径...
Gui, Add, Button, x10 w120 h40 ginstall vinstall Disabled, 安装
Gui, Add, Button, w60 h40 x+1 gpush vpush Disabled, PUSH为NJCQ.apk
Gui, Add, Button, w60 h40 x+1 gpush1 vpush1 Disabled, PUSH到SD卡
Gui, Add, Button, x10 w240 h40 gshot vshot Disabled, 截屏
Gui, Add, Edit, x10 h200 w240 vlianjie ReadOnly,
Gui, Show, AutoSize, Android tools
goto, check1
return

GuiClose:
GuiEscape:
	RunWait, %comspec% /c adb kill-server, ,Hide,EXEPID
	ExitApp

check1:
	addmsg("正在检测...")
	check_adb := cmd("adb devices")
	;MsgBox, % check_adb
	IfInString, check_adb, 不是内部或外部命令
	{
		addmsg("adb支持文件不存在，请安装adb驱动相关文件！")
	}
	check_adb2 := StrSplit(check_adb,"`n","`r")
	;MsgBox, % check_adb2[4]
	if (!check_adb2[4])
		addmsg("ADB未检测到设备连接，请检查！")
	else
	{
		aaa :=check_adb2[4]
		addmsg(aaa)
		addmsg("设备连接成功...")
		GuiControl, Enable, lujin
		GuiControl, Enable, xuanz
		GuiControl, enable, shot
		GuiControl, enable, file
	}
return

test:
	addmsg("正在检测...")
	check_adb := cmd("adb devices")
	IfInString, check_adb, 不是内部或外部命令
	{
		addmsg("adb支持文件不存在，请安装adb驱动相关文件！")
	}
	check_adb2 := StrSplit(check_adb,"`n","`r")
	if (!check_adb2[2])
	{
		addmsg("ADB未检测到设备连接，请检查！")
		GuiControl, Disable, lujin
		GuiControl, Disable, xuanz
		GuiControl, Disable, shot
		GuiControl, Disable, file
	}
	else
	{
		aaa :=check_adb2[2]
		addmsg(aaa)
		addmsg("设备连接成功...")
		GuiControl, Enable, lujin
		GuiControl, Enable, xuanz
		GuiControl, enable, shot
		GuiControl, enable, file
	}
return

GuiDropFiles:
	;~ MsgBox, %A_GuiEvent%
	if A_GuiEvent contains .apk
	{
		;~ GuiControl, Disable, xuanz
		;GuiControl, , lujin, % A_GuiEvent
		addmsg("apk文件路径:"A_GuiEvent)
		addmsg("正在安装...")
		bbb = adb install %A_GuiEvent%
		check_adb3 := cmd(bbb)
		check_adb4 := StrSplit(check_adb3,"`n","`r")
		check_adb5 := check_adb4[2]
		;~ MsgBox, % check_adb5
		addmsg(check_adb3)
		IfInString, check_adb5, Success
		{
			;~ addmsg(check_adb3)
			addmsg("安装成功...")
			TrayTip,, 安装成功..., 3,1
		}
		else
		{
			;~ addmsg(check_adb3)
			addmsg("安装失败...")
			TrayTip,, 安装失败..., 3,1
		}
		Loop, 5
		{
			Gui, Flash
			sleep 500
		}

	}
	else
	{
		addmsg(A_GuiEvent)
		addmsg("非apk文件...")
	}
return

install:
	if (!lujin1)
		addmsg("apk文件未选择...")
	else
	{
		;~ GuiControl, Disable, test
		GuiControl, Disable, xuanz
		addmsg("正在安装...")
		;~ bbb = adb install %lujin1%
		check_adb3 := cmd("adb install " lujin1)
		check_adb4 := StrSplit(check_adb3,"`n","`r")
		check_adb5 := check_adb4[2]
		;~ push := cmd("adb shell ls -s /data/local/tmp/ " DEF)
		;~ addmsg(push)
		;~ MsgBox, % check_adb5
		addmsg(check_adb3)
		IfInString, check_adb5, Success
		{
			;~ addmsg(check_adb3)
			addmsg("安装成功...")
			TrayTip,, 安装成功..., 3,1
		}
		else
		{
			;~ addmsg(check_adb3)
			addmsg("安装失败...")
			TrayTip,, 安装失败..., 3,1
			}
		Loop, 5
		{
			Gui, Flash
			sleep 500
		}
	}
return

push1:
	if (!lujin1)
		addmsg("apk文件未选择...")
	else
	{
		;~ GuiControl, Disable, test
		GuiControl, Disable, xuanz
		addmsg("正在PUSH到SD卡...")
		bbb = adb push "%lujin1%" /sdcard/"%DEF%"
		cmd(bbb)
		addmsg("apk文件PUSH成功...")
	}
return

push:
	if (!lujin1)
		addmsg("apk文件未选择...")
	else
	{
		;~ GuiControl, Disable, test
		GuiControl, Disable, xuanz
		addmsg("正在PUSH到SD卡...")
		bbb = adb push "%lujin1%" /sdcard/NJCQ.apk
		cmd(bbb)
		addmsg("apk文件PUSH成功...")
	}
return

xuanz:
	FileSelectFile, lujin1, 3, , ,apk (*.apk)
	if lujin1
	{
		;GuiControl, ,lujin, % lujin1
		addmsg("apk文件已选择:"lujin1)
		Loop, Parse, lujin1, \
		{
			DEF = %A_LoopField%
		}
		;MsgBox, % DEF
		GuiControl, Enable, install
		GuiControl, Enable, push
		GuiControl, Enable, push1
	}
	else
		addmsg("apk文件未选择...")
return

shot:
	addmsg("正在截屏...")
	cmd("adb shell screencap -p /sdcard/temp.png")
	addmsg("正在保存...")
	shotpath = adb pull /sdcard/temp.png C:\Users\xinjian\Desktop\`%date:~5,2`%`%date:~8,2`%_`%time:~0,2`%`%time:~3,2`%`%time:~6,2`%.png
	shotpath1 = adb pull /sdcard/temp.png "%lujin11%"\\`%date:~5,2`%`%date:~8,2`%_`%time:~0,2`%`%time:~3,2`%`%time:~6,2`%.png
	;MsgBox, % shotpath1
	if lujin11
	{
		;MsgBox, % shotpath1
		addmsg("截屏保存路径:"lujin11)
		a := cmd(shotpath1)
	}
	else
	{
		;MsgBox, % shotpath
		addmsg("截屏保存路径:C:\Users\xinjian\Desktop\")
		a := cmd(shotpath)
	}
	;MsgBox, % a
	addmsg("截屏成功...")
	return
	
file:
	FileSelectFolder, lujin11, 3
	if lujin11
	{
		addmsg("截屏保存路径已变更...")
	}
	else
		addmsg("保存路径未选择...")
return

cmd(command){
	static i
	i++
	RunWait, %ComSpec% /c %command% >%A_Temp%\%i%.tmp, , Hide
	FileRead, content, %A_Temp%\%i%.tmp
	StringReplace, content, content, `r, , All
	return content
}


addmsg(message){
GuiControlGet, lianjie
lianjie = %lianjie%%A_Hour%:%A_Min%:%A_Sec%.%A_MSec%-> %message%`n
lianjie := RegExReplace(lianjie,".*\n(.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*)","$1")
GuiControl, , lianjie, %lianjie%
}