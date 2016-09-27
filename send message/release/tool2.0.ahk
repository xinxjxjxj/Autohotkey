; Version: 1.0
; Author: Sword
; Date: 2013/4/3

;任务栏工作列气泡提示
;TrayTip, 提示, 工具已启动, 6, 1
	TrayTip, 提示, F8: 开始  F9: 暂停  F10: 退出, 6, 1

;任务栏工作列鼠标悬停提示
	Menu, Tray, Tip, 说明`nF8: 开始  F9: 暂停  F10: 退出	

;输入窗口
	InputBox, UserInput, 工具, 请输入要发送的条目数： , , 220,130, , , ,1000 , 100
	If ErrorLevel
		Exitapp
	If UserInput=
		UserInput =100

;工具处于暂停状态
	Pause

;F10 关闭工具
	F10:: ExitApp

;检查文字输入窗口是否激活
	#ifwinactive, ahk_class QWidget

;暂停
	F9:: Pause

;開始
	F8::

;发送循环
	loop
	{
		If a_index > %UserInput%
        		break
		A+=1
		Send, Mes_%A%
		Sleep, 1
		Send,	{Enter}{Enter}

	;丢失窗口后暂停
		Ifwinnotactive, ahk_class QWidget
		Pause
}
