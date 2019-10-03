#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\ico\au3.ico
#AutoIt3Wrapper_Outfile=Topdesk Hotkeys\check.exe
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
If FileExists(@ScriptDir & "\Kill.txt") Then
	TrayTip("AutoKilled", "Update tijd!! De administrator heeft Hotkeys gesloten.", 2)
	While 1
		If Not FileExists(@ScriptDir & "\Kill.txt") Then
			Run("Topdesk_Hotkeys.exe")
			TrayTip("Autostart", "Hotkeys is weer gestart", 3)
			Sleep(3000)
			Exit
		EndIf
		Sleep(10000)
	WEnd
Else
	If ProcessExists("Topdesk_Hotkeys.exe") Then
		MsgBox(0, "Warning", "Hotkeys is already running! Quiting....")
		Exit 0
	Else
		Run("Topdesk_Hotkeys.exe")
	EndIf
EndIf

