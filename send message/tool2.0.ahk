; Version: 1.0
; Author: Sword
; Date: 2013/4/3

;������������������ʾ
;TrayTip, ��ʾ, ����������, 6, 1
	TrayTip, ��ʾ, F8: ��ʼ  F9: ��ͣ  F10: �˳�, 6, 1

;�����������������ͣ��ʾ
	Menu, Tray, Tip, ˵��`nF8: ��ʼ  F9: ��ͣ  F10: �˳�	

;���봰��
	InputBox, UserInput, ����, ������Ҫ���͵���Ŀ���� , , 220,130, , , ,1000 , 100
	If ErrorLevel
		Exitapp
	If UserInput=
		UserInput =100

;���ߴ�����ͣ״̬
	Pause

;F10 �رչ���
	F10:: ExitApp

;����������봰���Ƿ񼤻�
	#ifwinactive, ahk_class QWidget

;��ͣ
	F9:: Pause

;�_ʼ
	F8::

;����ѭ��
	loop
	{
		If a_index > %UserInput%
        		break
		A+=1
		Send, Mes_%A%
		Sleep, 1
		Send,	{Enter}{Enter}

	;��ʧ���ں���ͣ
		Ifwinnotactive, ahk_class QWidget
		Pause
}
