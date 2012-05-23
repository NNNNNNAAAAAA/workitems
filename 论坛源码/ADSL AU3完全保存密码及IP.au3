#region ACN预处理程序参数(常用参数)
#PRE_Icon= 										;图标,支持EXE,DLL,ICO
#PRE_OutFile=									;输出文件名
#PRE_OutFile_Type=exe							;文件类型
#PRE_Compression=4								;压缩等级
#PRE_UseUpx=y 									;使用压缩
#PRE_Res_Comment= 								;程序注释
#PRE_Res_Description=							;详细信息
#PRE_Res_Fileversion=							;文件版本
#PRE_Res_FileVersion_AutoIncrement=p			;自动更新版本
#PRE_Res_LegalCopyright= 						;版权
#PRE_Change2CUI=N                   			;修改输出的程序为CUI(控制台程序)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#PRE_Run_Tidy=                   				;脚本整理
;#PRE_Run_Obfuscator=      						;代码迷惑
;#PRE_Run_AU3Check= 							;语法检查
;#PRE_Run_Before= 								;运行前
;#PRE_Run_After=								;运行后
;#PRE_UseX64=n									;使用64位解释器
;#PRE_Compile_Both								;进行双平台编译
#endregion ACN预处理程序参数(常用参数)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	
	Au3 版本:
	脚本作者:
	电子邮件:
	QQ/TM:
	脚本版本:
	脚本功能:
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#include <GUIConstants.au3>
Global Const $POLICY_GET_PRIVATE_INFORMATION = 4
If Not IsDeclared("ERROR_INVALID_SID") Then Global Const $ERROR_INVALID_SID = 1337
Global Const $tagLSAUNICODE = "ushort Length;ushort MaxLength;ptr Wbuffer"
Global Const $tagLSAOBJATTR = "ulong Length;hWnd RootDir;ptr objName;ulong Attr;ptr SecurDescr;ptr SecurQuality"
$hGUI = GUICreate("获取帐号密码", 180, 50, -1, -1)
$Button1 = GUICtrlCreateButton("获取帐号密码及网卡IP", 15, 15, 150, 25, 0)
GUISetState() ;显示GUI界面
While 1
	$nMsg = GUIGetMsg()
	Select
		Case $nMsg = $GUI_EVENT_CLOSE

			Exit
		Case $nMsg = $Button1
			_SetAdsl()
	EndSelect
WEnd

Func _SetAdsl() ;获取宽带密码及网卡IP
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", " " & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", "============================================================" & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", " " & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", "  * 本机ADSL宽带帐号及密码信息:" & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", " " & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", "" & _FINDADSL() & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", " " & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", "------------------------------------------------------------" & @CRLF)
;~ 	RunWait(@ComSpec & " /c " & "ipconfig /all >> D:\本机宽带密码和网卡IP.txt", "", 0)
;~ 	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", @CRLF)
;~ 	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", "============================================================" & @CRLF)
	FileWrite(@ScriptDir & "\本机宽带密码和网卡IP.txt", "  * 本信息生成时间：" & @YEAR & "年" & @MON & "月" & @MDAY & "日" & @HOUR & "点" & @MIN & "分" & @SEC & "秒" & @CRLF)
	Run("Notepad.exe" & @ScriptDir & "\本机宽带密码和网卡IP.txt")
EndFunc   ;==>_SetAdsl


Func _FINDADSL()
	Dim $pSid = _LookupAccountName(@UserName) ; 获取用户SID指针。
	Dim $sSid = _ConvertSidToStringSid($pSid) ; 转换为字符型SID。
	_HeapFree($pSid)
	Dim $bData = _LsaRetrievePrivateData("RasDialParams!" & $sSid & "#0")
	$iSize = @extended
	If $bData <> "" Then
		Return _ADSL($iSize, $bData)
	Else
		$bData = _LsaRetrievePrivateData("L$_RasDefaultCredentials#0")
		$iSize = @extended
		If $bData <> "" Then
			Return _ADSL($iSize, $bData)
		EndIf
	EndIf
EndFunc   ;==>_FINDADSL
Func _ADSL($iSize, $bData)
	Dim $tB = DllStructCreate("byte[" & $iSize & "]")
	Dim $pB = DllStructGetPtr($tB)
	Dim $tW = DllStructCreate("wchar[" & $iSize / 2 & "]", $pB)
	DllStructSetData($tB, 1, $bData)
	Dim $sR = ""
	For $i = 1 To $iSize / 2
		Dim $sC = DllStructGetData($tW, 1, $i)
		If $sC = Chr(0) And StringRight($sR, 1) <> " " Then $sR &= " "
		If $sC <> Chr(0) Then $sR &= $sC
	Next
	Dim $ADSJ = StringSplit($sR, " ", 1)
	If $ADSJ[4] <> "" And $ADSJ[5] <> "" Then
		Return "         宽带帐号                         : " & $ADSJ[4] & @CRLF & @CRLF & "         宽带密码                         : " & $ADSJ[5]
	Else
		Return "获取失败，请重试！"
	EndIf
EndFunc   ;==>_ADSL
Func _LookupAccountName($sName, $sSystem = "")
	Local $iResult, $pSid, $pDomain, $iSysError
	$iResult = DllCall("Advapi32.dll", "int", "LookupAccountName", _
			"str", $sSystem, "str", $sName, "ptr", 0, "int*", 0, _
			"ptr", 0, "int*", 0, "int*", 0)
	$pSid = _HeapAlloc($iResult[4])
	$pDomain = _HeapAlloc($iResult[6])
	$iResult = DllCall("Advapi32.dll", "int", "LookupAccountName", _
			"str", $sSystem, "str", $sName, _
			"ptr", $pSid, "int*", $iResult[4], _
			"ptr", $pDomain, "int*", $iResult[6], "int*", 0)
	$iSysError = _GetLastError()
	_HeapFree($pDomain)
	Return SetError($iSysError, $iResult[7], $pSid)
EndFunc   ;==>_LookupAccountName
Func _ConvertSidToStringSid($pSid)
	Local $iResult, $tBuffer, $iSysError, $sResult
	If Not _IsValidSid($pSid) Then Return SetError(@error, 0, "")
	$iResult = DllCall("Advapi32.dll", "int", "ConvertSidToStringSid", _
			"ptr", $pSid, "ptr*", 0)
	If $iResult[0] = 0 Then $iSysError = _GetLastError()
	If $iResult[2] = 0 Then Return SetError($iSysError, 0, "")
	$tBuffer = DllStructCreate("char[256]", $iResult[2])
	$sResult = DllStructGetData($tBuffer, 1)
	_LsaLocalFree($iResult[2])
	Return SetError($iSysError, _FreeVariable($tBuffer), $sResult)
EndFunc   ;==>_ConvertSidToStringSid
Func _LsaRetrievePrivateData($sKeyName, $sSystem = "")
	Local $hPolicy, $iResult, $pKeyName, $bData, $iSize, $tBuffer
	$hPolicy = _LsaOpenPolicy($POLICY_GET_PRIVATE_INFORMATION, $sSystem)
	If $hPolicy = 0 Then Return SetError(@error, 0, 0)
	$pKeyName = _LsaInitializeBufferW($sKeyName)
	$iResult = DllCall("Advapi32.dll", "dword", "LsaRetrievePrivateData", _
			"hWnd", $hPolicy, "ptr", $pKeyName, "ptr*", 0)
	$iSize = _LsaLocalSize($iResult[3]) - 12
	$tBuffer = DllStructCreate("byte[" & $iSize & "]", $iResult[3] + 12)
	$bData = DllStructGetData($tBuffer, 1)
	_LsaClose($hPolicy)
	_FreeVariable($tBuffer)
	_HeapFree($pKeyName)
	_LsaFreeMemory($iResult[3])
	Return SetError(_LsaNtStatusToWinError($iResult[0]), $iSize, $bData)
EndFunc   ;==>_LsaRetrievePrivateData
Func _HeapAlloc($iSize, $iAllocOption = 8)
	If $iSize < 1 Then Return 0
	Local $pMem, $hHeap = _GetProcessHeap()
	$pMem = DllCall("Kernel32.dll", "ptr", "HeapAlloc", "hWnd", $hHeap, _
			"dword", $iAllocOption, "dword", $iSize)
	Return $pMem[0]
EndFunc   ;==>_HeapAlloc
Func _GetLastError()
	Local $iSysError = DllCall("Kernel32.dll", "long", "GetLastError")
	Return $iSysError[0]
EndFunc   ;==>_GetLastError
Func _IsValidSid($pSid)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "int", "IsValidSid", "ptr", $pSid)
	If $iResult[0] Then Return SetError(0, 0, True)
	Return SetError($ERROR_INVALID_SID, 0, False)
EndFunc   ;==>_IsValidSid
Func _LsaOpenPolicy($iAccessMask, $sSystem = "")
	Local $hPolicy, $tSystem, $pSystem, $iLength
	Local $tObjAttr, $pObjAttr, $tName, $pName
	If $sSystem <> "" Then
		$iLength = StringLen($sSystem) * 2
		$tSystem = DllStructCreate($tagLSAUNICODE)
		$pSystem = DllStructGetPtr($tSystem)
		$tName = DllStructCreate("wchar[" & $iLength & "]")
		$pName = DllStructGetPtr($tName)
		DllStructSetData($tName, 1, $sSystem)
		DllStructSetData($tSystem, "Length", $iLength)
		DllStructSetData($tSystem, "MaxLength", $iLength + 2)
		DllStructSetData($tSystem, "Wbuffer", $pName)
	EndIf
	$tObjAttr = DllStructCreate($tagLSAOBJATTR)
	$pObjAttr = DllStructGetPtr($tObjAttr)
	$hPolicy = DllCall("Advapi32.dll", "dword", "LsaOpenPolicy", _
			"ptr", $pSystem, "ptr", $pObjAttr, _
			"dword", $iAccessMask, "hWnd*", 0)
	_FreeVariable($tName)
	_FreeVariable($tObjAttr)
	_FreeVariable($tSystem)
	Return SetError(_LsaNtStatusToWinError($hPolicy[0]), 0, $hPolicy[4])
EndFunc   ;==>_LsaOpenPolicy
Func _HeapFree($pMem)
	If $pMem < 1 Then Return SetError(87, 0, False)
	Local $iResult, $hHeap = _GetProcessHeap()
	$iResult = DllCall("Kernel32.dll", "int", "HeapFree", "hWnd", $hHeap, _
			"dword", 0, "ptr", $pMem)
	Return $iResult[0] <> 0
EndFunc   ;==>_HeapFree
Func _LsaLocalFree($pMem)
	Local $iResult
	$iResult = DllCall("Kernel32.dll", "int", "LocalFree", "ptr", $pMem)
	Return $iResult[0] <> $pMem
EndFunc   ;==>_LsaLocalFree
Func _FreeVariable(ByRef $vVariable)
	$vVariable = 0
EndFunc   ;==>_FreeVariable
Func _LsaInitializeBufferW($sData, $fDecode = False)
	Local $pMem, $iLength, $tBuffer, $sResult
	If $fDecode = False Then
		$iLength = StringLen($sData) * 2 + 2
		$pMem = _HeapAlloc($iLength + 8)
		$tBuffer = DllStructCreate($tagLSAUNICODE & ";wchar Data[" & $iLength - 2 & "]", $pMem)
		DllStructSetData($tBuffer, "Length", $iLength - 2)
		DllStructSetData($tBuffer, "MaxLength", $iLength)
		DllStructSetData($tBuffer, "Wbuffer", $pMem + 8)
		DllStructSetData($tBuffer, "Data", $sData)
		Return $pMem
	ElseIf Not IsPtr($sData) Then
		Return ""
	EndIf
	$tBuffer = DllStructCreate($tagLSAUNICODE, $sData)
	$iLength = DllStructGetData($tBuffer, "MaxLength") * 2
	If $iLength < 1 Then Return ""
	$pMem = DllStructCreate("wchar Data[" & $iLength & "]", DllStructGetData($tBuffer, "Wbuffer"))
	$sResult = DllStructGetData($pMem, "Data")
	Return SetExtended(_FreeVariable($pMem), $sResult)
EndFunc   ;==>_LsaInitializeBufferW
Func _LsaLocalSize($pMem)
	Local $iSize = DllCall("Kernel32.dll", "long", "LocalSize", "ptr", $pMem)
	Return $iSize[0]
EndFunc   ;==>_LsaLocalSize
Func _LsaCloseServiceHandle($hService)
	Local $iResult = DllCall("Advapi32.dll", "int", "CloseServiceHandle", "hWnd", $hService)
	Return SetError(_GetLastError(), 0, $iResult[0] <> 0)
EndFunc   ;==>_LsaCloseServiceHandle
Func _LsaCloseHandle($hHandle)
	Local $iResult = DllCall("Kernel32.dll", "int", "CloseHandle", "long", $hHandle)
	Return $iResult[0] <> 0
EndFunc   ;==>_LsaCloseHandle
Func _LsaClose($hPolicy)
	Local $iResult
	$iResult = DllCall("Advapi32.dll", "dword", "LsaClose", "hWnd", $hPolicy)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult = 0)
EndFunc   ;==>_LsaClose
Func _LsaFreeMemory($pMem)
	Local $iResult = DllCall("Advapi32.dll", "dword", "LsaFreeMemory", "ptr", $pMem)
	Return SetError(_LsaNtStatusToWinError($iResult[0]), 0, $iResult[0] = 0)
EndFunc   ;==>_LsaFreeMemory
Func _LsaNtStatusToWinError($iNtStatus)
	Local $iSysError
	$iSysError = DllCall("Advapi32.dll", "ulong", "LsaNtStatusToWinError", "dword", $iNtStatus)
	Return $iSysError[0]
EndFunc   ;==>_LsaNtStatusToWinError
Func _GetProcessHeap()
	Local $hHeap = DllCall("Kernel32.dll", "hWnd", "GetProcessHeap")
	Return $hHeap[0]
EndFunc   ;==>_GetProcessHeap
