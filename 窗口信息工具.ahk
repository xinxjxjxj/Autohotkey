#SingleInstance force 
Gui, Add, GroupBox, x2 y2 w200 h60 , 窗口信息  
Gui, Add, Text, x5 y19 w32 h14 , 标题:  
Gui, Add, Edit, x38 y17 w159 h18 ved1,  
Gui, Add, Text, x5 y39 w32 h14 , 类:  
Gui, Add, Edit, x38 y37 w159 h18 ved2,  
Gui, Add, GroupBox, x2 y62 w200 h78 , 鼠标指针下信息  
Gui, Add, Text, x7 y80 w45 h14 , 类别名:  
Gui, Add, Edit, x51 y78 w146 h17 ved3,  
Gui, Add, Text, x6 y98 w45 h14 , 文本:  
Gui, Add, Edit, x51 y97 w146 h17 ved4,  
Gui, Add, Text, x6 y117 w44 h15 , 颜色:  
Gui, Add, Edit, x51 y116 w146 h17 ved5,  
Gui, Add, GroupBox, x2 y140 w200 h57 , 鼠标坐标( X Y)  
Gui, Add, Text, x9 y158 w55 h15 , 整个屏幕:  
Gui, Add, Edit, x74 y156 w123 h18 ved6,  
Gui, Add, Text, x9 y177 w67 h15 , 激活窗口中:  
Gui, Add, Edit, x74 y176 w123 h18 ved7,  
Gui, Add, GroupBox, x2 y197 w200 h57 , 位置[左边x,顶边y,宽度w,高度h]  
Gui, Add, Text, x7 y214 w78 h15 , 激活窗口:  
Gui, Add, Edit, x85 y212 w113 h18 ved8,  
Gui, Add, Text, x7 y233 w78 h15 , 鼠标下控件:  
Gui, Add, Edit, x85 y231 w113 h18 ved9,  
Gui, Add, GroupBox, x2 y254 w200 h110 , 窗口文本[包含隐藏文本]  
Gui, Add, Edit, x4 y267 w195 h93 ved10,  
Gui, Add, Text, x7 y367 w198 h25 c0339E5 gUkl,热键:Ctrl+Win 或 鼠标中键 `n                     by 星雨朝霞  
; Generated using SmartGUI Creator 4.0  
Gui,+AlwaysOnTop  
Gui, Show, x0 y28 h393 w205, AHK 窗口信息工具  
Return  
ukl:  
    run,http://hi.baidu.com/yuan2xia  
Return  
~MButton::  
    Goto winpos  
Return  
~^LWin::  
    loop 
    { 
        GoSub winpos 
        sleep, 100 
    } 
Return  
~^rWin::  
    Goto winpos  
Return  
winpos:  
    CoordMode,mouse,Screen ;设置坐标模式为全屏  
    CoordMode,pixel,Screen ;设置坐标模式为全屏  
    DetectHiddenText, On ;探测隐藏的文本  
    MouseGetPos,sx,sy,win,class ;取鼠标下信息  
    ;取标题  
    WinGetTitle,title,ahk_id %win%  
    GuiControl,,ed1,%title%  
    ;窗口类  
    WinGetClass,winclass,ahk_id %win%  
    GuiControl,,ed2,ahk_class %winclass%  
    if class <>  
    {  
            ;控件类别名  
        GuiControl,,ed3,%class%  
        ;控件文本  
        ControlGetText,text,%class%,ahk_id %win%  
        GuiControl,,ed4,%text%  
        ;控件大小  
        ControlGetPos,ctrlx,ctrly,ctrlw,ctrlh,%class%,ahk_id %win%  
        GuiControl,,ed9,%ctrlx%,%ctrly%,%ctrlw%,%ctrlh%  
    }  
    Else  
    {  
            ;置空  
        GuiControl,,ed3,  
        GuiControl,,ed4,  
        GuiControl,,ed9,  
    }  
    ;颜色  
    PixelGetColor,mousecolor,%sx%,%sy%,RGB  
    GuiControl,,ed5,%mousecolor%  
    ;全屏坐标  
    GuiControl,,ed6,%sx%,%sy%  
    ;当前激活窗口内的鼠标坐标  
    CoordMode,mouse,relative ;置坐标模式为当前窗口  
    MouseGetPos,wx,wy  
    GuiControl,,ed7,%wx%,%wy%  
    ;当前窗口大小  
    WinGetPos,winx,winy,winw,winh,A  
    GuiControl,,ed8,%winx%,%winy%,%winw%,%winh%  
    ;窗口文本,  
    WinGetText,wintext,ahk_id %win%  
    GuiControl,,ed10,%wintext%  
Return  
GuiClose:  
ExitApp