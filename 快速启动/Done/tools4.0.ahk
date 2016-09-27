#Persistent
#SingleInstance force
SetBatchLines -1
ListLines Off
#NoTrayIcon

;~ 工具集合

SettingFile = %A_ScriptDir%\Config.ini

;~ 检查配置文件是否存在
if FileExist(SettingFile)
{
	;~ 获取配置文件的section名称
	IniRead, Sectionname, %SettingFile%
	;~ MsgBox, % Sectionname

	;~ 获取标签页的名称并创建标签页
	StringReplace, NewStr, Sectionname, `n, |, All
	Tabname = %NewStr%|۞设置

	Gui, font, s8, Arial
	Gui, Add, Tab2, R25, %Tabname%

	Loop, Parse, Sectionname, `n
	{
		;~ 对应标签页下创建按钮
		Gui, Tab, %A_LoopField%

			;~ 获取section中的key和value
			IniRead, P1, %SettingFile%, % A_LoopField

			;~ 获取并用key名称创建gui button
			Loop, Parse, P1, `n
			{
				if A_LoopField contains =
				{
					Loop, Parse, A_LoopField, =
					{
						if A_Index = 1
						{
							if A_LoopField contains ★
							{
								Gui, Font, s8 w700, Arial
								Gui, Add, Button, w250 y+1 gG1, %A_LoopField%★
								Gui, Font, s8 w400, Arial
							}
							else if A_LoopField<>
								Gui, Add, Button, w250 y+1 gG1, %A_LoopField%
						}
					}
				}
			}
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
Notepad=Notepad.exe

[SectionName2]
calc=%windir%\system32\calc.exe
	), Config.ini
	Run, %A_ScriptDir%\Config.ini
	Reload

}

	Gui, Tab, ۞设置

	Gui, Add, Button, w250 gOpen, 打开配置文件
	Gui, Add, Button, w250 gRefresh, 重新载入配置

	Gui, show,, Quick Launch

	;~ 右键菜单
	Menu, MyMenu, Add, 启动, Gopen
	;~ Menu, MyMenu, Add, 最小化启动, Minopen
	Menu, MyMenu, Add, 最大化启动, Maxopen
	Menu, MyMenu, Add, 打开程序所在路径, Openfolder
	Menu, MyMenu, Add, 打开配置文件, Openini
	Menu, MyMenu, Add, 重新载入配置, Reloadini
	Menu, MyMenu1, Add, 打开配置文件, Openini
	Menu, MyMenu1, Add, 重新载入配置, Reloadini

	return

	;~ 点击按钮运行程序
G1:
	IniRead, Sectionname, %SettingFile%
	Loop, Parse, Sectionname, `n
	{
		;~ 读取按钮名称的key值并运行
		IniRead, ABC, %SettingFile%, %A_LoopField%, %A_GuiControl%
		if ABC = ERROR
			continue
		else
		{
			if !ABC
				MsgBox, 16, 错误, %ABC%在Config.ini中未维护路径, 3
			else
			{
				Run, % ABC
				ExitApp
			}
		}
	}
return

;~ gui按钮上右键显示菜单
GuiContextMenu:
	IniRead, Sectionname, %SettingFile%
	Loop, Parse, Sectionname, `n
	{
		;~ 读取按钮名称的key值并运行
		IniRead, ABC, %SettingFile%, %A_LoopField%, %A_GuiControl%
		if ABC = ERROR
			continue
		else
			break
	}
	if A_GuiControl<>
		Menu, MyMenu, Show
	else
		Menu, MyMenu1, Show

return

Gopen:
	if !ABC
		MsgBox, 16, 错误, %ABC%在Config.ini中未维护路径, 3
	else
		Run, % ABC
return

;~ Minopen:
;~ Run, %ABC%, ,min
;~ return

Maxopen:
	if !ABC
		MsgBox, 16, 错误, %ABC%在Config.ini中未维护路径, 3
	else
		Run, %ABC%, ,max
return

Openfolder:
	if ABC contains \
	{
		Loop, Parse, ABC, \
		{
			DEF = %A_LoopField%
		}
		;~ MsgBox, % DEF
		StringReplace, NewStr, ABC, %DEF%, , All
		;~ MsgBox, % NewStr
		Run, % NewStr
	}
	else
		MsgBox, 16, 错误, %ABC%在Config.ini中未维护路径, 3
return

Openini:
Open:
	Run, %A_ScriptDir%\Config.ini
return

Reloadini:
Refresh:
	Reload
return

GuiClose:
F10::
	ExitApp
