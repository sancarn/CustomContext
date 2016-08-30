#SingleInstance, force
#IfWinActive ahk_exe explorer.exe
$RButton::
	send, {LButton}
	send, {RButton}
	menu,mymenu,add,AHK Script (.ahk)				,hAHK
	menu,mymenu,add,MapBasic Header (.def)			,hDEF
	menu,mymenu,add,MapBasic File (.mb)				,hMB
	menu,mymenu,add,MapBasic Project (.mbp)			,hMBP
	menu,mymenu,add,MapInfo Workspace (.wor)		,hWOR
	menu,mymenu,add,MapInfo Project (.mip)			,hMIP
	menu,mymenu,add,Ruby Script (.rb)				,hRB
	menu,mymenu,add,Macro Enabled Workbook (.xlsm)	,hXLSM
	MouseGetPos,x,y
	x := x + 250
	WinGetPos,,, desk_width, desk_height, Program Manager
	if (x > desk_width - 100) {
		x := desk_width - 400
	}
	
	menu,mymenu,Icon,AHK Script (.ahk),U:\Macros\_Developer Templates\Icons\AHK.png
	menu,mymenu,Icon,MapBasic Header (.def),U:\Macros\_Developer Templates\Icons\DEF.png
	menu,mymenu,Icon,MapBasic File (.mb),U:\Macros\_Developer Templates\Icons\MB.png
	menu,mymenu,Icon,MapBasic Project (.mbp),U:\Macros\_Developer Templates\Icons\MBP.png
	menu,mymenu,Icon,MapInfo Workspace (.wor),U:\Macros\_Developer Templates\Icons\WOR.png
	menu,mymenu,Icon,MapInfo Project (.mip),U:\Macros\_Developer Templates\Icons\MIP.png
	menu,mymenu,Icon,Ruby Script (.rb),U:\Macros\_Developer Templates\Icons\RB.png
	menu,mymenu,Icon,Macro Enabled Workbook (.xlsm),U:\Macros\_Developer Templates\Icons\XLSM.png
	
	
	; ---------------------------
	; CustomContext.ahk
	; ---------------------------
	; Error at line 21.
	; Line Text: Icon,AHK Script,U:\Macros\_Developer Templates\Icons\AHK.png,,0
	; Error: This line does not contain a recognized action.
	; The program will exit.
	; ---------------------------
	; OK   
	; ---------------------------

	
	menu,mymenu,show, %x%, %y%
return

hAHK:

return
hDEF:

return
hMB:

return
hMBP:

return
hWOR:

return
hMIP:

return
hRB:

return
hXLSM:

return


^RButton::
	;Select item
	send, {LButton}
	
	;Copy item to get path
	oldClip = ClipboardAll
	clipboard = 
	send, ^c
	path = clipboard
	clipboard = oldClip
	
	
	if (path = "") {
		;Right clicked in a folder/desktop
		openContext("inFolder")
		
	} else {
		If getPathType(clipboard) = "F" {
			;File selected
			extension := getExtension(path)
			openContext("file",extension)
		} else {
			;Folder selected
			openContext("folder")
		}
	}
return

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
