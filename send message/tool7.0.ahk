#Persistent
#SingleInstance force
SetBatchLines -1
ListLines Off


version = _6.1
Mestime = 100
MesDef = Mes_
Picornot = %A_MM%%A_DD%%A_Hour%

;图标数据
Cross_CUR:="000002000100202002000F00100034010000160000002800000020000000400000000100010000000000800000000000000000000000020000000200000000000000FFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83FFFFFE6CFFFFFD837FFFFBEFBFFFF783DFFFF7EFDFFFEAC6AFFFEABAAFFFE0280FFFEABAAFFFEAC6AFFFF7EFDFFFF783DFFFFBEFBFFFFD837FFFFE6CFFFFFF83FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF28000000"
Full_ico:="0000010001002020100000000000E8020000160000002800000020000000400000000100040000000000000200000000000000000000100000001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFFF00FF0FF00FFFFFFFFFF000FFFFFFFFF0FF00000FF0FFFFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFF0FFFF00000FFFF0FFFFFFF000FFFFFFF0FFFFFF0FFFFFF0FFFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF000FFFFFF0000000F0F0000000FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFFF0FFFFFF0FFFFFF0FFFFFFF000FFFFFFF0FFFF00000FFFF0FFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFFFF0FF00000FF0FFFFFFFFF000FFFFFFFFFF00FF0FF00FFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000007770CCCCCCCCCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC07070007770CCCCCCCCCCCCCCCCCCCCC0777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF80000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"
Null_ico:="0000010001002020100000000000E8020000160000002800000020000000400000000100040000000000000200000000000000000000100000001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000007770CCCCCCCCCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC07070007770CCCCCCCCCCCCCCCCCCCCC0777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF80000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"


Cross_CUR_File=%A_Temp%\Cross.CUR
Full_ico_File=%A_Temp%\Full.ico
Null_ico_File=%A_Temp%\Null.ico




;创建托盘菜单。
Menu, tray , NoStandard
Menu, tray, add, 更新日志, Menuchangelog
Menu, tray, add, 重启, MenuReload
Menu, tray, add, 退出, MenuExit

;托盘鼠标悬停提示
Menu, Tray, Tip, 说明：`nF8: 开始  F9: 暂停  F10: 退出

;主界面
Gui, font, s8, Verdana
Gui, +AlwaysOnTop +HwndAHKID

Gui, Add, Text, x75 y13 w150 h20 vL1, (拖动左侧定位豆芽窗口)
Gui, Add, Picture, x35 y5 w32 h32 gSetico vPic

Gui, Add, Text, x15 y40 w60 h20 Right vProcess1, 进程名：
Gui, Add, Text, x75 y40 w130 h20 vProcessName1

Gui, font, s10 w700
Gui, Add, Text, cgreen x15 y58 w200 h20 CEnter vsuccess1
Gui, Add, Text, cred x15 y58 w200 h20 CEnter vsuccess2
Gui, font
;~ Gui, Add, Text, x15 y60 w60 h20 Right , 进程路径：
;~ Gui, Add, Text, x75 y60 w230 h20 vProcessPath1

Gui, Add, Text, x15 y80 w60 h20 Right vM1, 消息数目：
Gui, Add, Edit, x80 y78 w70 h20 Limit4 Number vMesnum CEnter Disabled, 100

Gui, Add, Text, x15 y100 w60 h20 Right vM4, 消息内容：
Gui, Add, Radio, x80 y98 w60 h20 checked1 vitem11 gOnRadioChange Disabled, 默认
Gui, Add, Radio, x80 y118 w60 h20 vitem12 gOnRadioChange Disabled, 自定义
Gui, Add, Edit, x80 y138 w130 h20 Disabled Limit10 vMestext

Gui, Add, Text, x15 y165 w60 h20 Right vM5, 选项：
Gui, Add, Checkbox, x80 y163 w90 h20 vExitornot Disabled, 完成后退出

Gui, Add, Button, x15 y185 w200 h35 vReady Default Disabled, 准备

Gui, Add, Progress, x15 y60 w240 h20 -Smooth vMyProgress Hidden

Gui, Add, Text, x15 y90 w145 h20 Left vPercent Hidden
Gui, Add, Text, x160 y90 w40 h20 Hidden Right vM11, 间隔:
Gui, Add, Edit, x205 y88 w50 h20 Limit4 Number CEnter Hidden gTimechange vTime2, %Mestime%

Gui, Add, Button, x15 y10 w120 h40 Hidden vM12, 发送
Gui, Add, Button, x135 y10 w60 h40 Hidden vM13, 重置
Gui, Add, Button, x195 y10 w60 h40 Hidden vM14, 退出

Gui, Add, Slider, x15 y110 w240 h20 NoTicks ToolTip gMySlider Line10 page100 vMestime2 Range10-1000 Hidden, %Mestime%

Gui, Show, AutoSize, 消息工具%version%


Gui, 2:Color,00FFFF
Gui, 2:-Caption +ToolWindow +Border +AlwaysOnTop +LastFound
WinSet, TransColor,EEAA99 50

FileDelete,%A_Temp%\Cross.CUR
FileDelete,%A_Temp%\Full.ico
FileDelete,%A_Temp%\Null.ico
;图片控件
IfNotExist,%Full_ico_File%
	BYTE_TO_FILE(StrToBin(Full_ico),Full_ico_File)
GuiControl,,Pic,%Full_ico_File%

return


;~ 后台发送发送间隔输入框
Timechange:
	GuiControlGet, Timech,, Time2
	GuiControl,, Mestime2, %Timech%
return

;判断选中自定义时输入框可用，否则置灰
OnRadioChange:
	GuiControlGet, item3,, item12
	GuiControl, Enable%item3%, Mestext
	;~ itemcheck = item3
return

;~ 后台发送界面滑块
MySlider:
	GuiControl,, Time2, %Mestime2%
return

Button准备:
	Gui, Submit, NoHide
	;~ MsgBox %Mesnum%
	if (!Mesnum or (item12=1 and !Mestext))
	{
		MsgBox ,4112,警告,非法输入！
		return
	}
	else if !OutWin3
	{
		MsgBox ,4112,警告,发送窗口未定位！
		return
	}
	;~ else if OutWin10 != SuningIM.exe
	;~ {
		;~ MsgBox ,4112,警告,定位窗口错误！
		;~ return
	;~ }
	else
	{
		GuiControl, Hide, L1
		GuiControl, Hide, Pic
		GuiControl, Hide, Mesnum
		;~ GuiControl, Hide, Mestime
		GuiControl, Hide, item11
		GuiControl, Hide, item12
		GuiControl, Hide, Mestext
		GuiControl, Hide, Exitornot
		GuiControl, Hide, Ready
		GuiControl, Hide, M1
		GuiControl, Hide, Process1
		GuiControl, Hide, ProcessName1
		GuiControl, Hide, success1
		GuiControl, Hide, success2
		;~ GuiControl, Hide, M2
		;~ GuiControl, Hide, M3
		GuiControl, Hide, M4
		GuiControl, Hide, M5
		GuiControl,, Percent, 当前:0条 / 共:%Mesnum%条
		;~ GuiControl,, Time2, %Mestime%
		GuiControl, Show, MyProgress
		GuiControl, Show, Percent
		GuiControl, Show, Time2
		GuiControl, Show, Mestime2
		GuiControl, Show, M11
		GuiControl, Show, M12
		GuiControl, Show, M13
		GuiControl, Show, M14
		Gui, Show, AutoSize, 消息工具%version%
	}

	Pause

	;暂停

Button暂停:
F9::
	Pause

Button发送:
F8::

	if classa = 2
	{
		WinGet, hwnd1, ID, ahk_class %OutWin2%
		Loop
		{
			WinGetPos,,, width, height, ahk_id %hwnd1%
			if !width
			{
				MsgBox ,262160,警告,发送窗口已关闭！
				Reload
			}
			height1 := height-100
			ControlClick,, ahk_id %hwnd1%,,,, NA X400 Y%height1%
			if item11=1
			{
				A+=1
				ControlSend,, mes%A%, ahk_id %hwnd1%
			}

			else if item12=1
			{
				ControlSend,, %Mestext%, ahk_id %hwnd1%
			}
			ControlSend,, {Enter}, ahk_id %hwnd1%
			c := a_index/Mesnum*100
			GuiControl,, MyProgress, %c%
			GuiControl,, Percent, 当前:%a_index%条 / 共:%Mesnum%条

			Sleep, 	%Mestime2%
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

	else if classa =1
	{
		;~ 获取当前窗口的HWND
		ControlGet, hwnd1, Hwnd,, %OutCtrl1%, ahk_class %OutWin2%
		Loop
		{
			ControlGet, style2, Style,,, ahk_id %hwnd1%
			if !style2
			{
				MsgBox ,262160,警告,发送窗口已关闭！
				Reload
			}
			ControlGetPos,,,width, height,, ahk_id %hwnd1%
			height1 := height-100
			ControlClick,, ahk_id %hwnd1%,,,, NA x50 y%height1%

			if item11=1
			{
				A+=1
				ControlSend,, mes%A%, ahk_id %hwnd1%
			}

			else if item12=1
			{
				ControlSend,, %Mestext%, ahk_id %hwnd1%
			}
			ControlSend,, {Enter}, ahk_id %hwnd1%
			c := a_index/Mesnum*100
			GuiControl,, MyProgress, %c%
			GuiControl,, Percent, 当前:%a_index%条 / 共:%Mesnum%条

			Sleep, 	%Mestime2%
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



	;托盘菜单1
MenuReload:
Button重置:
	Reload
return

;托盘菜单2
GuiClose:
GuiEscape:
Button退出:
MenuExit:
F10::
	ExitApp
return

;托盘菜单3
Menuchangelog:
	TaskDialogUseMsgBoxOnXP(true)
	TaskDialogEx("更新日志",
	(LTrim
		"	Author: Sword

		Date: 2012/12/12
		Version: 0.9 实现飞信发送消息的基本功能

		Date: 2013/6/3
		Version: 1.0 发送消息功能适配豆芽

		Date: 2013/7/3
		Version: 2.0 变更消息生成的实现方式

		Date: 2014/8/3
		Version: 3.0 发送消息间隔可自定义，增加了发送完成自动退出

		Date: 2015/11/25
		Version: 4.0 发送消息内容可自定义

		Date: 2015/11/30
		Version: 4.2 优化界面显示，增加重启功能

		Date: 2015/11/30
		Version: 5.0 优化界面显示，增加对微信、QQ的支持

		Date: 2015/12/12
		Version: 5.5 增加发送剪贴板的功能

		2015/12/22
		Version: 5.7 增加后台发送的功能

		2015/12/24
		Version: 5.8 增加后台发送的进度显示窗口

		2015/12/24
		Version: 5.9 增加后台发送时的发送速度调节，发送时的Tooltip提示

		2016/02/01
		Version: 5.9 TaskDialog函数为just me作品，增加后台发送时异常的判断
		
		2016/02/05
		Version: 6.0 增加非默认大小窗口的适配，优化界面显示
		
		2016/02/17
		Version: 6.1 移除前台发送的功能，通过抓取判断需要发送的窗口
		"
	),"更新日志",1,5,500,-1,0)
return

~MButton::
	MouseGetPos,OutX,OutY,OutWin3,OutCtrl1	;取鼠标下信息
	WinGetPos,WinX,WinY,WinW,WinH,ahk_id %OutWin3% ;取鼠标下窗口坐标/大小
	WinGetTitle,OutWin1,ahk_id %OutWin3%	;取鼠标下窗口标题
	WinGetClass,OutWin2,ahk_id %OutWin3%	;取鼠标下窗口类名
	WinGet,OutWin10,ProcessName,ahk_id %OutWin3%
	WinGet,OutWin11,ProcessPath,ahk_id %OutWin3%	;窗口进程路径
	GuiControl,, ProcessName1, %OutWin10%
	GuiControl,, ProcessPath1, %OutWin11%
	ControlGetPos,OutCtrlX,OutCtrlY,OutCtrlW,OutCtrlH,%OutCtrl1%,ahk_id %OutWin3%	;控件坐标/大小
	if OutWin10 = SuningIM.exe
	{
		;~ MsgBox %OutCtrlX%,%OutCtrlY%,%OutCtrlW%,%OutCtrlH%
		GuiControl,, success1, 定位成功！
		GuiControl, Enable, Mesnum
		GuiControl, Enable, item11
		GuiControl, Enable, item12
		GuiControl, Enable, Exitornot
		GuiControl, Enable, Ready
	}
	else
	{
		GuiControl,, success2, 定位失败！
		GuiControl, Disable, Mesnum
		GuiControl, Disable, item11
		GuiControl, Disable, item12
		GuiControl, Disable, Exitornot
		GuiControl, Disable, Ready
	}
	if OutCtrl1 <>
	{
		classa := 1
	}
	else
	{
		classa := 2
	}

	if (OutWin3!=AHKID)
	{
		Gui2Show(WinX+OutCtrlX,WinY+OutCtrlY,OutCtrlW,OutCtrlH)
	}
return

GetPos:
	MouseGetPos,OutX,OutY,OutWin3,OutCtrl1	;取鼠标下信息
	WinGetPos,WinX,WinY,WinW,WinH,ahk_id %OutWin3% ;取鼠标下窗口坐标/大小
	WinGetTitle,OutWin1,ahk_id %OutWin3%	;取鼠标下窗口标题
	WinGetClass,OutWin2,ahk_id %OutWin3%	;取鼠标下窗口类名
	WinGet,OutWin10,ProcessName,ahk_id %OutWin3%
	WinGet,OutWin11,ProcessPath,ahk_id %OutWin3%	;窗口进程路径
	GuiControl,, ProcessName1, %OutWin10%
	GuiControl,, ProcessPath1, %OutWin11%
	ControlGetPos,OutCtrlX,OutCtrlY,OutCtrlW,OutCtrlH,%OutCtrl1%,ahk_id %OutWin3%	;控件坐标/大小
	if OutWin10 = SuningIM.exe
	{
		;~ MsgBox %OutCtrlX%,%OutCtrlY%,%OutCtrlW%,%OutCtrlH%
		GuiControl,, success1, 定位成功！
		GuiControl, Enable, Mesnum
		GuiControl, Enable, item11
		GuiControl, Enable, item12
		GuiControl, Enable, Exitornot
		GuiControl, Enable, Ready
	}
	else
	{
		GuiControl,, success2, 定位失败！
		GuiControl, Disable, Mesnum
		GuiControl, Disable, item11
		GuiControl, Disable, item12
		GuiControl, Disable, Exitornot
		GuiControl, Disable, Ready
	}

	if OutCtrl1 <>
	{
		classa := 1
	}
	else
	{
		classa := 2
	}
	if (OutWin3!=AHKID)
	{
		Gui2Show(WinX+OutCtrlX,WinY+OutCtrlY,OutCtrlW,OutCtrlH)
	}
return



Setico:

	IfNotExist,%Cross_CUR_File%
		BYTE_TO_FILE(StrToBin(Cross_CUR),Cross_CUR_File)
	IfNotExist,%Null_ico_File%
		BYTE_TO_FILE(StrToBin(Null_ico),Null_ico_File)
	GuiControl,,Pic,%Null_ico_File%
	;设置鼠标指针为十字标
	CursorHandle := DllCall( "LoadCursorFromFile", Str,Cross_CUR_File )
	DllCall( "SetSystemCursor", Uint,CursorHandle, Int,32512 )
	SetTimer,GetPos,500
	;等待左键弹起
	KeyWait,LButton
	Gui, 2:Hide
	SetTimer,GetPos,Off
	;还原鼠标指针
	DllCall( "SystemParametersInfo", UInt,0x57, UInt,0, UInt,0, UInt,0 )
	;图标设置为原样
	IfNotExist,%Full_ico_File%
		BYTE_TO_FILE(StrToBin(Full_ico),Full_ico_File)
	GuiControl,,Pic,%Full_ico_File%
return


Gui2Show(x,y,w,h){
	Gui, 2:Show,NA x%x% y%y% w%w% h%h%
	Sleep,300
	Gui, 2:Hide
}

;字符串转二进制
StrToBin(Str) {
	XMLDOM:=ComObjCreate("Microsoft.XMLDOM")
	xmlver:="<?xml version=`"`"1.0`"`"?>"
	XMLDOM.loadXML(xmlver)
	Pic:=XMLDOM.createElement("pic")
	Pic.dataType:="bin.hex"
	pic.nodeTypedValue := Str
	StrToByte := pic.nodeTypedValue
	return StrToByte
}

; 数据流保存为文件
BYTE_TO_FILE(body, filePath){
	Stream := ComObjCreate("Adodb.Stream")
	Stream.Type := 1
	Stream.Open()
	Stream.Write(body)
	Stream.SaveToFile(filePath,2) ;文件存在的就覆盖
	Stream.Close()
}


;=========================================================================
; TaskDialogEx(主文,副文,标题,按钮,图标,宽度,父窗口,超时)
TaskDialogEx(Main, Extra := "", Title := "提示：", Buttons := 1, Icon := 8, Width := 600, Parent := -1, TimeOut := 0) {
	Static TDCB      := RegisterCallback("TaskDialogCallback", "Fast")
		, TDCSize   := (4 * 8) + (A_PtrSize * 16)
		, TDBTNS    := {OK: 1, YES: 2, NO: 4, CANCEL: 8, RETRY: 16, CLOSE: 32}
		, TDF       := {HICON_MAIN: 0x0002, ALLOW_CANCEL: 0x0008, CALLBACK_TIMER: 0x0800, SIZE_TO_CONTENT: 0x01000000}
		, TDICON    := {1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9
		, WARN: 1, ERROR: 2, INFO: 3, SHIELD: 4, BLUE: 5, YELLOW: 6, RED: 7, GREEN: 8, GRAY: 9
		, QUESTION: 0}
		, HQUESTION := DllCall("User32.dll\LoadIcon", "Ptr", 0, "Ptr", 0x7F02, "UPtr")
		, DBUX      := DllCall("User32.dll\GetDialogBaseUnits", "UInt") & 0xFFFF
		, OffParent := 4
		, OffFlags  := OffParent + (A_PtrSize * 2)
		, OffBtns   := OffFlags + 4
		, OffTitle  := OffBtns + 4
		, OffIcon   := OffTitle + A_PtrSize
		, OffMain   := OffIcon + A_PtrSize
		, OffExtra  := OffMain + A_PtrSize
		, OffCB     := (4 * 7) + (A_PtrSize * 14)
		, OffCBData := OffCB + A_PtrSize
		, OffWidth  := OffCBData + A_PtrSize
	; -------------------------------------------------------------------------------------------------------------------
	if ((DllCall("Kernel32.dll\GetVersion", "UInt") & 0xFF) < 6) {
		if TaskDialogUseMsgBoxOnXP()
			return TaskDialogMsgBox(Main, Extra, Title, Buttons, Icon, Parent, Timeout)
		else {
			MsgBox, 16, %A_ThisFunc%, You need at least Win Vista / Server 2008 to use %A_ThisFunc%().
			ErrorLevel := "You need at least Win Vista / Server 2008 to use " . A_ThisFunc . "()."
			return 0
		}
	}
	; -------------------------------------------------------------------------------------------------------------------
	Flags := Width = 0 ? TDF.SIZE_TO_CONTENT : 0
	if (Title = "")
		Title := A_ScriptName
	BTNS := 0
	if Buttons Is Integer
		BTNS := Buttons & 0x3F
	else
		For Each, Btn In StrSplit(Buttons, ["|", " ", ",", "`n"])
	BTNS |= (B := TDBTNS[Btn]) ? B : 0
	ICO := (I := TDICON[Icon]) ? 0x10000 - I : 0
	if Icon Is Integer
		if ((Icon & 0xFFFF) <> Icon) ; caller presumably passed HICON
			ICO := Icon
	if (Icon = "Question")
		ICO := HQUESTION
	if (ICO > 0xFFFF)
		Flags |= TDF.HICON_MAIN
	AOT := Parent < 0 ? !(Parent := 0) : False ; AlwaysOnTop
	; -------------------------------------------------------------------------------------------------------------------
	PTitle := A_IsUnicode ? &Title : TaskDialogToUnicode(Title, WTitle)
	PMain  := A_IsUnicode ? &Main : TaskDialogToUnicode(Main, WMain)
	PExtra := Extra = "" ? 0 : A_IsUnicode ? &Extra : TaskDialogToUnicode(Extra, WExtra)
	VarSetCapacity(TDC, TDCSize, 0) ; TASKDIALOGCONFIG structure
	NumPut(TDCSize, TDC, "UInt")
	NumPut(Parent, TDC, OffParent, "Ptr")
	NumPut(BTNS, TDC, OffBtns, "Int")
	NumPut(PTitle, TDC, OffTitle, "Ptr")
	NumPut(ICO, TDC, OffIcon, "Ptr")
	NumPut(PMain, TDC, OffMain, "Ptr")
	NumPut(PExtra, TDC, OffExtra, "Ptr")
	if (AOT) || (TimeOut > 0) {
		if (TimeOut > 0) {
			Flags |= TDF.CALLBACK_TIMER
			TimeOut := Round(Timeout * 1000)
		}
		TD := {AOT: AOT, Timeout: Timeout}
		NumPut(TDCB, TDC, OffCB, "Ptr")
		NumPut(&TD, TDC, OffCBData, "Ptr")
	}
	NumPut(Flags, TDC, OffFlags, "UInt")
	if (Width > 0)
		NumPut(Width * 4 / DBUX, TDC, OffWidth, "UInt")
	if !(RV := DllCall("Comctl32.dll\TaskDialogIndirect", "Ptr", &TDC, "IntP", Result, "Ptr", 0, "Ptr", 0, "UInt"))
		return TD.TimedOut ? -1 : Result
	ErrorLevel := "The call of TaskDialogIndirect() failed!`nreturn value: " . RV . "`nLast error: " . A_LastError
	return 0
}
; ================================================================================?======================================
; Call this function once passing 1/True if you want a MsgBox to be displayed instead of the task dialog on Win XP.
; ================================================================================?======================================
TaskDialogUseMsgBoxOnXP(UseIt := "") {
	Static UseMsgBox := False
	if (UseIt <> "")
		UseMsgBox := !!UseIt
	return UseMsgBox
}
; ================================================================================?======================================
; Internally used functions
; ================================================================================?======================================
TaskDialogMsgBox(Main, Extra, Title := "", Buttons := 0, Icon := 0, Parent := 0, TimeOut := 0) {
	Static MBICON := {1: 0x30, 2: 0x10, 3: 0x40, WARN: 0x30, ERROR: 0x10, INFO: 0x40, QUESTION: 0x20}
		, TDBTNS := {OK: 1, YES: 2, NO: 4, CANCEL: 8, RETRY: 16}
	BTNS := 0
	if Buttons Is Integer
		BTNS := Buttons & 0x1F
	else
		For Each, Btn In StrSplit(Buttons, ["|", " ", ",", "`n"])
	BTNS |= (B := TDBTNS[Btn]) ? B : 0
	Options := 0
	Options |= (I := MBICON[Icon]) ? I : 0
	Options |= Parent = -1 ? 262144 : Parent > 0 ? 8192 : 0
	if ((BTNS & 14) = 14)
		Options |= 0x03 ; Yes/No/Cancel
	else if ((BTNS & 6) = 6)
		Options |= 0x04 ; Yes/No
	else if ((BTNS & 24) = 24)
		Options |= 0x05 ; Retry/Cancel
	else if ((BTNS & 9) = 9)
		Options |= 0x01 ; OK/Cancel
	Main .= Extra <> "" ? "`n`n" . Extra : ""
	MsgBox, % Options, %Title%, %Main%, %TimeOut%
	IfMsgBox, OK
		return 1
	IfMsgBox, Cancel
		return 2
	IfMsgBox, Retry
		return 4
	IfMsgBox, Yes
		return 6
	IfMsgBox, No
		return 7
	IfMsgBox, TimeOut
		return -1
	return 0
}
; ================================================================================?======================================
TaskDialogToUnicode(String, ByRef Var) {
	VarSetCapacity(Var, StrPut(String, "UTF-16") * 2, 0)
	StrPut(String, &Var, "UTF-16")
	return &Var
}
; ================================================================================?======================================
TaskDialogCallback(H, N, W, L, D) {
	Static TDM_Click_BUTTON := 0x0466
		, TDN_CREATED := 0
		, TDN_TIMER   := 4
	TD := Object(D)
	if (N = TDN_TIMER) && (W > TD.Timeout) {
		TD.TimedOut := True
		PostMessage, %TDM_Click_BUTTON%, 2, 0, , ahk_id %H% ; IDCANCEL = 2
	}
	else if (N = TDN_CREATED) && TD.AOT {
		DHW := A_DetectHiddenWindows
		DetectHiddenWindows, On
		WinSet, AlwaysOnTop, On, ahk_id %H%
		DetectHiddenWindows, %DHW%
	}
	return 0
}


LoadIcon(FullFilePath, IconNumber := 1, LargeIcon := 1) {
	HIL := IL_Create(1, 1, !!LargeIcon)
	IL_Add(HIL, FullFilePath, IconNumber)
	HICON := DllCall("Comctl32.dll\ImageList_GetIcon", "Ptr", HIL, "Int", 0, "UInt", 0, "UPtr")
	IL_Destroy(HIL)
	return HICON
}
GuiButtonIcon(Handle, File, Index := 1, Options := "")
{
	RegExMatch(Options, "i)w\K\d+", W), (W="") ? W := 16 :
	RegExMatch(Options, "i)h\K\d+", H), (H="") ? H := 16 :
	RegExMatch(Options, "i)s\K\d+", S), S ? W := H := S :
	RegExMatch(Options, "i)l\K\d+", L), (L="") ? L := 0 :
	RegExMatch(Options, "i)t\K\d+", T), (T="") ? T := 0 :
	RegExMatch(Options, "i)r\K\d+", R), (R="") ? R := 0 :
	RegExMatch(Options, "i)b\K\d+", B), (B="") ? B := 0 :
	RegExMatch(Options, "i)a\K\d+", A), (A="") ? A := 4 :
	Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
	VarSetCapacity( button_il, 20 + Psz, 0 )
	NumPut( normal_il := DllCall( "ImageList_Create", DW, W, DW, H, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )   ; Width & Height
	NumPut( L, button_il, 0 + Psz, DW )     ; Left Margin
	NumPut( T, button_il, 4 + Psz, DW )     ; Top Margin
	NumPut( R, button_il, 8 + Psz, DW )     ; Right Margin
	NumPut( B, button_il, 12 + Psz, DW )    ; Bottom Margin
	NumPut( A, button_il, 16 + Psz, DW )    ; Alignment
	SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
	return IL_Add( normal_il, File, Index )
}