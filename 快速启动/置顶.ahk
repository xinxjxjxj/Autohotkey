﻿#Persistent
#SingleInstance force
SetBatchLines -1
ListLines Off


;图标数据
Cross_CUR:="000002000100202002000F00100034010000160000002800000020000000400000000100010000000000800000000000000000000000020000000200000000000000FFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83FFFFFE6CFFFFFD837FFFFBEFBFFFF783DFFFF7EFDFFFEAC6AFFFEABAAFFFE0280FFFEABAAFFFEAC6AFFFF7EFDFFFF783DFFFFBEFBFFFFD837FFFFE6CFFFFFF83FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF28000000"
Full_ico:="0000010001002020100000000000E8020000160000002800000020000000400000000100040000000000000200000000000000000000100000001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFFF00FF0FF00FFFFFFFFFF000FFFFFFFFF0FF00000FF0FFFFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFF0FFFF00000FFFF0FFFFFFF000FFFFFFF0FFFFFF0FFFFFF0FFFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF000FFFFFF0000000F0F0000000FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFFF0FFFFFF0FFFFFF0FFFFFFF000FFFFFFF0FFFF00000FFFF0FFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFFFF0FF00000FF0FFFFFFFFF000FFFFFFFFFF00FF0FF00FFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000007770CCCCCCCCCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC07070007770CCCCCCCCCCCCCCCCCCCCC0777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF80000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"
Null_ico:="0000010001002020100000000000E8020000160000002800000020000000400000000100040000000000000200000000000000000000100000001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000007770CCCCCCCCCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC07070007770CCCCCCCCCCCCCCCCCCCCC0777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF80000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"


Cross_CUR_File=%A_Temp%\Cross.CUR
Full_ico_File=%A_Temp%\Full.ico
Null_ico_File=%A_Temp%\Null.ico




;主界面
Gui, font, s8, Verdana
Gui, +AlwaysOnTop +HwndAHKID

Gui, Add, Text, x75 y13 w150 h20 vL1, (拖动左侧定位窗口)
Gui, Add, Picture, x35 y5 w32 h32 gSetico vPic

Gui, Add, Text, x15 y40 w60 h20 Right vProcess1, 进程名：
Gui, Add, Text, x75 y40 w130 h20 vProcessName1

Gui, font


Gui, Show, AutoSize, 置顶窗口


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




~MButton::
	MouseGetPos,OutX,OutY,OutWin3,OutCtrl1	;取鼠标下信息
	WinGetPos,WinX,WinY,WinW,WinH,ahk_id %OutWin3% ;取鼠标下窗口坐标/大小
	WinGetTitle,OutWin1,ahk_id %OutWin3%	;取鼠标下窗口标题
	WinGetClass,OutWin2,ahk_id %OutWin3%	;取鼠标下窗口类名
	WinGet,OutWin10,ProcessName,ahk_id %OutWin3%
	WinGet,OutWin11,ProcessPath,ahk_id %OutWin3%	;窗口进程路径
	GuiControl,, ProcessName1, %OutWin1%
	ControlGetPos,OutCtrlX,OutCtrlY,OutCtrlW,OutCtrlH,%OutCtrl1%,ahk_id %OutWin3%	;控件坐标/大小

return

GetPos:
	MouseGetPos,OutX,OutY,OutWin3,OutCtrl1	;取鼠标下信息
	WinGetPos,WinX,WinY,WinW,WinH,ahk_id %OutWin3% ;取鼠标下窗口坐标/大小
	WinGetTitle,OutWin1,ahk_id %OutWin3%	;取鼠标下窗口标题
	WinGetClass,OutWin2,ahk_id %OutWin3%	;取鼠标下窗口类名
	WinGet,OutWin10,ProcessName,ahk_id %OutWin3%
	WinGet,OutWin11,ProcessPath,ahk_id %OutWin3%	;窗口进程路径
	GuiControl,, ProcessName1, %OutWin1%
	ControlGetPos,OutCtrlX,OutCtrlY,OutCtrlW,OutCtrlH,%OutCtrl1%,ahk_id %OutWin3%	;控件坐标/大小


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
