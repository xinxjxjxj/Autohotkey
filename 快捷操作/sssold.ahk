:*:tt::通过
::ss::失败
::ww::未执行
::xx::辛剑
::ii::IMII-
::vv::V2.1.6
::yy::验证通过
::vy::V2.1.6验证通过
::zz::暂未复现
::oo::【V2.1.6

;日期
::DD::
y = %A_YYYY%/%A_MM%/%A_DD%
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

#s::

sleep, 1500
send {Tab}
send, 13050202
sleep, 200
send {Tab}
clipboard = xj1989614!
Send, ^v{Enter}
sleep, 300
send {Enter}
return

#g::
run oa.cnsuning.com

#b::
run www.baidu.com