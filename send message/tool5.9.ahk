#Persistent
#SingleInstance force

;~ 发消息调用的参数
MesDef = Mes_
Picornot = %A_MM%%A_DD%%A_Hour%


;创建托盘菜单。
Menu, tray , NoStandard
Menu, tray, add, 更新日志, Menuchangelog
Menu, tray, add, 重启, MenuReload
Menu, tray, add, 退出, MenuExit

;托盘鼠标悬停提示
Menu, Tray, Tip, 说明：`nF8: 开始  F9: 暂停  F10: 退出

;主界面
Gui, font, s8, Verdana

Gui, Add, Text, x15 y10 w60 h20 Right, 平台：
Gui, Add, DropDownList, x80 y8 w70 h20 R3 Choose1 AltSubmit vPlatform gMychoose, 豆芽|微信|QQ

Gui, Add, Text, x15 y40 w60 h20 Right, 消息数目：
Gui, Add, Edit, x80 y38 w70 h20 Limit4 Number vMesnum CEnter, 100

Gui, Add, Text, x15 y70 w60 h20 Right, 消息间隔：
Gui, Add, Edit, x80 y68 w70 h20 Limit4 Number vMestime CEnter, 100
Gui, Add, Text, x152 y72 w40 h20 Left, ms

Gui, Add, Text, x15 y100 w60 h20 Right, 消息内容：
Gui, Add, Radio, x80 y98 w60 h20 checked1 vitem11 gOnRadioChange, 默认
Gui, Add, Radio, x80 y118 w60 h20 vitem12 gOnRadioChange, 自定义
Gui, Add, Edit, x80 y138 w130 h20 Disabled Limit10 vMestext

Gui, Add, Text, x15 y165 w60 h20 Right, 选项：
Gui, Add, Checkbox, x80 y163 w90 h20 vExitornot, 完成后退出
Gui, Add, Checkbox, x80 y183 w90 h20 vbackground1, 后台发送

Gui, Add, Button, x15 y210 w200 h35 Default, 准备

Gui, Show, AutoSize, 消息工具

;判断选中自定义时输入框可用，否则置灰
OnRadioChange:
	GuiControlGet, item3,, item12
	GuiControl, Enable%item3%, Mestext
	itemcheck = %item3%
return

;判断选中豆芽是后台发送可选，否则置灰
Mychoose:
	if platform != 1
		GuiControl, Disable, background1
	if platform = 1
		GuiControl, Enable, background1
return

;托盘菜单1
MenuReload:
MyGuiButton重置:
	Reload
return

;托盘菜单2
GuiClose:
GuiEscape:
MyGuiGuiClose:
MyGuiGuiEscape:
MyGuiButton退出:
MenuExit:
F10::
	ExitApp
return

;托盘菜单3
Menuchangelog:
	MsgBox ,,更新日志,
	(LTrim
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

		Version: 5.5 增加发送剪贴板的功能
		Author: Sword
		Date: 2015/12/12

		Version: 5.7 增加后台发送的功能
		Author: Sword
		2015/12/22

		Version: 5.8 增加后台发送的进度显示窗口
		Author: Sword
		2015/12/24

		Version: 5.9 增加后台发送时的发送速度调节，发送时的Tooltip提示
		Author: Sword
		2015/12/24
	)
return

Button准备:
	Gui, Submit

	;判断消息数目，消息间隔和消息内容的合法性
	if (Mesnum=0 or Mestime<10)
	{
		MsgBox ,16,警告,非法输入！
		Reload
	}

	else if Mesnum =
	{
		MsgBox ,16,警告,非法输入！
		Reload
	}

	else if Mestime =
	{
		MsgBox ,16,警告,非法输入！
		Reload
	}

	else if itemcheck = 1
	{
		if Mestext =
		{
			MsgBox ,16,警告,非法输入！
			Reload
		}
	}

	var = %Mestext%
	if var contains 宝,剑,保,健,13050202,辛
	{
		MsgBox ,16,警告,No zuo no die！
		Reload
	}

	;~ 判断选择豆芽和勾选后台发送时弹出发送框
	if (Platform = 1 and  background1 = 1)
	{
		ToolTip,
		(LTrim
			╔══════════════════重要提示════════════════╗
			请使用豆芽默认大小合并窗口
			发送期间不要切换豆芽当前窗口
			F8: 开始，F9: 暂停，F10: 退出
			发送期间拖拽滑块变更发送速度
			╚══════════════════重要提示════════════════╝
		)
		Gui, MyGui:font, s8, Verdana
		Gui, MyGui:  +AlwaysOnTop
		Gui, MyGui: Add, Button, x15 y10 w120 h40 , 发送
		;Gui, MyGui: Add, Button, x75 y10 w60 h40 , 暂停
		Gui, MyGui: Add, Button, x135 y10 w60 h40 , 重置
		Gui, MyGui: Add, Button, x195 y10 w60 h40 , 退出

		Gui, MyGui: Add, Text, x15 y60 w25 h20, Speed:
		Gui, MyGui: Add, Slider, x100 y60 w150 h20 NoTicks ToolTip gMySlider Line10 page100 vMestime Range10-9999, %Mestime%
		Gui, MyGui: Add, Edit, x45 y58 w50 h20 Limit4 Number CEnter gTimechange vTime2, %Mestime%
		Gui, MyGui: Add, Text, x15 y83 w70 h20 Left vPercent, 0/0
		Gui, MyGui: Add, Progress, x85 y82 w170 h17 -Smooth vMyProgress

		Gui, MyGui: Show, AutoSize, 消息工具

	}

	;~ 前台发送tooltip提示
	else
	{
		ToolTip,
		(LTrim
			╔══════════════════重要提示════════════════╗
			消息发送期间，不要操作键盘和鼠标，以免发生错误！
			激活输入框，F8: 开始，F9: 暂停，F10: 退出
			╚══════════════════重要提示════════════════╝
		)
	}

	;~ 后台发送界面滑块
MySlider:
	GuiControl,, Time2, %Mestime%
return

;~ 后台发送发送间隔输入框
Timechange:
	GuiControlGet, Timech,, Time2
	GuiControl,, Mestime, %Timech%
	GuiControl,, Time2, %Timech%
return


Pause

;暂停

MyGuiButton暂停:
F9::
	Pause

MyGuiButton发送:
F8::
	if (Platform = 1 and background1 = 0) ;判断平台
	{
		B+=1
#IfWinActive, ahk_class Qt5QWindowIcon   ;豆芽

		Loop
		{
			;检查窗口是否为激活状态
			IfWinNotActive, ahk_class Qt5QWindowIcon
			{
				ToolTip
				MsgBox ,262160,警告,============================`n丢失焦点，发送已暂停！`n激活窗口按F8继续`n============================
				break
			}
			A+=1
			C := Mesnum*B
			CoordMode, ToolTip, client
			ToolTip,
			(LTrim
				╔══════════════════重要提示════════════════╗
				消息发送期间，不要操作键盘和鼠标，以免发生错误！
				当前第%A%条/共%C%条
				╚══════════════════重要提示════════════════╝
			), 300,390
			;~ 勾选默认消息类型
			if item11=1
			{
				clipboard = %MesDef%%A%
				Send ^v
			}
			;~ 勾选自定义消息类型
			else if item12=1
			{
				;~ 自定义是输入月日小时，发送剪贴板功能
				if Mestext = %Picornot%
					Send ^v
				else
				{
					clipboard = %Mestext%
					Send ^v
				}
			}

			Sleep, 	%Mestime%

			;~ 判断自定义内容包含@发送两个enter
			if var contains @
				Send,	{Enter}{Enter}
			else
				Send,	{Enter}
			;是否勾选完成退出
			if a_index >= %Mesnum%
			{
				;~ 关闭tooltip
				ToolTip
				if Exitornot=0
					break
				else
					ExitApp
			}
		}

	}

	if (Platform = 1 and  background1 = 1)  ;后台发送
	{
		ToolTip
		ControlGet, hwnd1, Hwnd,, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon
		Loop
		{
			ControlGet, hwnd2, Hwnd,, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon
			if (hwnd1 != hwnd2)
			{
				MsgBox ,262160,警告,发送窗口变更，已暂停！`n点击发送或按F8继续
				break
			}
			if item11=1
			{
				A+=1
				SetControlDelay -1

				ControlClick, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon,,,, NA x50 y420
				ControlSend, Qt5QWindowIcon10, 	message%A%, ahk_class Qt5QWindowIcon
				ControlSend, Qt5QWindowIcon10, {Enter} , ahk_class Qt5QWindowIcon
				c := a_index/Mesnum*100
				GuiControl,, MyProgress, %c%
				GuiControl,, Percent, %a_index%/%Mesnum%

			}

			else if item12=1
			{
				SetControlDelay -1
				ControlClick, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon,,,, NA x50 y420
				ControlSend, Qt5QWindowIcon10, %Mestext%, ahk_class Qt5QWindowIcon, titleWidge
				ControlSend, Qt5QWindowIcon10, {Enter} , ahk_class Qt5QWindowIcon
				c := a_index/Mesnum*100
				GuiControl,, MyProgress, %c%
				GuiControl,, Percent, %a_index%/%Mesnum%
			}
			Sleep, 	%Mestime%
			;是否勾选完成退出
			if a_index >= %Mesnum%
			{
				if Exitornot=0
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
				if Mestext = %Picornot%
					Send ^v
				else
				{
					clipboard = %Mestext%
					Send ^v
				}
			}

			Sleep, 	%Mestime%
			{
				if var contains @
					Send,	{Enter}{Enter}
				else
					Send,	{Enter}
			}

		;是否勾选完成退出
			if a_index >= %Mesnum%
			{
				if Exitornot=0
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
			if Mestext = %Picornot%
				Send ^v
			else
			{
				clipboard = %Mestext%
				Send ^v
			}
		}

		Sleep, 	%Mestime%
		{
			if var contains @
				Send,	{Enter}{Enter}
			else
				Send,	{Enter}
		}

	;是否勾选完成退出
		if a_index >= %Mesnum%
		{
			if Exitornot=0
				break
			else
				ExitApp
		}
}

}