SetWorkingDir %A_ScriptDir%
#NoEnv
#SingleInstance force
CoordMode, Mouse, Screen
CoordMode, Pixel,Screen
CoordMode, Tooltip, Screen
CoordMode, Menu, Screen
SetTitleMatchMode, 2
SetTitleMatchMode, Slow
DetectHiddenWindows, On
DetectHiddenText, On
#InstallKeybdHook
#HotkeyModifierTimeout 0
Thread, Interrupt, 0


return

^!b::
picture_sub:
Run, adb.exe pull "/storage/emulated/0/DCIM/Screenshots/" "I:\Pictures\Tab_S7_plus"
IfWinNotExist, Screenshots ahk_class CabinetWClass
{
	run, I:\Pictures\Tab_S7_plus\Screenshots
	WinWait, Screenshots ahk_class CabinetWClass
}

WinActivate, Screenshots ahk_class CabinetWClass
settimer, tt, 100
Clipboard=
ClipWait
SetTimer, tt, off
ToolTip
img_file := Clipboard
StringReplace,img_file_new,img_file,%A_Space%,_, All
StringReplace,img_file_new,img_file_new,\Screenshots\,\CPC\
FileCopy, %img_file%, %img_file_new%, 1
img_file := img_file_new
SplitPath, img_file, fn, fd, oe, onne
all_clubs_img := fd . "\all_clubs." . oe
rules_img := fd . "\rules." . oe
hole_img := fd . "\hole." . oe
RunWait, magick.exe `"%img_file%`" -crop 1104x684+324+1956 +repage %all_clubs_img%
RunWait, magick.exe `"%img_file%`" -crop 800x372+202+227 +repage -type Grayscale -despeckle -normalize -threshold 88`% %hole_img%
RunWait, magick.exe `"%img_file%`" -crop 1252x424+264+1336 +repage %rules_img%

WinGetPos,,,, tbHeight, ahk_class Shell_TrayWnd

hval = 239
yval := A_ScreenHeight - hval - tbHeight
Gui, destroy
Gui, -caption +toolwindow +alwaysontop
Gui, add, picture, x0 y0 w386 h-1, %all_clubs_img%
Gui, show, x0 y%yval%  w386 h%hval% noactivate, Checkpoint Clubs

hval2 = 166
yval2 := A_ScreenHeight - hval2 - tbHeight
Gui, 2: destroy
Gui, 2: -caption +toolwindow +alwaysontop
Gui, 2: add, picture, x0 y0 w400 h-1, %hole_img%
Gui, 2: show, x390 y%yval2%  w400 h%hval2% noactivate, Hole


xval3 := 390 + 404
Gui, 3: destroy
Gui, 3: -caption +toolwindow +alwaysontop
Gui, 3: add, picture, x0 y0 w438 h-1, %rules_img%
Gui, 3: show, x%xval3% y%yval2%  w438 h%hval2% noactivate, Rules
return

tt:
tooltip, Select the picture and press Ctrl-C
return