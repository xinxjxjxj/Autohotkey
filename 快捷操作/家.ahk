
;日期
::DD::
y = %A_YYYY%/%A_MM%/%A_DD%
clipboard = %y%
Send ^v
return

;日期2
:*:FF::
y = %A_MM%%A_DD%%A_Hour%%A_Min%%A_Sec%
clipboard = %y%
Send ^v
return

;时间
::JJ::
x = %A_Hour%:%A_Min%:%A_Sec%
clipboard = %x%
Send ^v
return

;日期时间
::DT::
w = %A_YYYY%/%A_MM%/%A_DD% %A_Hour%:%A_Min%:%A_Sec%
clipboard = %w%
Send ^v
return

;新建时间日期文件夹
#f::
Click right
Send, wf
Sleep, 125
clipboard = %A_YYYY%/%A_MM%/%A_DD% %A_Hour%:%A_Min%:%A_Sec%
Send, ^v{Enter}
return


#b:: 
Send ^c 
Run http://www.baidu.com/s?wd=%clipboard%
return

;命令行cmd里可以ctrl v 
#IfWinActive ahk_class ConsoleWindowClass 
^v:: 
MouseClick, Right, %A_CaretX%, %A_CaretY%,,0 
send p 
return