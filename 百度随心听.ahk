#NoEnv
#SingleInstance, Force

;任务栏工作列气泡提示
;TrayTip, 提示, 工具已启动, 6, 1
TrayTip, ,Ctrl→: 切歌 `nCtrl↓: 不喜欢 `nCtrl↑: 喜欢 `nCtrl←: 暂停 `nCtrl /: 歌名,  3, 1

; 歌名
^/::
	wb := IEGet("百度音乐随心听")
	title := wb.document.title
	TrayTip , ,%title%, 3
return

; 切歌
^Right::
	wb := IEGet("百度音乐随心听")
	wb.document.getElementById("playerpanel-btnskip").Click()
	wb := IEGet("百度音乐随心听")
	title := wb.document.title
	TrayTip , ,%title%, 3
return

; hate
^Down::
	wb := IEGet("百度随心听")
	;~ title := wb.document.title
	;~ MsgBox, % title
	wb.document.getElementById("playerpanel-btnhate").Click()
return

; love
^Up::
	wb := IEGet("百度随心听")
	wb.document.getElementById("playerpanel-btnlove").Click()
	wb := IEGet("百度随心听")
	title := wb.document.title
	TrayTip , ,%title%, 3
return

; 暂停/播放
^Left::
	wb := IEGet("百度随心听")
	;~ title := wb.document.title
	;~ MsgBox, % title
	wb.document.getElementById("playerpanel-btnplay").Click()
return

IEGet(Name="")      ;获取到现有的 IE 窗口/选项卡的指针
{
	IfEqual, Name,, WinGetTitle, Name, ahk_class IEFrame
	Name := ( Name="New Tab - Windows Internet Explorer" ) ? "about:Tabs"
: RegExReplace( Name, " - (Windows|Microsoft) Internet Explorer" )
	For Pwb in ComObjCreate( "Shell.Application" ).Windows
		if ( Pwb.LocationName = Name ) && InStr( Pwb.FullName, "iexplore.exe" )
			return Pwb
		}