; Version: 0.9 实现飞信发送消息的基本功能

; Version: 1.0 发送消息功能适配豆芽
; Author: Sword
; Date: 2013/4/3

; Version: 2.0 变更消息生成的实现方式

; Version: 3.0 发送消息间隔可自定义，增加了发送完成自动退出

; Version: 4.0 发送消息内容可自定义
; Author: Sword
; Date: 2015/11/25


;任务栏工作列鼠标悬停提示
Menu, Tray, Tip, 说明`nF8: 开始  F9: 暂停  F10: 退出

;创建程序主界面
Gui, font, S8, Verdana

Gui, Add, Text, x10 y10 w100 h20 Right, 消息类型：
Gui, Add, Text, x10 y+5 w100 h20 Right, 消息数目：
Gui, Add, Text, x10 y+5 w100 h20 Right, 间隔时间：
Gui, Add, Text, x10 y+5 w100 h20 Right, 自定义文字：
Gui, Add, Text, x180 y62 w20 h20 Right, ms


;Gui, Add, DropDownList, x120 w60 h20 r2 AltSubmit vitem1 ym, 默认||自定义
Gui, Add, Radio, x120 y10 checked1 vitem1, 默认
Gui, Add, Radio, x170 y10 , 自定义
Gui, Add, Edit, x120 y+8 w60 h20 Limit4 Number vUserInput Center, 50
Gui, Add, Edit, x120 y+7 w60 h20 Limit4 Number vTime Center, 10
Gui, Add, Edit, x120 y+6 w130 h20 Limit10 vtxt1, 请输入文字
Gui, Add, Checkbox, x140 y+20 vExitornot , 完成后退出

Gui, Add, Button, x20 y115 w100 h30 Default , 准备
;Gui, Add, Button, x180 y135 w60 h30 , 关闭

Gui, Show, AutoSize, 工具
return

;关闭
GuiClose:
;Button关闭:
	{
		ExitApp
		return
	}
GuiSize:
	{
		if (A_EventInfo==1)          ;这里只是针对窗口最小化事件处理，就是将程序托盘并关联变量
			Gui, Submit
		return
	}

;开始按钮
Button准备:
	Gui, Submit ; 保存用户输入后每个控件的数据

;	MsgBox, %item1%

	;工具处于暂停状态
	Pause

	;F10 关闭工具
F10:: ExitApp

	;检查文字输入窗口是否激活
#IfWinActive, ahk_class Qt5QWindowIcon

	;暂停
F9:: Pause

	;開始
F8::

	;发送循环
	Loop
	{
		;检查窗口是否为激活状态
		IfWinNotActive, ahk_class Qt5QWindowIcon
			break

		A+=1
		if item1=1
			{
				Send, 	Mes_%A%
			}
		else{
				Send,	%txt1%
			}
		Send,	{Enter}{Enter}
		Sleep, 	%Time%

		;是否勾选完成退出
		if a_index >= %UserInput%
		{
			if %Exitornot%=0
				break
			else
				ExitApp
		}
	}

