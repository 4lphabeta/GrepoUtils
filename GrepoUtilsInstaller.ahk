; ###### RESTART AS ADMIN ######
If Not (RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {
	Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%",, UseErrorLevel
	ExitApp
}

; ############ MAIN ############

ScriptName := "GrepoUtils.ahk"
IconName := "GrepoUtils.ico"

DirSource = %A_ScriptDir%\								; The current script path with an added backslash
msgbox %DirSource%
CurrScriptPath := DirSource ScriptName					; The current path plus script file name
msgbox %CurrScriptPath%
CurrLogoPath := DirSource IconName						; The current path plus icon file name

VarDesktop :=  A_DESKTOP "\GrepoUtils.lnk"				; The path to the user's Desktop with the shortcut file name

ProgramDestination := A_ProgramFiles "\GrepoUtils"		; C:\Program Files\GrepoUtils
msgbox %ProgramDestination%
AppdataDestination := A_AppData "\GrepoUtils"			; C:\Users\[USERNAME]\AppData\Roaming\GrepoUtils
msgbox %AppdataDestination%
FinalScriptPath := ProgramDestination "\" ScriptName	; C:\Program Files\GrepoUtils\GrepoUtils.ahk
msgbox %FinalScriptPath%
FinalIconPath := ProgramDestination "\" IconName		; C:\Program Files\GrepoUtils\GrepoUtils.ico
msgbox %FinalIconPath%

If Not (FileExist(ProgramDestination)) {			; If the C: drive location doesn't exist, make it
	FileCreateDir, % ProgramDestination				; Create the directory
}													; Github somehow loses this closing bracket

If Not (FileExist(AppdataDestination)) {			; If the appdata location doesn't exist, make it
	FileCreateDir, % AppdataDestination				; Create the directory
}		

Sleep 500

FileCopy, % CurrLogoPath, % ProgramDestination, 1			; Copies the icon across, overwrites
FileCopy, % CurrScriptPath, % ProgramDestination, 1			; Copies the main ahk across, overwrites
FileCreateShortcut, % FinalScriptPath, % VarDesktop , % ProgramDestination, , 
, % FinalIconPath, , , 1		; Creates a desktop shortcut with the icon, overwrites

Sleep 100

MsgBox, 4,, Would you like to run the program now? (press Yes or No)
IfMsgBox Yes
    Run, % FinalScriptPath

MsgBox Done