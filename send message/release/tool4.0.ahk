; Version: 0.9 ʵ�ַ��ŷ�����Ϣ�Ļ�������

; Version: 1.0 ������Ϣ�������䶹ѿ
; Author: Sword
; Date: 2013/4/3

; Version: 2.0 �����Ϣ���ɵ�ʵ�ַ�ʽ

; Version: 3.0 ������Ϣ������Զ��壬�����˷�������Զ��˳�

; Version: 4.0 ������Ϣ���ݿ��Զ���
; Author: Sword
; Date: 2015/11/25


;�����������������ͣ��ʾ
Menu, Tray, Tip, ˵��`nF8: ��ʼ  F9: ��ͣ  F10: �˳�

;��������������
Gui, font, S8, Verdana

Gui, Add, Text, x10 y10 w100 h20 Right, ��Ϣ���ͣ�
Gui, Add, Text, x10 y+5 w100 h20 Right, ��Ϣ��Ŀ��
Gui, Add, Text, x10 y+5 w100 h20 Right, ���ʱ�䣺
Gui, Add, Text, x10 y+5 w100 h20 Right, �Զ������֣�
Gui, Add, Text, x180 y62 w20 h20 Right, ms


;Gui, Add, DropDownList, x120 w60 h20 r2 AltSubmit vitem1 ym, Ĭ��||�Զ���
Gui, Add, Radio, x120 y10 checked1 vitem1, Ĭ��
Gui, Add, Radio, x170 y10 , �Զ���
Gui, Add, Edit, x120 y+8 w60 h20 Limit4 Number vUserInput Center, 50
Gui, Add, Edit, x120 y+7 w60 h20 Limit4 Number vTime Center, 10
Gui, Add, Edit, x120 y+6 w130 h20 Limit10 vtxt1, ����������
Gui, Add, Checkbox, x140 y+20 vExitornot , ��ɺ��˳�

Gui, Add, Button, x20 y115 w100 h30 Default , ׼��
;Gui, Add, Button, x180 y135 w60 h30 , �ر�

Gui, Show, AutoSize, ����
return

;�ر�
GuiClose:
;Button�ر�:
	{
		ExitApp
		return
	}
GuiSize:
	{
		if (A_EventInfo==1)          ;����ֻ����Դ�����С���¼��������ǽ��������̲���������
			Gui, Submit
		return
	}

;��ʼ��ť
Button׼��:
	Gui, Submit ; �����û������ÿ���ؼ�������

;	MsgBox, %item1%

	;���ߴ�����ͣ״̬
	Pause

	;F10 �رչ���
F10:: ExitApp

	;����������봰���Ƿ񼤻�
#IfWinActive, ahk_class Qt5QWindowIcon

	;��ͣ
F9:: Pause

	;�_ʼ
F8::

	;����ѭ��
	Loop
	{
		;��鴰���Ƿ�Ϊ����״̬
		IfWinNotActive, ahk_class Qt5QWindowIcon
			break

		A+=1
		if item1=1
			{
				Send, 	Mes_%A%
			}
		else{
				Send,	%txt1%
			}
		Send,	{Enter}{Enter}
		Sleep, 	%Time%

		;�Ƿ�ѡ����˳�
		if a_index >= %UserInput%
		{
			if %Exitornot%=0
				break
			else
				ExitApp
		}
	}

