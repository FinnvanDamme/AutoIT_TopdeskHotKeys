;~ ------------------------------------------------------------------
;~ Includes
;~ ------------------------------------------------------------------
#include <GUIConstants.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <IE.au3>
#include <Array.au3>

;~ ------------------------------------------------------------------
;~ Variables
;~ ------------------------------------------------------------------
$ObjectID = ""
$NAW = ""
$Baliedienst = ""
$Teldienst = ""
$loginnaamnetwerk = ""
$soortbinnenkomstID = ""
$soortmeldingID = ""
$impactID = ""
$UrgencyID = "U3: Gebruiker kan doorwerken"
$incident_domeinID = ""
$incident_specID = ""
$actie = ""
$verzoek = ""
$trtimetaken = ""
$afgemeld = "0"
$Url = ""
$omschrijving = ""
$operatorgroupid = ""
$majorincidentid = ""

$BtnHeight = 30
$BtnWidth = 130
$BtnSpacer = 2
Global $GUI
Global $iArray[20][1]
Global $aArray[20][1]
Global $ActiveGui
Global $fInterrupt
Global $Major
Global $hButton_1
Global $iniFile = @ScriptDir & "\incidents.ini"


If @ComputerName = "RC14711" Or @ComputerName = "RC15289" Then
   $dienst = "Balie"
Else
   $dienst = "Telefoon"
EndIf

;~ ------------------------------------------------------------------
;~ Script
;~ ------------------------------------------------------------------
;~ preIncident()
;~ MajorIncident()
;~ ------------------------------------------------------------------
;~ Functies
;~ ------------------------------------------------------------------

;~ Hier opent het menu en worden de variabelen voor de url gevuld.
;~ ------------------------------------------------------------------
Func preIncident()
	Global $iniFile = @ScriptDir & "\incidents.ini"
	Incident()
EndFunc

Func MajorIncident()
	$fInterrupt = 1
	$Major = 1
	GUIDelete($GUI)
	Global $iniFile = @ScriptDir & "\majorincidents.ini"
	Incident()
EndFunc

Func Incident()
	GUISetState()

	; Intercept Windows command messages with out own handler
	GUIRegisterMsg($WM_COMMAND, "_WM_COMMAND")

	Global $aArray = IniReadSectionNames($iniFile)

   If Not @error Then
		If $Major = 1 Then
		   $GUI = GUICreate("Hotkeys", $BtnWidth * 1, $aArray[0] * $BtnHeight + 30)
		Else
		   $GUI = GUICreate("Hotkeys", $BtnWidth * 1, $aArray[0] * $BtnHeight + 60)
		EndIf

		GUISetOnEvent($GUI_EVENT_CLOSE, "Cancel")

		Global $ActiveGui = $GUI
		Opt("GUICoordMode", 2)
		Opt("GUIOnEventMode", 1)

		For $i = 1 To $aArray[0]
			Global $iArray = IniReadSection($iniFile,$aArray[$i])
			GUICtrlCreateButton($aArray[$i], -1, -2 + $BtnSpacer, $BtnWidth, $BtnHeight)
			GUICtrlSetTip(-1, $iArray[1][1])
			GUICtrlSetOnEvent(-2, "ArrayToRequest")
		Next

		If Not $Major = 1 Then
			$hButton_1 = GUICtrlCreateButton("Koppel aan Major", -1, -2 + $BtnSpacer, $BtnWidth, $BtnHeight)
			GUICtrlSetOnEvent(-1, "MajorIncident")
		EndIf

		GUICtrlCreateButton("Cancel", -1, -2 + $BtnSpacer, $BtnWidth, $BtnHeight)
		GUICtrlSetOnEvent(-1, "Cancel")

		GUISetState(@SW_SHOW)

		For $i = 1 To 20
			If $Major = 1 Then
				ConsoleWrite("-Func 2 Running" & @CRLF)
			Else
				ConsoleWrite("-Func 1 Running" & @CRLF)
			EndIf
			 ; Look for the flag
			If _Interrupt_Sleep(20000) Then
				; The flag was set
				Switch $fInterrupt
					Case 1
						ConsoleWrite("!Func 1 interrrupted by Func 2" & @CRLF)
						$fInterrupt = 0
					Case 2
						ConsoleWrite("!Func 1 interrrupted by WM Command" & @CRLF)
						$fInterrupt = 0
				EndSwitch
				Return
			EndIf
			Sleep(100)
		Next

   Else
	  MsgBox(0,"Read Error",@error)
	  Cancel()
   EndIf

   ConsoleWrite("Incident Ended" & @CRLF)
EndFunc

 Func _WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
     ; The Func 2 button was pressed so set the flag
     If BitAND($wParam, 0x0000FFFF) = $hButton_1 Then $fInterrupt = 2
     Return $GUI_RUNDEFMSG
 EndFunc   ;==>_WM_COMMAND

 Func _Interrupt_Sleep($iDelay)
 	; Get a timestamp
 	Local $iBegin = TimerInit()
 	; And run a tight loop
 	Do
 		; Use a minimum Sleep (could also be a WinWaitActive with a short timeout)
 		Sleep(10)
 		; Look for the interrrupt
 		If $fInterrupt Then
 			; And return True immediately if set
 			Return True
 		EndIf
 	Until TimerDiff($iBegin) > $iDelay
 	; Return False if timed out and no interrupt was set
 	Return False
 EndFunc   ;==>_Interrupt_Sleep

Func Cancel()
   $fInterrupt = 1
   Sleep (20)
   GUIDelete($ActiveGui)
;~    HTTPRequest()
EndFunc

Func ArrayToRequest()
	ConsoleWrite(">>>>>>>>>>>> ArrayToRequest" & @CRLF)
   Global $fInterrupt = 1
;~    Global $fInterrupt2 = 1
;~    MsgBox(0,"debug","Request time")
   Opt("GUIOnEventMode", 0)
   Global $iArray = IniReadSection($iniFile, GUICtrlRead(@GUI_CtrlId))
;~    _ArrayDisplay($iArray)
   $Username = InputBox("Inlognaam", "Vul hier de inlognaam in", "", " M", 215, 150)

   $loginnaamnetwerk = $Username

	$omschrijving = $iArray[1][1]
	$verzoek = $iArray[2][1]
	$actie = $iArray[3][1]

	$soortmeldingid = $iArray[4][1]
	$soortbinnenkomstid = $dienst
	$impactid = $iArray[6][1]
	$Urgencyid = $iArray[7][1]

	$incident_domeinid = $iArray[8][1]
	$incident_specid = $iArray[9][1]
	$ObjectID = $iArray[10][1]
	$operatorgroupid = $iArray[11][1]

	$status = $iArray[12][1]
	$trtimetaken = $iArray[13][1]
	$afgemeld = $iArray[14][1]
	$majorincidentid = GUICtrlRead(@GUI_CtrlId)
	$Major = 0
	If $Username = "" Then
		MsgBox(48,"Fout", "Geen gebruikersnaam ingevuld" & @CRLF & "Probeer opnieuw")
		GUIDelete($ActiveGui)
	Else
		Call("runURL")
	EndIf

;~ 	HTTPRequest()
EndFunc


;~ Hier word de url gevuld en naar internet explorer gestuurd.
;~ ------------------------------------------------------------------
Func runURL()
	GUIDelete($ActiveGui)
	$sArray = IniReadSection(@ScriptDir & "\settings.ini","Server")
	$ServerAdres = $sArray[1][1]
;~ 	MsgBox(0,"Debug",$ServerAdres)
	If Not @error Then
		$Url = 	$ServerAdres & _ ; LIVE
			"&field0=verzoek&value0=" & $verzoek & _
			"&field1=actie&value1=" & $actie & _
			"&field2=afgemeld&value2=" & $afgemeld & _
			"&field3=trtimetaken&value3=" & $trtimetaken & _
			"&field4=korteomschrijving&value4=" & $omschrijving & _
			"&replacefield0=persoonid&searchfield0=loginnaamnetwerk&searchvalue0=" & $loginnaamnetwerk & _
			"&replacefield3=soortbinnenkomstid&searchfield3=naam&searchvalue3=" & $soortbinnenkomstid & _
			"&replacefield4=soortmeldingid&searchfield4=naam&searchvalue4=" & $soortmeldingid & _
			"&replacefield5=impactid&searchfield5=naam&searchvalue5=" & $impactid & _
			"&replacefield6=incident_specid&searchfield6=naam&searchvalue6=" & $incident_specid & _
			"&replacefield7=incident_domeinid&searchfield7=naam&searchvalue7=" & $incident_domeinid & _
			"&replacefield8=configuratieobjectid&searchfield8=ref_naam&searchvalue8=" & $ObjectID & _
			"&replacefield9=operatorgroupid&searchfield9=naam&searchvalue9=" & $operatorgroupid & _
			"&replacefield10=urgencyid&searchfield10=naam&searchvalue10=" & $UrgencyID & _
			"&replacefield11=majorincidentid&searchfield11=naam&searchvalue11=" & $majorincidentid
	Else
		MsgBox(0,"Error", "Kon settings.ini niet openen.")
	EndIf
	$oIE = _IECreate($Url, 0, 1, 0)
	_IELoadWait($oIE)
 EndFunc   ;==>runURL