; ######## SETTINGS ########
#IfWinActive ahk_exe opera.exe
^Esc:: ExitApp

; ######## FUNCTIONS ########

CollectResources(qty, opt){
	If (opt = 1) {				;10 mins
		collect := "1050, 835"
	}
	Else If (opt = 2) {			;40 mins
		collect := "1210, 835"
	}
	Else If (opt = 3) {			;3 hours
		MsgBox, % 4+48+256+4096, , Are you sure you want to collect the 3 hour option? (press Yes or No)
		IfMsgBox Yes
			collect := "1375, 835"
		Else
			Return	;Don't collect
	}
	Else If (opt = 4) {			;8 hours
		MsgBox, % 4+48+256+4096, , Are you sure you want to collect the 8 hour option? (press Yes or No)
		IfMsgBox Yes
			collect := "1535, 835"
		Else
			Return	;Don't collect
	}
	
	Loop, %qty% {
		Click %collect%	;Collect resources
		Sleep 30
		Click 1122, 543	;Next farm
		Sleep 60
	}
	
	If (Qty != 1) {
		Click 1659, 501	;Close farm popup
	}
}

; ### MAIN ###

^DOWN::		;Ctrl+DArrow - Print cursor coords
	
	;FileAppend, X%xpos% Y%ypos%.`n, test.txt
	clipboard = %xpos%, %ypos%
	msgbox X%xpos%, Y%ypos%
	Return

^RIGHT::	;Ctrl+RArrow - Collect single, 10m
	CollectResources(1, 1)
	Return
	
^Numpad1::	;Ctrl+Num1 - Collect all, 10m
	CollectResources(6, 1)
	Return
	
^Numpad2::	;Ctrl+Num2 - Collect all, 40m
	CollectResources(6, 2)
	Return

^Numpad3::	;Ctrl+Num3 - Collect all, 3h
	CollectResources(6, 3)
	Return
	
^Numpad4::	;Ctrl+Num4 - Collect all, 8h
	CollectResources(6, 4)
	Return
	
!x::	;Switch to Island View
	MouseGetPos, xpos, ypos 
	Click 100, 130
	DllCall("SetCursorPos", "int", xpos, "int", ypos)
	Return
	
!c::	;Switch to City View
	MouseGetPos, xpos, ypos 
	Click 135, 130
	DllCall("SetCursorPos", "int", xpos, "int", ypos)
	Return
