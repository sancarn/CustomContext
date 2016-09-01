;Code by GEV @ https://autohotkey.com/boards/viewtopic.php?p=107905#p107905

~RButton::
Menu, MyMenu, Add
Menu, MyMenu, deleteAll
Menu, MyMenu, Add, Menu Item1, MenuItem1
Menu, MyMenu, Add, Menu Item2, MenuItem2
Menu, MyMenu, Add
Menu, Submenu1, Add, Submenu1 Item1, Submenu1Item1
Menu, Submenu1, Add, Submenu1 Item2, Submenu1Item2
Menu, Submenu, Add, My Submenu1, :Submenu1
Menu, Submenu2, Add, Submenu2 Item1, Submenu2Item1
Menu, Submenu2, Add, Submenu2 Item2, Submenu2Item2
Menu, Submenu, Add, My Submenu2, :Submenu2
Menu, MyMenu, Add, My Submenu, :Submenu


CoordMode, Mouse, Screen
MouseGetPos, Xpos, Ypos
Xm := (Xpos + 350)
Ym := 0
ControlClick, x%Xpos% y%Ypos%,,, R
CoordMode, Menu, Screen
Menu, MyMenu, Show, %Xm%, %Ym%
return

MenuItem1:
MenuItem2:
Submenu1Item1:
Submenu1Item2:
Submenu2Item1:
Submenu2Item2:
return
