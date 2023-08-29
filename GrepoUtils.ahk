; ######## SETTINGS ########
#SingleInstance Force
#installKeybdHook
#Persistent

Menu, Tray, NoStandard
Menu, Tray, Add, Hotkeys, Hotkeys
Menu, Tray, Add
Menu, Tray, Add, Restart, Restart
Menu, Tray, Add, Exit, QuitNow

DirSource = C:\Program Files\GrepoUtils\GrepoUtils.ico
I_Icon = % DirSource
ICON [I_Icon]
Menu, Tray, Icon , %I_Icon%
TrayTip, Grepolis Utils, Started, 1
Sleep 3000   ; Let it display for 1.5 seconds.
HideTrayTip()

Return

Hotkeys:
	Gui, Add, ListView, r6 w200, Utility|Shortcut
	
	LV_Add(Vis, "Collect Single 10m", "Ctrl + Right Arrow")
	LV_Add(Vis, "Collect All 10m", "Ctrl + Numpad 1")
	LV_Add(Vis, "Collect All 40m", "Ctrl + Numpad 2")
	LV_Add(Vis, "Collect All 3h", "Ctrl + Numpad 3")
	LV_Add(Vis, "Collect All 8h", "Ctrl + Numpad 4")
	LV_ModifyCol()  ; Auto-size each column to fit its contents.

	Gui, Show
Return

; ######## FUNCTIONS ########

Restart:
	Reload
Return

QuitNow:
	ExitApp
Return

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

CollectResources(qty, opt){
	If (opt = 1) {					; 10 mins
		collect := "1050, 835"		; CHANGE THESE COORDS - Hover over 10 min collect button
	}
	Else If (opt = 2) {				; 40 mins
		collect := "1210, 835"		; CHANGE THESE COORDS - Hover over 40 min collect button
	}
	Else If (opt = 3) {				; 3 hours
		MsgBox, % 4+48+256+4096, , Are you sure you want to collect the 3 hour option? (press Yes or No)
		IfMsgBox Yes
			collect := "1375, 835"	; CHANGE THESE COORDS - Hover over 3 hour collect button
		Else
			Return					; Don't collect
	}
	Else If (opt = 4) {				; 8 hours
		MsgBox, % 4+48+256+4096, , Are you sure you want to collect the 8 hour option? (press Yes or No)
		IfMsgBox Yes
			collect := "1535, 835"	; CHANGE THESE COORDS - Hover over 8 hour collect button
		Else
			Return					; Don't collect
	}
	
	Loop, %qty% {
		Click %collect%				; Collect resources
		Sleep 30
		Click 1122, 543				; CHANGE THESE COORDS - Hover over the next farm arrow button
		Sleep 60
	}
	
	If (Qty != 1) {
		Click 1659, 501				; CHANGE THESE COORDS - Hover over the close farm x button
	}
}

; ######## MAIN ########

^Esc:: ExitApp

FileRead, DefUser, C:\Program Files\GrepoUtils\UserDef.txt
Sleep 20
FileRead, DefCallback, C:\Program Files\GrepoUtils\CallbackDef.txt
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetKeyDelay, 20, 10

#IfWinActive ahk_exe opera.exe

^DOWN::		; Ctrl + DArrow - Print cursor coords
	clipboard = %xpos%, %ypos%
	msgbox X%xpos%, Y%ypos%
	Return

^RIGHT::	; Ctrl + RArrow - Collect Single | 10m
	CollectResources(1, 1)
	Return
	
^Numpad1::	; Ctrl + Numpad1 - Collect All | 10m
	CollectResources(6, 1)
	Return
	
^Numpad2::	; Ctrl + Numpad2 - Collect All | 40m
	CollectResources(6, 2)
	Return

^Numpad3::	; Ctrl + Numpad3 - Collect All | 3h
	CollectResources(6, 3)
	Return
	
^Numpad4::	; Ctrl + Numpad4 - Collect All | 8h
	CollectResources(6, 4)
	Return
	
!x::	; Switch to Island View
	MouseGetPos, xpos, ypos 
	Click 100, 130		; CHANGE THESE COORDS - Hover over the Island View button
	DllCall("SetCursorPos", "int", xpos, "int", ypos)
	Return
	
!c::	; Switch to City View
	MouseGetPos, xpos, ypos 
	Click 135, 130		; CHANGE THESE COORDS - Hover over the City View button
	DllCall("SetCursorPos", "int", xpos, "int", ypos)
	Return
