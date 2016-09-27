#Persistent
#SingleInstance force
SetBatchLines -1
ListLines Off

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
		Version: 6.0 增加非默认窗口的适配，优化界面显示
		"
	),"更新日志",1,5,500,-1,0)
return

Button准备:
	Gui, Submit

	;判断消息数目，消息间隔和消息内容的合法性
	if (!Mesnum or !Mestime or Mestime<10 or (item12=1 and !Mestext))
			{
			MsgBox ,16,警告,非法输入！
			Reload
		}

	;~ var = %Mestext%
	if Mestext contains 宝,剑,保,健,13050202,辛
	{
		MsgBox ,16,警告,No zuo no die！
		Reload
	}

	;~ 判断选择豆芽和勾选后台发送时弹出发送框
	if (Platform = 1 and  background1 = 1)
	{
		ToolTip,
		(LTrim
			══════════════════重要提示════════════════
			请使用豆芽默认大小合并窗口
			发送期间不要切换豆芽当前窗口
			F8: 开始，F9: 暂停，F10: 退出
			发送期间拖拽滑块变更发送速度
			══════════════════重要提示════════════════
		)
		Gui, MyGui:font, s8, Verdana
		Gui, MyGui:  +AlwaysOnTop

		Gui, MyGui: Add, Progress, x15 y10 w240 h20 -Smooth vMyProgress

		Gui, MyGui: Add, Text, x15 y35 w145 h20 Left vPercent, 当前:0条 / 共:0条
		Gui, MyGui: Add, Text, x160 y35 w40 h20, Speed:
		Gui, MyGui: Add, Edit, x205 y33 w50 h20 Limit4 Number CEnter gTimechange vTime2, %Mestime%

		Gui, MyGui: Add, Button, x15 y55 w120 h40 , 发送
		Gui, MyGui: Add, Button, x135 y55 w60 h40 , 重置
		Gui, MyGui: Add, Button, x195 y55 w60 h40 , 退出

		Gui, MyGui: Add, Slider, x15 y100 w240 h20 NoTicks ToolTip gMySlider Line10 page100 vMestime Range10-9999, %Mestime%

		Gui, MyGui: Show, AutoSize, 消息工具

	}

	;~ 前台发送tooltip提示
	else
	{
		ToolTip,
		(LTrim
			══════════════════重要提示════════════════
			消息发送期间，不要操作键盘和鼠标，以免发生错误！
			激活豆芽输入框，F8: 开始，F9: 暂停，F10: 退出
			══════════════════重要提示════════════════
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
	if (Platform = 1 and background1 = 0) ;豆芽前台发送
	{
		B+=1
#IfWinActive, ahk_class Qt5QWindowIcon   ;豆芽

		Loop
		{
			;窗口丢失焦点时，弹出tooltip并暂停
			IfWinNotActive, ahk_class Qt5QWindowIcon
			{
				;~ 关闭tooltip
				ToolTip
				MsgBox ,262160,警告,丢失焦点，发送已暂停！`n激活窗口按F8继续发送`n
				break
			}
			A+=1
			C := Mesnum*B
			; 把 ToolTips 放置在相对于活动窗口的工作区，其中不包括标题栏、菜单栏（如果它含有标准菜单栏）和边框
			CoordMode, ToolTip, client
			ToolTip,
			(LTrim
				══════════════════重要提示════════════════
				消息发送期间，不要操作键盘和鼠标，以免发生错误！
				当前第%A%条/共%C%条
				F8: 开始，F9: 暂停，F10: 退出
				══════════════════重要提示════════════════
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

	if (Platform = 1 and  background1 = 1)  ;豆芽后台发送
	{
		;判断是不是合并窗口
		ControlGet, OutputVar, Visible,, Qt5QWindowIcon6, ahk_class Qt5QWindowIcon
		if ErrorLevel ;单窗口
		{
			ExitApp
			;~ 关闭tooltip
			ToolTip
			;~ 获取当前窗口的HWND
			WinGet, hwnd1, ID, ahk_class Qt5QWindowIcon
			Loop
			{
				WinGet, hwnd2, ID, ahk_class Qt5QWindowIcon
				;~ 窗口切换时判断
				if (hwnd1 != hwnd2)
				{
					MsgBox ,262160,警告,发送窗口变更，已暂停！`n点击发送或按F8继续
					break
				}
				if item11=1
				{
					A+=1
					WinGetPos,,,width, height, ahk_class Qt5QWindowIcon
					height1 := height-100
					ControlClick, X50 Y%height1%, ahk_class Qt5QWindowIcon
					ControlSend, Qt5QWindowIcon10, 	mes%A%, ahk_class Qt5QWindowIcon
					ControlSend, Qt5QWindowIcon10, {Enter} , ahk_class Qt5QWindowIcon
					c := a_index/Mesnum*100
					GuiControl,, MyProgress, %c%
					GuiControl,, Percent, 当前:%a_index%条 / 共:%Mesnum%条

				}

				else if item12=1
				{
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
		else ;合并窗口
		{
			;~ 关闭tooltip
			ToolTip
			;~ 获取当前窗口的HWND
			ControlGet, hwnd1, Hwnd,, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon
			Loop
			{
				ControlGet, hwnd2, Hwnd,, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon
				;~ 窗口切换时判断
				if (hwnd1 != hwnd2)
				{
					MsgBox ,262160,警告,发送窗口变更，已暂停！`n点击发送或按F8继续
					break
				}
				if item11=1
				{
					A+=1
					ControlGetPos,,,width, height, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon
					height1 := height-100
					ControlClick, Qt5QWindowIcon10, ahk_class Qt5QWindowIcon,,,, NA x50 y%height1%
					ControlSend, Qt5QWindowIcon10, 	mes%A%, ahk_class Qt5QWindowIcon
					ControlSend, Qt5QWindowIcon10, {Enter} , ahk_class Qt5QWindowIcon
					c := a_index/Mesnum*100
					GuiControl,, MyProgress, %c%
					GuiControl,, Percent, 当前:%a_index%条 / 共:%Mesnum%条

				}

				else if item12=1
				{
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

	}

	else if Platform = 2 ;微信
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

else if Platform = 3 ;QQ
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