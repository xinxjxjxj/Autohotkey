#Persistent
#SingleInstance force
SetBatchLines -1
ListLines Off


;~ Menu, tray, add, 打开配置文件路径, MenuHandler2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;快捷启动;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SettingFile = %A_ScriptDir%\config.ini

;~ 检查配置文件是否存在
if FileExist(SettingFile)
{
	;~ 获取配置文件的section名称
	IniRead, Sectionname, %SettingFile%
	Loop, Parse, Sectionname, `n
	{
		ABB := A_LoopField
		Menu, SubMenu1, Add, %A_LoopField%, MenuHandler
		Menu, tray, add, Quick Launch, :SubMenu1

		;~ 获取section中的key和value
		IniRead, P1, %SettingFile%, % A_LoopField

		;~ 获取并用key名称创建gui button
		Loop, Parse, P1, `n
		{
			Loop, Parse, A_LoopField, =
			{
				if A_Index = 1
				{
					Menu, %ABB%, Add, %A_LoopField%, MenuHandler
				}

			}
		}
		Menu, SubMenu1, Add, %A_LoopField%, :%A_LoopField%
	}
}

;~ 配置文件不存在创建默认
else
{
	FileAppend,
	(
		;~ 配置此文件增加快捷启动项,使用标准的 .ini 文件格式
		;~ [SectionName]
		;~ Key=Value
		;~ SectionName:标签页名称
		;~ Key:界面按钮名称
		;~ Value:应用程序的绝对路径

[SectionName1]
Notepad	=	Notepad.exe

[SectionName2]
calc	=	%windir%\system32\calc.exe
	), config.ini
	Run, %A_ScriptDir%\config.ini
	Reload

}

return

;~ MenuHandler2:
	;~ Run, E:\Baiduyun\Backup Files\Autohotkey\快捷操作
	;~ return

MenuHandler:
IniRead, Sectionname, %SettingFile%
	Loop, Parse, Sectionname, `n
	{
		;~ 读取按钮名称的key值并运行
		IniRead, ABC, %SettingFile%, %A_LoopField%, %A_ThisMenuItem%
		if ABC = ERROR
			continue
		else
		{
			Run, % ABC
			break
		}
	}
return



;~ Menu, tray , NoStandard
; ! Alt
; ^ Control
; + Shift

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;通用;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!s::Suspend
^!r::Reload
	;~ ::pp::pass
	;~ ::ff::fail
	;~ ::ww::block
::tt::通过{enter}
	;~:*:ww::失败
;~ ::xx::辛剑
::yy::
	olda = %clipboard%
	Sleep 100
	clipboard = %A_YYYY%/%A_MM%/%A_DD% %A_Hour%:%A_Min%:%A_Sec% 验证通过
	Send ^v
	clipboard = %olda%
	return
	;~ ::vy::V2.3.6验证通过
::zz::暂未复现
	;~ ::oo::MPC-
	;~ :*:mm::Mm111111
	;~ :*:pgs::PostgreSQL
	;~ :*:mgd::MongoDB
	;~ :*:red::Redis
	;~ :*:mec::Memcached
	;~ :*:mys::MySQL
:*b0:'''::'''{left 3}

	;日期
::dd::
	;~ olda = %clipboard%
	clipboard = %A_YYYY%/%A_MM%/%A_DD%
	Send ^v
	;~ clipboard = %olda%
return

;日期2%A_Sec%
::ss::
	;~ olda = %clipboard%
	clipboard = %A_MM%%A_DD%%A_Hour%%A_Min%
	Send ^v
	;~ clipboard = %olda%
return

;时间
::JJ::
	olda = %clipboard%
	clipboard = %A_Hour%:%A_Min%:%A_Sec%
	Send ^v
	clipboard = %olda%
return

;日期时间
::DT::
	olda = %clipboard%
	clipboard = %A_YYYY%/%A_MM%/%A_DD% %A_Hour%:%A_Min%:%A_Sec%
	Send ^v
	clipboard = %olda%
return

;新建时间日期文件夹
#f::
	Click Right
	Send, wf
	Sleep, 125
	olda = %clipboard%
	clipboard = %A_YYYY%/%A_MM%/%A_DD% %A_Hour%:%A_Min%:%A_Sec%
	Send, ^v{Enter}
	clipboard = %olda%
return

;~ 百度搜索
#b::
	Send, ^c
	Run http://www.baidu.com/s?wd=%clipboard%
return

;~ 打开计算器
#j::
	Run calc.exe
return


#t::
	WinGetActiveStats, topTitle, Width, Height, X, Y
	WinSet, AlwaysOnTop, Toggle, %topTitle%
	TrayTip,, %topTitle%, 3, 1
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;jira;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive ahk_class Maxthon3Cls_MainFrm
:*:vv::
	y12 = SNCP_SIT_V1.0 验证通过
	clipboard = %y12%
	Send ^v
return

:*:ii::
	y12 =【SIT】【】
	clipboard = %y12%
	Send ^v
return

;`n浏览器：Chrome 49.0.2623.75 m
;`n浏览器：IE 11.0.9600.18124
::bbb::
	y1 =【测试环境】`n系统：Windows 7 专业版`n浏览器：Chrome 49.0.2623.75 m`n版本：SPCP_SIT_1.44.3
	y2 =【前提条件】`n登录SPCP
	y3 =【操作步骤】
	y4 =【实际现象】
	y5 =【预期现象】
	y6 =【备注】`n无
	clipboard = %y1%
	Send ^v{Enter}{Enter}
	clipboard = %y2%
	Send ^v{Enter}{Enter}
	clipboard = %y3%
	Send ^v{Enter}{Enter}{Enter}
	clipboard = %y4%
	Send ^v{Enter}{Enter}{Enter}
	clipboard = %y5%
	Send ^v{Enter}{Enter}{Enter}
	clipboard = %y6%
	Send ^v
	Send {up 9}
return

#s::
	Sleep, 1500
	Send {Tab}
	Send, 13050202
	Sleep, 200
	Send {Tab}
	clipboard = xj1989614!
	Send, ^v{Enter}
	Sleep, 300
	Send {Enter}
return

;命令行cmd里可以ctrl v
#IfWinActive ahk_class ConsoleWindowClass
^v::
	MouseClick, Right, %A_CaretX%, %A_CaretY%,,0
	Send p
return


