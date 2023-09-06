; ; ###### RESTART AS ADMIN ######
; if not (RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {		; Restarts the script with admin perms
; 	Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%",, UseErrorLevel
; 	ExitApp
; }

; ######## SETTINGS ########
#SingleInstance Force
#installKeybdHook
#Persistent

Menu, Tray, NoStandard
Menu, Tray, Add, Hotkeys, Hotkeys
Menu, Tray, Add

; Future submenu options
Menu, Submenu1, Add, Wait Time Before Next Farm, AltWait1
Menu, Submenu1, Add, Wait Time Before Collect, AltWait2
Menu, Submenu1, Add
Menu, Submenu1, Add, Collect 10m Position, AltCollect10
Menu, Submenu1, Add, Collect 40m Position, AltCollect40
Menu, Submenu1, Add, Collect 3h Position, AltCollect3h
Menu, Submenu1, Add, Collect 8h Position, AltCollect8h
Menu, Submenu1, Add
Menu, Submenu1, Add, Next Farm Position, AltNextFarm
Menu, Submenu1, Add, Close Button Position, AltClose
Menu, Submenu1, Add
Menu, Submenu1, Add, Island View Position, AltIslandView
Menu, Submenu1, Add, City View Position, AltCityView

; Create a submenu in the first menu
Menu, Tray, Add, Set Defaults, :Submenu1

Menu, Tray, Add
Menu, Tray, Add, Open File Location, OpenScriptLocation
Menu, Tray, Add, Open Default Values Location, OpenDefFilesLocation
Menu, Tray, Add
Menu, Tray, Add, Restart, Restart
Menu, Tray, Add, Exit, QuitNow

DirSource = %A_ProgramFiles%\GrepoUtils\
AppSource = %A_AppData%\GrepoUtils\
I_Icon := DirSource "GrepoUtils.ico"
Menu, Tray, Icon , %I_Icon%
TrayTip, Grepolis Utils, Started, 1
Sleep 2500   ; Let it display for 2.5 seconds.

MyDict := { "WaitNextFarm":"Wait1Def", "WaitCollect":"Wait2Def", "Collect10":"Collect10Coord"
		, "Collect40":"Collect40Coord", "Collect3h":"Collect3hCoord", "Collect8h":"Collect8hCoord", "CloseCollection":"CloseCoord"
		, "IslandView":"IslandViewCoord", "CityView":"CityViewCoord", "NextFarm":"NextFarmCoord" }

For key, value in MyDict							; Key is variable name, value is filename.
{
	TempVar := key									; Store the key in a separate variable
	FileRead, TempVar, %AppSource%%value%.txt		; Use value from file
	%key% := TempVar
	If (!TempVar)
		MsgBox A value for %key% could not be found. Please set a default before use.
}

If (!WaitNextFarm), WaitNextFarm = 30				; Value not found - Use default 30ms
If (!WaitCollect), WaitCollect = 60					; Value not found - Use default 60ms

Sleep 20
HideTrayTip()

Return

Hotkeys:
	Gui, Add, ListView, r7 w220, Utility|Shortcut
	
	LV_Add(Vis, "Copy Mouse Position", "Ctrl + Down Arrow")
	LV_Add(Vis, "Collect Single 10m", "Ctrl + Right Arrow")
	LV_Add(Vis, "Collect All 10m", "Ctrl + Numpad 1")
	LV_Add(Vis, "Collect All 40m", "Ctrl + Numpad 2")
	LV_Add(Vis, "Collect All 3h", "Ctrl + Numpad 3")
	LV_Add(Vis, "Collect All 8h", "Ctrl + Numpad 4")
	LV_ModifyCol()  ; Auto-size each column to fit its contents.

	Gui, Show
Return

; ######## FUNCTIONS ########

OpenScriptLocation:
	Run, explore %A_ProgramFiles%\GrepoUtils
Return

OpenDefFilesLocation:
	Run, explore %A_AppData%\GrepoUtils
Return

Restart:
	Reload
Return

QuitNow:
	ExitApp
Return

AltWait1:
	InputBox, WaitNextFarm, Change Default Wait Time 1, Enter the time to wait before moving to the next farm (Recommended 30ms):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(WaitNextFarm, "Wait1Def")
Return

AltWait2:
	InputBox, WaitCollect, Change Default Wait Time 2, Enter the time to wait before moving to the next farm (Recommended 60ms):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(WaitCollect, "Wait2Def")
Return

AltCollect10:
	InputBox, Collect10, Set Collection Position 1, Enter the coordinates of the first collect option (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(Collect10, "Collect10Coord")
Return

AltCollect40:
	InputBox, Collect40, Set Collection Position 2, Enter the coordinates of the second collect option (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(Collect40, "Collect40Coord")
Return

AltCollect3h:
	InputBox, Collect3h,  Set Collection Position 3, Enter the coordinates of the third collect option (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(Collect3h, "Collect3hCoord")
Return

AltCollect8h:
	InputBox, Collect8h, Set Collection Position 4, Enter the coordinates of the fourth collect option (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(Collect8h, "Collect8hCoord")
Return

AltNextFarm:
	InputBox, NextFarm, Set Next Farm Position, Enter the coordinates of the next farm arrow button (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(NextFarm, "NextFarmCoord")
Return

AltClose:
	InputBox, CloseCollection, Set Close Collection Position, Enter the coordinates of the close collection button (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(CloseCollection, "CloseCoord")
Return

AltIslandView:
	InputBox, IslandView, Set Island View Position, Enter the coordinates of the Island View button (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(IslandView, "IslandViewCoord")
Return

AltCityView:
	InputBox, CityView, Set City View Position, Enter the coordinates of the City View button (Use Ctrl + D Arrow):, ,275 ,150 , , , , , 
	CheckErrLvl()	; Error level if statement
	FileFuncs(CityView, "CityViewCoord")
Return

FileFuncs(varName, varFile){
	txtPath := A_AppData "\GrepoUtils\" varFile ".txt"
	FileDelete %txtPath%
	FileAppend, % varName, % txtPath
	FileRead, varName, % txtPath
}

HideTrayTip() {
    TrayTip  		; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

CheckErrLvl() {
	If (ErrorLevel != 0) {
		Exit	; Cancel was selected
	}
}

CollectResources(qty, opt){
	Global		; Allows use of outside variables
	If (opt = 1) {					; 10 mins
		Collect := Collect10
	}
	Else If (opt = 2) {				; 40 mins
		Collect := Collect40
	}
	Else If (opt = 3) {				; 3 hours
		MsgBox, % 4+48+256+4096, , Are you sure you want to collect the 3 hour option? (press Yes or No)
		IfMsgBox Yes
			Collect := Collect3h
		Else
			Return					; Don't collect
	}
	Else If (opt = 4) {				; 8 hours
		MsgBox, % 4+48+256+4096, , Are you sure you want to collect the 8 hour option? (press Yes or No)
		IfMsgBox Yes
			Collect := Collect8h
		Else
			Return					; Don't collect
	}
	
	Loop, %qty% {
		Click %Collect%				; Collect resources
		Sleep %WaitNextFarm%			; Wait before next farm - Default 30ms
		Click %NextFarm%				; Click next farm arrow
		Sleep %WaitCollect%			; Wait before collecting - Default 60ms
	}
	
	If (Qty != 1) {
		Click %CloseCollection%		; Close collection screen - x button
	}
}

; ######## MAIN ########

^Esc:: ExitApp

#IfWinActive ahk_exe opera.exe

^DOWN::		; Ctrl + DArrow - Print cursor coords
	MouseGetPos, xpos, ypos 
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
	
!x::		; Switch to Island View
	MouseGetPos, xpos, ypos 
	Click %IslandView%	; Click Island View
	DllCall("SetCursorPos", "int", xpos, "int", ypos)
	Return
	
!c::		; Switch to City View
	MouseGetPos, xpos, ypos 
	Click %CityView%	; Click City View
	DllCall("SetCursorPos", "int", xpos, "int", ypos)
	Return
