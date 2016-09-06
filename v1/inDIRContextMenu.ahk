menu,inDIRContextMenu,add,AHK Script (.ahk)						,hNewAHK
menu,inDIRContextMenu,add,MapBasic Header (.def)				,hNewDEF
menu,inDIRContextMenu,add,MapBasic File (.mb)					,hNewMB
menu,inDIRContextMenu,add,MapBasic Project (.mbp)				,hNewMBP
menu,inDIRContextMenu,add,MapInfo Workspace (.wor)				,hNewWOR
menu,inDIRContextMenu,add,MapInfo Project (.mip)				,hNewMIP
menu,inDIRContextMenu,add,Ruby Script (.rb)						,hNewRB
menu,inDIRContextMenu,add,Macro Enabled Workbook (.xlsm)		,hNewXLSM

menu,inDIRContextMenu,Icon,AHK Script (.ahk)				,U:\Macros\_Developer Templates\Icons\AHK.png
menu,inDIRContextMenu,Icon,MapBasic Header (.def)			,U:\Macros\_Developer Templates\Icons\DEF.png
menu,inDIRContextMenu,Icon,MapBasic File (.mb)				,U:\Macros\_Developer Templates\Icons\MB.png
menu,inDIRContextMenu,Icon,MapBasic Project (.mbp)			,U:\Macros\_Developer Templates\Icons\MBP.png
menu,inDIRContextMenu,Icon,MapInfo Workspace (.wor)			,U:\Macros\_Developer Templates\Icons\WOR.png
menu,inDIRContextMenu,Icon,MapInfo Project (.mip)			,U:\Macros\_Developer Templates\Icons\MIP.png
menu,inDIRContextMenu,Icon,Ruby Script (.rb)				,U:\Macros\_Developer Templates\Icons\RB.png
menu,inDIRContextMenu,Icon,Macro Enabled Workbook (.xlsm)	,U:\Macros\_Developer Templates\Icons\XLSM.png

return

hNewAHK:
	t := "ahk"
	filePath := makeFile(t)
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitInNpp(filePath)
return

hNewDEF:
	t := "def"
	filePath := makeFile(t)
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitDoc(filePath)
return

hNewMB:
	t := "mb"
	filePath := makeFile(t)
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitDoc(filePath)
return

hNewMBP:
	t := "mbp"
	filePath := makeFile(t)
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitDoc(filePath)
return

hNewWOR:
	t := "wor"
	filePath := makeFile(t)
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitDoc(filePath)
return

hNewMIP:
	t := "mip"
	InputBox, fileName, Name %t% file, Please name the *.%t% file you wish to create!,,200,100,,New %t% file
	If (fileName = "") {
		Reload
	} else {
		FileCopy, U:\Macros\_Developer Templates\Template.MIP\Template.TAB	,%path%\%fileName%.TAB	,1
		FileCopy, U:\Macros\_Developer Templates\Template.MIP\Template.DAT	,%path%\%fileName%.DAT	,1
		FileCopy, U:\Macros\_Developer Templates\Template.MIP\Template.ID	,%path%\%fileName%.ID	,1
		FileCopy, U:\Macros\_Developer Templates\Template.MIP\Template.MAP	,%path%\%fileName%.MAP	,1
	}
	
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitWith(path "\" fileName ".TAB", "C:\Program Files\MapInfo\Professional\MapInfoPro.exe")
return

hNewRB:
	t := "rb"
	filePath := makeFile(t)
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitInNpp(filePath)
return

hNewXLSM:
	t := "xlsm"
	filePath := makeFile(t)
	Msgbox,4131, Custom Context, Would you like to open the %t% file now? 	;options 3+32+4096
	IfMsgbox Yes
		sRunWaitWithExcel(filePath)
return

makeFile(t){
	Global Path
	InputBox, fileName, Name %t% file, Please name the *.%t% file you wish to create!,,200,100,,New %t% file
	If (fileName = "") {
		Reload
	} else {
		FileCopy, U:\Macros\_Developer Templates\Template.%t%, %path%\%fileName%.%t%,1
		return path "\" fileName "." t
	}
}

sRunWaitWith(docPath, executable){
	shell := ComObjCreate("WScript.Shell")
	exec := shell.Exec(executable " " """" docPath """")
	exec.StdIn.WriteLine("Exit")
}

sRunWaitWithShell(docPath){
	shell := ComObjCreate("WScript.Shell")
	exec := shell.Exec("""" docPath """")
	exec.StdIn.WriteLine("Exit")
}

sRunWaitDoc(docPath){
	shell := ComObjCreate("WScript.Shell")
	exec := shell.Exec(_FindExecutable(docPath) " " """" docPath """")
	exec.StdIn.WriteLine("Exit")
}

sRunWaitWithExcel(docPath){
	Try {
		XL := ComObjActive("Excel.Application")
	} catch e {
		XL := ComObjCreate("Excel.Application")
		XL.Visible := 1	
	}
	XL.Workbooks.Open(docPath)
}

_FindExecutable(file){
  ;MAX_PATH is only 256 so leave a bit more room for unicode chars
  maxpath := 2048 * 2
  exepath := ""
  VarSetCapacity(exepath,maxpath)
  result := DllCall("Shell32\FindExecutable",str,file,str,0,str,exepath,Ptr)
  if (ErrorLevel)
    ErrorLevel := A_LastError
  else if (result < 33)
    ErrorLevel := result
  return exepath
}

sRunWaitInNpp(docPath){
	shell := ComObjCreate("WScript.Shell")
	exec := shell.Exec("C:\Program Files (x86)\Notepad++\notepad++.exe" " " """" docPath """")
	exec.StdIn.WriteLine("Exit")
}