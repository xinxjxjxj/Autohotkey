; Version: 0.9
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
		B=
			Random,co1,97,122
			B :=Chr(co1)
		C=
			Random,co1,97,122
			C :=Chr(co1)
		D=
			Random,co1,97,122
			D :=Chr(co1)
		E=
			Random,co1,97,122
			E :=Chr(co1)
		F=
			Random,co1,97,122
			F :=Chr(co1)
		G=
			Random,co1,97,122
			G :=Chr(co1)
		H=
			Random,co1,97,122
			H :=Chr(co1)
		I=
			Random,co1,97,122
			I :=Chr(co1)
		J=
			Random,co1,33,126
			J :=Chr(co1)
		K=
			Random,co1,33,126
			K :=Chr(co1)

		Send, %A%.%B%%C%%D%%E%%F%%G%%H%%I%%J%%K%1{Space}
			Sleep, 200
		Send,	{Enter}
		Sleep, 800

	;��ʧ���ں���ͣ
		Ifwinnotactive, ahk_class QWidget
		Pause
}

#ifwinactive
