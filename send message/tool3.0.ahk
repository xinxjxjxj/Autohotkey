; Version: 3.0
; Author: Sword
; Date: 2013/7/2

;�����������������ͣ��ʾ
Menu, Tray, Tip, ˵��`nF8: ��ʼ  F9: ��ͣ  F10: �˳�

;��������������
Gui, font, S8, Verdana
Gui, Add, Text, x10 y10 w100 h20 Right, ������Ϣ��Ŀ��
Gui, Add, Edit, x120 y10 w40 h20 Limit4 Number vUserInput, 100

Gui, Add, Text, x10 y40 w100 h20 Right, ���ʱ��(ms)��
Gui, Add, Edit, x120 y40 w40 h20 Limit4 Number vTime, 1

Gui, Add, Checkbox, x60 y65 AltSubmit vExitornot, ������ɺ��˳�

Gui, Add, Button, x10 y90 w80 h30 Default, ��ʼ
Gui, Add, Button, x110 y90 w80 h30, �ر�

Gui, Show, AutoSize, ����
return

;�ر�
GuiClose:
Button�ر�:
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
Button��ʼ:
	Gui, Submit ; �����û������ÿ���ؼ�������


	;���ߴ�����ͣ״̬
	Pause

	;F10 �رչ���
F10:: ExitApp

	;����������봰���Ƿ񼤻�
#IfWinActive, ahk_class QWidget

	;��ͣ
F9:: Pause

	;�_ʼ
F8::

	;����ѭ��
	Loop
	{
		;��鴰���Ƿ�Ϊ����״̬
		IfWinNotActive, ahk_class QWidget
			break

		A+=1
		Send, 	Mes_%A%
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

