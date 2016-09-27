#Persistent
#SingleInstance force

Run, %comspec% /c adb devices, ,Hide,EXEPID

Gui, Add, Button, w240 h30 gconnect vconnect, 无线连接...
Gui, Add, Button, w240 h30 gtest vtest, 检查设备连接...
Gui, Add, Edit, r3 w200 vlujin Disabled, 请选择apk文件路径...
Gui, Add, Button, x+1 h50 gxuanz vxuanz Disabled, 浏览
Gui, Add, Edit, x10 h200 w240 vlianjie ReadOnly,
Gui, Add, Button, w240 h40 ginstall vinstall Disabled, 安装
Gui, Show, AutoSize, apk安装器2.0
return

GuiClose:
GuiEscape:
	RunWait, %comspec% /c adb kill-server, ,Hide,EXEPID
	ExitApp

connect:
	addmsg("正在连接...")
	check_adb := cmd("adb shell")
	addmsg(check_adb)
	IfInString, check_adb, connected
	{
		addmsg("无线连接成功...")
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
		addmsg("ADB未检测到设备连接，请检查！")
	else
	{
		aaa :=check_adb2[2]
		addmsg(aaa)
		addmsg("设备连接成功...")
		GuiControl, Enable, lujin
		GuiControl, Enable, xuanz
	}
return

GuiDropFiles:
	;~ MsgBox, %A_GuiEvent%
	if A_GuiEvent contains .apk
	{
		;~ GuiControl, Disable, xuanz
		GuiControl, , lujin, % A_GuiEvent
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

xuanz:
	FileSelectFile, lujin1, 3, , ,apk (*.apk)
	if lujin1
	{
		GuiControl, ,lujin, % lujin1
		addmsg("apk文件路径:"lujin1)
		addmsg("准备安装...")
		Loop, Parse, lujin1, \
		{
			DEF = %A_LoopField%
		}
		;~ MsgBox, % DEF
		GuiControl, Enable, install
	}
	else
		addmsg("apk文件未选择...")
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