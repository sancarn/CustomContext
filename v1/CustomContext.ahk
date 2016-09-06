#SingleInstance, force
#Include inDIRContextMenu.ahk

$MButton::
	MouseGetPos, Xpos, YPos, WinID
	WinGet, WinExe, ProcessName, ahk_id %WinID%
	
	If not (WinExe = "Explorer.EXE") {
		rmbClickMenu()
		Send, {MButton}
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
	If (instr(path, ";")>0) {
		path := StrReplace(WindowsExplorerLocationByCOM(),"%20", " ")
		inDirContextMenu(path)
	} else {
		itemType = getPathType(path)
		if (itemType = "F") {
			fileContextMenu(path)
		} Else if (itemType = "D") {
			folderContextMenu(path)
		} Else {
			;Log Error?
		}
	}
	
	
return

hReload:
	reload
return

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

inDirContextMenu(path){
	Try {
		menu, inDIRContextMenu,add,Reload Context Menu,hReload
		Menu, inDIRContextMenu, Show
	}
}

fileContextMenu(path){
	Try {
		menu, fileContextMenu,add,Reload Context Menu,hReload
		Menu, fileContextMenu, Show
	}
}

folderContextMenu(path){
	Try {
		menu, folderContextMenu,add,Reload Context Menu,hReload
		Menu, folderContextMenu, Show
	}
}

rmbClickMenu(){
	Try {
		menu, rmbClickMenu,add,Reload Context Menu,hReload
		Menu, rmbClickMenu, Show
	}
}



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