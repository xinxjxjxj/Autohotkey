#Persistent
#SingleInstance force
SetBatchLines -1
ListLines Off

;~ 工具集合

Gui, font, s8, Verdana


SettingFile = %A_ScriptDir%\config.ini
if FileExist(SettingFile)
{
	;~ 获取配置文件的section名称
	IniRead, Sectionname, %SettingFile%
	
	StringReplace, NewStr, Sectionname, `n, |, All
	Tabname = %NewStr%|Settings
	Gui, Add, Tab2, h500, %Tabname%
	
	;~ 获取section中的key和value
	IniRead, P1, %SettingFile%, %Sectionname%
	;~ 获取key名称并创建gui button
	Loop, Parse, P1, `n
	{
		Loop, Parse, A_LoopField, =
		{
			if A_Index = 1
			{
				Gui, Add, Button,gG1, % A_LoopField
			}
		}
	}
}
else
{
	FileAppend,
	(
[Program]
Notepad	=	Notepad.exe
	), config.ini

	;~ 获取配置文件的section名称
	IniRead, Sectionname, %SettingFile%
	;~ 获取section中的key和value
	IniRead, P1, %SettingFile%, %Sectionname%
	;~ 获取key名称并创建gui button
	Loop, Parse, P1, `n
	{
		Loop, Parse, A_LoopField, =
		{
			if A_Index = 1
			{
				Gui, Add, Button,gG1, % A_LoopField
			}
		}
	}
}


	Gui, Tab, Settings

	Gui, Add, Button, gOpen, 打开配置文件
	Gui, Add, Button, gRefresh, 刷新界面

	Gui, show, AutoSize, tool
	return

G1:
	IniRead, Sectionname, %SettingFile%
	IniRead, ABC, %SettingFile%, %Sectionname%, %A_GuiControl%
	Run, % ABC
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
