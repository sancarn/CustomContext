#SingleInstance, force
; #IfWinActive ahk_exe explorer.exe	<-- this cannot be used, use "IfWinActive ahk_exe explorer.exe { ... }" instead
~RButton::
	If not WinActive("ahk_exe explorer.exe") {
		return
	}
	
	;Create mymenu
	menu,mymenu,add,AHK Script (.ahk)				,hAHK
	menu,mymenu,add,MapBasic Header (.def)			,hDEF
	menu,mymenu,add,MapBasic File (.mb)				,hMB
	menu,mymenu,add,MapBasic Project (.mbp)			,hMBP
	menu,mymenu,add,MapInfo Workspace (.wor)		,hWOR
	menu,mymenu,add,MapInfo Project (.mip)			,hMIP
	menu,mymenu,add,Ruby Script (.rb)				,hRB
	menu,mymenu,add,Macro Enabled Workbook (.xlsm)	,hXLSM
	menu,mymenu,add,Exit							,hExit
	
	menu,mymenu,Icon,AHK Script (.ahk),U:\Macros\_Developer Templates\Icons\AHK.png
	menu,mymenu,Icon,MapBasic Header (.def),U:\Macros\_Developer Templates\Icons\DEF.png
	menu,mymenu,Icon,MapBasic File (.mb),U:\Macros\_Developer Templates\Icons\MB.png
	menu,mymenu,Icon,MapBasic Project (.mbp),U:\Macros\_Developer Templates\Icons\MBP.png
	menu,mymenu,Icon,MapInfo Workspace (.wor),U:\Macros\_Developer Templates\Icons\WOR.png
	menu,mymenu,Icon,MapInfo Project (.mip),U:\Macros\_Developer Templates\Icons\MIP.png
	menu,mymenu,Icon,Ruby Script (.rb),U:\Macros\_Developer Templates\Icons\RB.png
	menu,mymenu,Icon,Macro Enabled Workbook (.xlsm),U:\Macros\_Developer Templates\Icons\XLSM_minor.png
	
	;Position context menu correctly
	CoordMode, Mouse, Screen
	MouseGetPos, Xpos, Ypos
	Xm := (Xpos + 350)
	Ym := Ypos
	ControlClick, x%Xpos% y%Ypos%,,, R
	CoordMode, Menu, Screen
	Menu, MyMenu, Show, %Xm%, %Ym%
return

hExit:
return

hAHK:
	t := "ahk"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return

hDEF:
	t := "def"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return

hMB:
	t := "mb"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return

hMBP:
	t := "mbp"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return

hWOR:
	t := "wor"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return

hMIP:
	t := "mip"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return

hRB:
	t := "rb"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return

hXLSM:
	t := "xlsm"
	FileSelectFile, OutputPath,16,MyFile.%t%,Where would you like to save the .%t% file?, %t% Scripts (*.%t%)
	FileCopy, U:\Macros\_Developer Templates\Template.%t%, %OutputPath%,1
return


;	^RButton::
;		;Select item
;		send, {LButton}
;		
;		;Copy item to get path
;		oldClip = ClipboardAll
;		clipboard = 
;		send, ^c
;		path = clipboard
;		clipboard = oldClip
;		
;		
;		if (path = "") {
;			;Right clicked in a folder/desktop
;			openContext("inFolder")
;			
;		} else {
;			If getPathType(clipboard) = "F" {
;				;File selected
;				extension := getExtension(path)
;				openContext("file",extension)
;			} else {
;				;Folder selected
;				openContext("folder")
;			}
;		}
;	return

;When this script gets sophisticated, we can add this.
;$RButton
;	send, {RButton}
;reutnr

#IfWinActive
alert(str){
	msgbox, %str%
	WinActivate, ahk_exe explorer.exe
}

getExtension(path){
	;InStrRev to find .
	FoundPos := InStr(path, ".",,0)
	if (FoundPos = 0) {
		returnStr := ""
	} else {
		returnStr := substr(path,FoundPos+1)
	}
	
	return returnStr
}


; Shorcut := .lnk

getPathType(FilePattern) {
	att := FileExist(FilePattern)
	return att = "" ? "" : InStr(att, "D") = 0 ? "F" : "D"	
}

getSelectionPath(){
	;Copy item to get path
	oldClip = ClipboardAll
	clipboard = 
	send, ^c
	path = clipboard
	clipboard = oldClip
	return path
}

openContext(type,extension = ""){

}

handleContext(path){


}
