; ###### RESTART AS ADMIN ######
if not (RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {		; Restarts the script with admin perms
	Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%",, UseErrorLevel
	ExitApp
}

; ############ MAIN ############

path = %a_scriptdir%								; Path to where the file has been run
path2 := RegExReplace(path, "(\n|\r)")				; A more solid path for specific use cases

DirSource = %path%\									; The current path with an added backslash
Script = % DirSource "GrepoUtils.ahk"				; The current path plus script file name
Logo = % DirSource "GrepoUtils.ico"					; The current path plus icon file name

VarAppData :=  A_DESKTOP "\GrepoUtils.lnk"			; The path to the user's Desktop with the shortcut file name

if not (FileExist("C:\Program Files\GrepoUtils")) {	; If the C: drive location doesn't exist, make it
	FileCreateDir, C:\Program Files\GrepoUtils		; Create the directory
}

Sleep 500

FileCopy, % Logo, C:\Program Files\GrepoUtils, 1		; Copies the icon across, overwrites
FileCopy, % Script, C:\Program Files\GrepoUtils, 1		; Copies the main ahk across, overwrites
FileCreateShortcut, C:\Program Files\GrepoUtils\GrepoUtils.ahk, % VarAppData , C:\Program Files\GrepoUtils, , 
, C:\Program Files\GrepoUtils\GrepoUtils.ico, , , 1		; Creates a desktop shortcut, overwrites

Sleep 100

MsgBox, 4,, Would you like to run the program now? (press Yes or No)
IfMsgBox Yes
    Run, C:\Program Files\GrepoUtils\GrepoUtils.ahk

MsgBox Done