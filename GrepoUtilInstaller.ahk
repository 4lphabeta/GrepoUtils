splitString(string, delemiter){
   arr := []
   loop, parse, string, %delemiter%
   {
      arr[A_Index] := A_LoopField
   }
   return arr
}

DetectHiddenText, Off
SetTitleMatchMode, 2

WinGetText, out,A
word_array := splitString(out, " ")
path = % word_array[5]

path2 := RegExReplace(path, "(\n|\r)")

IfNotInString, path2, Downloads
{
	StringTrimRight, OutputVar, path, 7
	var1 = % OutputVar
	var2 = \GrepoUtils\
	DirSource = %var1%%var2%
	Script1 = % DirSource "GrepoUtil.ahk"
	Script := RegExReplace(Script1,"(\n|\r)")
	Logo1 = % DirSource "GrepoUtil.ico"
	Logo := RegExReplace(Logo1,"(\n|\r)")
	Shortcut1 = % DirSource "GrepoUtil.lnk"
	Shortcut := RegExReplace(Logo1,"(\n|\r)")

	StringTrimRight, OutputVar, A_Temp, 19
	VarAppData1 = % OutputVar "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
	VarAppData := RegExReplace(VarAppData1,"(\n|\r)") "\GrepoUtil.lnk"
}
else
{
	StringTrimRight, OutputVar, A_Temp, 19
	var1 = % OutputVar
	var2 = \Downloads\GrepoUtils\
	DirSource = %var1%%var2%
	Script1 = % DirSource "GrepoUtil.ahk"
	Script := RegExReplace(Script1,"(\n|\r)")
	Logo1 = % DirSource "GrepoUtil.ico"
	Logo := RegExReplace(Logo1,"(\n|\r)")
	Shortcut1 = % DirSource "GrepoUtil.lnk"
	Shortcut := RegExReplace(Logo1,"(\n|\r)")
	
	VarAppData1 = % OutputVar "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
	VarAppData := RegExReplace(VarAppData1,"(\n|\r)") "\GrepoUtil.lnk"
}

if not (FileExist("C:\Program Files\GrepoUtils")) {
	FileCreateDir, C:\Program Files\GrepoUtils

Sleep 500

FileCopy, % Logo, C:\Program Files\GrepoUtils, 1
FileCopy, % Script, C:\Program Files\GrepoUtils, 1
FileCreateShortcut, C:\Program Files\GrepoUtils\GrepoUtil.ahk, % VarAppData , C:\Program Files\GrepoUtils, , , C:\Program Files\GrepoUtils\GrepoUtil.ico, , , 1

Sleep 100

MsgBox, 4,, Would you like to run the program now? (press Yes or No)
IfMsgBox Yes
    Run, C:\Program Files\GrepoUtils\GrepoUtil.ahk

MsgBox Done