#Region ;**** ���������� ACNWrapper_GUI ****
#PRE_Icon=N:\����\QQ\3D���ICOͼ��\photoshopB.ico
#PRE_Outfile=C:\Users\chtyfox\Desktop\tutkp2p��⹤��.exe
#PRE_Compression=4
#PRE_UseUpx=n
#PRE_Res_Comment=tutkp2p
#PRE_Res_Description=tutkp2p
#PRE_Res_Fileversion=2.0.0.3
#PRE_Res_Fileversion_AutoIncrement=p
#PRE_Res_LegalCopyright=tutkp2p
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#Region ACNԤ�����������(���ò���)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;�Զ�����Դ��
;#PRE_Run_Tidy=                   				;�ű�����
;#PRE_Run_Obfuscator=      						;�����Ի�
;#PRE_Run_AU3Check= 							;�﷨���
;#PRE_Run_Before= 								;����ǰ
;#PRE_Run_After=								;���к�
;#PRE_UseX64=n									;ʹ��64λ������
;#PRE_Compile_Both								;����˫ƽ̨����
#EndRegion ACNԤ������������������
#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

 Au3 �汾: 
 �ű�����: 
 �����ʼ�: 
	QQ/TM: 
 �ű��汾: 
 �ű�����: 

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("TUTK UID���״̬", 467, 318, 192, 145)
$Input1 = GUICtrlCreateInput("", 8, 40, 449, 21)
$UID = GUICtrlCreateLabel("������UID", 8, 8, 60, 17)
$Button1 = GUICtrlCreateButton("��ʾUID״̬", 328, 280, 129, 30,$WS_GROUP)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
$Group1 = GUICtrlCreateGroup("��ʾ", 8, 80, 449, 193)
$Label1 = GUICtrlCreateLabel("", 16, 96, 436, 172)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
Local $HQ ,$BQ = "��ȴ�����ȡTUTK UID״̬��..........." 

Opt("TrayMenuMode", 1)

Example()

Func Example()
	Local $iExit = TrayCreateItem("�˳�")
	TraySetState(1) ; Show the tray menu.

	While 1
		Switch TrayGetMsg()
			Case $iExit ; Exit the loop.
				tc()
				Exit
		EndSwitch
	WEnd
EndFunc   ;==>Example

While 1
	$msg = GUIGetMsg()
  Select 
	Case $msg =  $GUI_EVENT_CLOSE
			tc()
			Exit	
		Case $msg = $Button1
			GUICtrlSetData ($Label1, $BQ)
			RunWait(@ComSpec & ' /c ' & @ScriptDir & '\tutkp2p.exe ' & GUICtrlRead($Input1) & ">" & @ScriptDir & '"\tutkp2p.txt"', '', @SW_HIDE)
			line()
			wj()
	EndSelect
WEnd



Func tutkp2p()
$HQ0 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ1", "")
$HQ1 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ2", "")
$HQ2 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ3", "")
$HQ3 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ4", "")
$HQ4 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ5", "")
$HQ5 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ6", "")
$HQ6 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ7", "")
$HQ7 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ8", "")
$HQ8 = IniRead(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ9", "")

$HQ = $HQ0 & @CR & $HQ1 & @CR & $HQ2 & @CR & $HQ3 & @CR & $HQ4 & @CR & $HQ5 & @CR & $HQ6 & @CR & $HQ7 & @CR & $HQ8
EndFunc

Func line()
Local $file = FileOpen(@ScriptDir &"\tutkp2p.txt", 0)
Local $j = 1
Local $i = 1
Do
if $j<=10 Then
    Local $line = FileReadLine($file,$j)
	IniWrite(@ScriptDir & "\tutkp2p.ini", "�ַ�", "��ȡ" & $i ,$line)
	$j = $j + 1 
EndIf
   $i = $i + 1
Until $i = 10
FileClose($file)
FileDelete(@ScriptDir & "\tutkp2p.txt")
EndFunc

Func tc()
	ProcessClose ("cmd.exe")
	ProcessClose ("tutkp2p.exe")
EndFunc	

Func wj()
	If FileExists("tutkp2p.ini") Then
		tc()
		tutkp2p()
		GUICtrlSetData ($Label1, $HQ)
		FileDelete(@ScriptDir & "\tutkp2p.ini")
	Else
		MsgBox(1,"TUTK UID���״̬","��ȡTUTK UID���״̬���ɹ�" & @CRLF & "�����µ����ȡTUTK UID״̬��ť")
EndIf
EndFunc