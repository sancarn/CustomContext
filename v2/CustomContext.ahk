#SingleInstance, force
#Include CCLib\inDIRContextMenu.ahk
#Include CCLib\mmbClickMenu.ahk
#Include CCLib\fileContextMenu.ahk
#Include CCLib\folderContextMenu.ahk

$MButton::
	MouseGetPos, Xpos, YPos, WinID
	WinGet, WinExe, ProcessName, ahk_id %WinID%
	traytip, %WinExe%
	If not (WinExe ~= "i)Explorer.EXE") {	;~= shorthand for RegexMatch
		mmbContextMenu()
		Send, {MButton Down}
		return
	}
	
	;WinActivate, ahk_id %WinID%
	send, {LButton}
	altClipboard := ClipboardAll
	clipboard = 
	send, ^c
	path := clipboard
	clipboard := altClipboard
	
	;reset variables
	inDir =
	fileType =
	;Select correct context menu
	If (StrLen(path)>=260 OR path = "") {
		path := StrReplace(WindowsExplorerLocationByCOM(),"%20", " ")
		inDirContextMenu(path)
	} else {
		itemType := getPathType(path)
		if (itemType = "F") {
			fileContextMenu(path)
		} Else if (itemType = "D") {
			folderContextMenu(path)
		} Else {
			;Log Error?
			msgbox, an error occurred `nFile: %path% `n%itemType%
			reload
		}
	}
	
return

MButton Up::
	send, {MButton up}
return

hReload:
	reload
return

alert(str){
	msgbox, %str%
	WinActivate, ahk_exe explorer.exe
}

getExtension(path){			; USFUL TO REMEMBER Shorcut := .lnk
	;InStrRev to find .
	FoundPos := InStr(path, ".",,0)
	if (FoundPos = 0) {
		returnStr := ""
	} else {
		returnStr := substr(path,FoundPos+1)
	}
	
	return returnStr
}




getPathType(FilePattern) {
	att := FileExist(FilePattern)
	return att = "" ? "" : InStr(att, "D") = 0 ? "F" : "D"	
}

;-----------------------------------------------------------------------;
;			TYPES OF MENUS AND HANDLING			;
;-----------------------------------------------------------------------;

inDirContextMenu(path){
	Global bInDirContextMenu
	If (bInDirContextMenu = "True") {
		Menu, inDIRContextMenu,add,Reload Context Menu,hReload
		Menu, inDIRContextMenu, Show
	}
}

fileContextMenu(path){
	Global bFileContextMenu
	If (bFileContextMenu) {
		menu, fileContextMenu,add,Reload Context Menu,hReload
		Menu, fileContextMenu, Show
	}
}

folderContextMenu(path){
	Global bFolderContextMenu
	If (bFolderContextMenu) {
		menu, folderContextMenu,add,Reload Context Menu,hReload
		Menu, folderContextMenu, Show
	}
}

mmbContextMenu(){
	Global bMMBContextMenu
	If (bMMBContextMenu) {
		Menu, mmbContextMenu,add,Reload Context Menu,hReload
		Menu, mmbBContextMenu, Show
	}
}

;-----------------------------------------------------------------------;

; 2 ways to get Explorer Location
WindowsExplorerLocationByCOM(WndH="")
{
   If ( WndH = "" )
      WndH := WinExist("A")
   WinGet Process, ProcessName, ahk_id %WndH%
   If ( Process = "explorer.exe" )
   {
      WinGetClass Class, ahk_id %WndH%
      If ( Class ~= "Progman|WorkerW" )
         Location := A_Desktop
      Else If ( Class ~= "(Cabinet|Explore)WClass" )
      {
         For Window In ComObjCreate("Shell.Application").Windows
            If ( Window.HWnd == WndH )
            {
               URL := Window.LocationURL
               Break
            }
         StringTrimLeft, Location, URL, 8 ; remove "file:///"
         StringReplace Location, Location, /, \, All
      }
   }
   Return Location
}

WindowsExplorerLocationByControl(WndH="")
{
   If ( WndH = "" )
      WndH := WinExist("A")
   WinGet Process, ProcessName, ahk_id %WndH%
   If ( Process = "explorer.exe" )
   {
      WinGetClass Class, ahk_id %WndH%
      If ( Class ~= "Progman|WorkerW" )
         Location := A_Desktop
      Else If ( Class ~= "(Cabinet|Explore)WClass" )
      {
         ; XP doesn't know Edit1 control exists if Address Bar is hidden
         ControlGetPos Edit1Pos, , , , Edit1, ahk_id %WndH%
         If ( Edit1Pos = "" )
         {
             ; temporarily show Address Bar to register Edit1 control
             ; posted message toggles (shows/hides) Address Bar
             PostMessage 0x111, 41477, 0, , ahk_id %WndH%
             Sleep 100
             PostMessage 0x111, 41477, 0, , ahk_id %WndH%
         }
         ControlGetText Location , Edit1, ahk_id %WndH%
      }
   }
   Return Location
}