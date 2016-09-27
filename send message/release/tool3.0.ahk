; Version: 3.0
; Author: Sword
; Date: 2013/7/2

;任务栏工作列鼠标悬停提示
Menu, Tray, Tip, 说明`nF8: 开始  F9: 暂停  F10: 退出

;创建程序主界面
Gui, font, S8, Verdana
Gui, Add, Text, x10 y10 w100 h20 Right, 发送消息数目：
Gui, Add, Edit, x120 y10 w40 h20 Limit4 Number vUserInput, 100

Gui, Add, Text, x10 y40 w100 h20 Right, 间隔时间(ms)：
Gui, Add, Edit, x120 y40 w40 h20 Limit4 Number vTime, 1

Gui, Add, Checkbox, x60 y65 AltSubmit vExitornot, 发送完成后退出

Gui, Add, Button, x10 y90 w80 h30 Default, 开始
Gui, Add, Button, x110 y90 w80 h30, 关闭

Gui, Show, AutoSize, 工具
return

;关闭
GuiClose:
Button关闭:
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
Button开始:
	Gui, Submit ; 保存用户输入后每个控件的数据


	;工具处于暂停状态
	Pause

	;F10 关闭工具
F10:: ExitApp

	;检查文字输入窗口是否激活
#IfWinActive, ahk_class QWidget

	;暂停
F9:: Pause

	;開始
F8::

	;发送循环
	Loop
	{
		;检查窗口是否为激活状态
		IfWinNotActive, ahk_class QWidget
			break

		A+=1
		Send, 	Mes_%A%
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

