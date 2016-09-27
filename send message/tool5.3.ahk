#Persistent
#SingleInstance force

;创建托盘菜单。
Menu , tray , NoStandard
Menu, tray, add, 更新日志, Menuhelp
Menu, tray, add, 重启, MenuReload
Menu, tray, add, 退出, MenuExit

;托盘鼠标悬停提示
Menu, Tray, Tip, 说明：`nF8: 开始  F9: 暂停  F10: 退出

;主界面
Gui, font, s8, Verdana
Gui, Add, Text, x15 y10 w60 h20 Right, 平台：
Gui, Add, DropDownList, x80 y8 w70 h20 R3 Choose1 AltSubmit vPlatform, 豆芽|微信|QQ

Gui, Add, Text, x15 y40 w60 h20 Right, 消息数目：
Gui, Add, Edit, x80 y38 w70 h20 Limit4 Number vUserInput1 CEnter, 3

Gui, Add, Text, x15 y70 w60 h20 Right, 消息间隔：
Gui, Add, Edit, x80 y68 w70 h20 Limit4 Number vTime1 CEnter, 10
Gui, Add, Text, x152 y72 w40 h20 Left, ms

Gui, Add, Text, x15 y100 w60 h20 Right, 消息内容：
Gui, Add, Radio, x80 y98 w60 h20 checked1 vitem11 gOnRadioChange, 默认
Gui, Add, Radio, x80 y118 w60 h20 vitem12 gOnRadioChange, 自定义
Gui, Add, Edit, x80 y138 w130 h20 Disabled Limit10 vtxt1,

Gui, Add, Checkbox, x15 y180 w90 h20 vExitornot , 完成后退出
Gui, Add, Button, x110 y170 w110 h35 Default, 准备

Gui, Show, AutoSize, 消息工具

;判断选中自定义时输入框可用，否则置灰
OnRadioChange:
	GuiControlGet, item3,, item12
	GuiControl, Enable%item3%, txt1
	itemcheck = %item3%
return

;托盘菜单2
MenuReload:
	Reload
return

;托盘菜单3
MenuExit:
	ExitApp
return

;托盘菜单1
Menuhelp:
	MsgBox ,,更新日志,
	(
Version: 0.9 实现飞信发送消息的基本功能

Version: 1.0 发送消息功能适配豆芽
Author: Sword
Date: 2013/4/3

Version: 2.0 变更消息生成的实现方式

Version: 3.0 发送消息间隔可自定义，增加了发送完成自动退出

Version: 4.0 发送消息内容可自定义
Author: Sword
Date: 2015/11/25

Version: 4.2 优化界面显示，增加重启功能
Author: Sword
Date: 2015/11/30

Version: 5.0 优化界面显示，增加对微信、QQ的支持
Author: Sword
Date: 2015/11/30

	)
return


GuiClose:
GuiEscape:
	;Button关闭:
	{
		ExitApp
		return
	}

Button准备:
	Gui, Submit

	;判断消息数目，消息间隔和消息内容的合法性
	if UserInput1 = 0
	{
		MsgBox ,16,警告,消息数目不能为0！
		Reload
	}

	else if UserInput1 =
	{
		MsgBox ,16,警告,消息数目不能为空！
		Reload
	}

	else if Time1 = 0
	{
		MsgBox ,16,警告,消息间隔不能为0！
		Reload
	}

	else if Time1 =
	{
		MsgBox ,16,警告,消息间隔不能为空！
		Reload
	}

	else if itemcheck = 1
	{
		if txt1 =
		{
			MsgBox ,16,警告,消息内容不能为空！
			Reload
		}
	}

	var = %txt1%
	if var contains 宝,剑,保,健,13050202,辛
	{
		MsgBox ,16,警告,No zuo no die！
		Reload
	}

	MesDef = Mes_
	Pause

	;F10 关闭工具
F10:: ExitApp

	;暂停
F9:: Pause

F8::
	if Platform = 1  ;判断平台
	{
#IfWinActive, ahk_class Qt5QWindowIcon   ;豆芽

		Loop
		{
			;检查窗口是否为激活状态
			IfWinNotActive, ahk_class Qt5QWindowIcon
				break

			A+=1
			if item11=1
			{
				clipboard = %MesDef%%A%
				Send ^v
			}

			else if item12=1
			{
				clipboard = %txt1%
				Send ^v
			}

			Sleep, 	%Time1%
			{
				if var contains @
					Send,	{Enter}{Enter}
				else
					Send,	{Enter}
			}
		;是否勾选完成退出
			if a_index >= %UserInput1%
			{
				if %Exitornot%=0
					break
				else
					ExitApp
			}
	}

	}

else if Platform = 2
{

	;检查文字输入窗口是否激活
#IfWinActive, ahk_class WeChatMainWndForPC   ;微信

	Loop
	{
		;检查窗口是否为激活状态
		IfWinNotActive, ahk_class WeChatMainWndForPC
			break

		A+=1
		if item11=1
		{
			clipboard = %MesDef%%A%
			Send ^v
		}

		else if item12=1
		{
			clipboard = %txt1%
			Send ^v
		}

		Sleep, 	%Time1%
		{
			if var contains @
				Send,	{Enter}{Enter}
			else
				Send,	{Enter}
		}

	;是否勾选完成退出
		if a_index >= %UserInput1%
		{
			if %Exitornot%=0
				break
			else
				ExitApp
		}
}

}

else if Platform = 3
{

	;检查文字输入窗口是否激活
#IfWinActive, ahk_class TXGuiFoundation   ;QQ

	Loop
	{
		;检查窗口是否为激活状态
		IfWinNotActive, ahk_class TXGuiFoundation
			break

		A+=1
		if item11=1
		{
			clipboard = %MesDef%%A%
			Send ^v
		}

		else if item12=1
		{
			clipboard = %txt1%
			Send ^v
		}

		Sleep, 	%Time1%
		{
			if var contains @
				Send,	{Enter}{Enter}
			else
				Send,	{Enter}
		}

	;是否勾选完成退出
		if a_index >= %UserInput1%
		{
			if %Exitornot%=0
				break
			else
				ExitApp
		}
}

}