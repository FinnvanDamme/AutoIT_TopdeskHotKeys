#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_Icon=..\..\ico\Calculator.ico
#AutoIt3Wrapper_Compression=3
#AutoIt3Wrapper_Res_Fileversion=0.0.2.0
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 	v3.3.8.1
	Author:         	Finn van Damme
	Script Function:	Sneltoetsen voor Support, voor het starten van httprequests en gebruikers taken.

#ce ----------------------------------------------------------------------------

;~ ------------------------------------------------------------------
;~ Includes
;~ ------------------------------------------------------------------

#include "HTTP_requests.au3"
;~ ------------------------------------------------------------------
;~ Variables
;~ ------------------------------------------------------------------

;~ ------------------------------------------------------------------
;~ Script
;~ ------------------------------------------------------------------

;~ Hotkey
;~ ------------------------------------------------------------------
HotKeySet("{F3}", "preIncident") ; Open GUI.

;~ /-----------------------------------------------------------------

;~ Loop
;~ ------------------------------------------------------------------
While 1
	Sleep(1000)
	If FileExists(@ScriptDir & "\Kill.txt") Then
		MsgBox(0, "AutoKilled", "Update tijd!! De administrator heeft Hotkeys gesloten.", 3)
		Run("Check.exe")
		Exit 0
	EndIf
WEnd