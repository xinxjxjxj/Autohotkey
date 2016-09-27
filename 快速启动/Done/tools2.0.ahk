#Persistent
#SingleInstance force
SetBatchLines -1
ListLines Off
#NoTrayIcon

;~ 工具集合

SettingFile = %A_ScriptDir%\config.ini

;~ 检查配置文件是否存在
if FileExist(SettingFile)
{
	;~ 获取配置文件的section名称
	IniRead, Sectionname, %SettingFile%

	;~ 获取标签页的名称并创建标签页
	StringReplace, NewStr, Sectionname, `n, |, All
	;~ NewStr := StrReplace(Sectionname, "`n" , "|", OutputVarCount)
	Tabname = %NewStr%|Settings

	Gui, font,  underline s8, Arial
	Gui, Add, Tab2, R25, %Tabname%
	Gui, font
	Gui, font, s8, Arial

	Loop, Parse, Sectionname, `n
	{
		;~ 对应标签页下创建按钮
		Gui, Tab, %A_LoopField%

			;~ 获取section中的key和value
			IniRead, P1, %SettingFile%, % A_LoopField

			;~ 获取并用key名称创建gui button
			Loop, Parse, P1, `n
			{
				Loop, Parse, A_LoopField, =
				{
					if A_Index = 1
					{
						Gui, Add, Button, w250 y+1 gG1, %A_LoopField%
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
Notepad	=	Notepad.exe

[SectionName2]
calc	=	%windir%\system32\calc.exe
	), config.ini
	Run, %A_ScriptDir%\config.ini
	Reload

}

	Gui, Tab, Settings

	Gui, Add, Button, w250 gOpen, 打开配置文件
	Gui, Add, Button, w250 gRefresh, 重新载入配置

	Gui, show,, Quick Launch
	return

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
			Run, % ABC
			break
		}
	}
return

Open:
	Run, %A_ScriptDir%\config.ini
return

Refresh:
	Reload
return


GuiClose:
F10::
	ExitApp
