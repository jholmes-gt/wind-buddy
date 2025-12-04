
play_CPC:
if (cpc_mode = 1)
{
	cpc_mode =
	GuiControl, hide, all_clubs_pic
	GuiControl, hide, hole_pic
	GuiControl, hide, rules_pic
	PostMessage, 0x111, 65405,,, checkpoint_challenge_pic_backup.ahk - AutoHotkey ahk_class AutoHotkey
	Gui, 5: destroy
	GuiControl, , cpc, 0
	return
}

cpc_mode = 1


run, %A_ScriptDir%\checkpoint_challenge_pic_backup.ahk

ini_file = %A_MyDocuments%\Scripts\new1.ini

adb_devices := RunWaitOne("adb.exe devices")
IfNotInString, adb_devices, R52NB0L0V0K			;tab s7 plus SN
	MsgBox, 262177, Fake Wind Chum reminder, Is your tablet connected to a usb port on your PC?

Run, adb.exe pull "/storage/emulated/0/DCIM/Screenshots/" "I:\Pictures\Tab_S7_plus"

Process, exist, TRIGGERcmdAgent.exe
if !ErrorLevel
	run, "C:\Users\jholm\AppData\Local\triggercmdagent\TRIGGERcmdAgent.exe"

global all_clubs_img, hole_img, rules_img, driver_img, wood_img, long_iron_img, short_iron_img, wedge_img, rough_iron_img, sand_wedge_img, driver_code, wood_code, long_iron_code, short_iron_code, wedge_code, rough_iron_code, sand_wedge_code, driver_lvl_img, wood_lvl_img, long_iron_lvl_img, short_iron_lvl_img, wedge_lvl_img, rough_iron_lvl_img, sand_wedge_lvl_img, fd, img_file

RunWait, %A_ScriptDir%\GC_Course_Selecter_forCPC.ahk cpc_courses
sleep, 500
IniRead, cpc_courses, %gc_other_ini_file%, Main, cpc_courses
StringReplace, cpc_courses, cpc_courses,%A_Space%,-, All
GuiControl,,course, |%cpc_courses%|%A_Space%
GuiControl,choose,course, 1
IniWrite, %cpc_courses%, %gc_other_ini_file%, Main, last_courses
IniWrite, %cpc_courses%, %gc_other_ini_file%, Main, cpc_courses_no_s

sleep, 1000

WinActivate, Fake Wind Chum ahk_class AutoHotkeyGUI
WinWaitActive, Fake Wind Chum ahk_class AutoHotkeyGUI

club_cat = Driver|Wood|Long_Iron|Short_Iron|Wedge|Rough_Iron|Sand_Wedge

st_height := A_ScreenHeight *.15
st_width := A_ScreenWidth *.15

subr:
del_files()
img_file =
loop, parse, club_cat, |
{
	%A_LoopField% =
	%A_LoopField%_lvl =
}
gosub, reset_clubs_and_levels

GuiControl, hide, all_clubs_pic
GuiControl, hide, hole_pic
GuiControl, hide, rules_pic

Gui, 5: destroy
Gui, 5: -caption +toolwindow +alwaysontop
Gui, 5: add, picture, x0 y0 w563 h-1 gminimize_gui5, %A_SCRIPTDIR%\splash_image.png
Gui, 5: show, w563 h298 noactivate, CPC Waiting
gui5_showing = 1
SetTimer, gui5_timer, 100
return

;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________
;~ _____________________________________________________________________________________________________________________________________________________________________

^f6::
FileSelectFile, img_file,, %A_ScriptDir%\Screenshots
gosub, go_to_work
return

^F4::
go_to_work:
SetTimer, gui5_timer, off
Gui, 5: cancel
gosub, get_info
gosub, populate_into_fake_wind_chum
gosub, picture_sub
gosub, go_to_hole
gosub, final_touches
return

final_touches:
WinActivate, Fake Wind Chum ahk_class AutoHotkeyGUI
GuiControl, focus, wind
send, ^a
return


populate_into_fake_wind_chum:
WinActivate, Fake Wind Chum ahk_class AutoHotkeyGUI
WinWaitActive, Fake Wind Chum ahk_class AutoHotkeyGUI
sleep, 175

GuiControl,, %driver%, 1
GuiControl,, Drivers_lvl_%driver_lvl%, 1
GuiControl,,Drivers_code_button, %driver% Lvl %driver_lvl%
GuiControl, enable, Drivers_code_button
GuiControl,,Drivers_code_button, 1

GuiControl,, %wood%, 1
GuiControl, , woods_lvl_%wood_lvl%, 1
GuiControl,,woods_code_button, %wood% Lvl %wood_lvl%
GuiControl, enable, woods_code_button

GuiControl,, %long_iron%, 1
GuiControl, , long_irons_lvl_%long_iron_lvl%, 1
GuiControl,,long_irons_code_button, %long_iron% Lvl %long_iron_lvl%
GuiControl, enable, long_irons_code_button

GuiControl,, %short_iron%, 1
GuiControl, , short_irons_lvl_%short_iron_lvl%, 1
GuiControl,,short_irons_code_button, %short_iron% Lvl %short_iron_lvl%
GuiControl, enable, short_irons_code_button

GuiControl,, %wedge%, 1
GuiControl, , wedges_lvl_%wedge_lvl%, 1
GuiControl,,wedges_code_button, %wedge% Lvl %wedge_lvl%
GuiControl, enable, wedges_code_button

GuiControl,, %rough_iron%, 1
GuiControl, , rough_irons_lvl_%rough_iron_lvl%, 1
GuiControl,,rough_irons_code_button, %rough_iron% Lvl %rough_iron_lvl%
GuiControl, enable, rough_irons_code_button

GuiControl,, %sand_wedge%, 1
GuiControl, , sand_wedges_lvl_%sand_wedge_lvl%, 1
GuiControl,,sand_wedges_code_button, %sand_wedge% Lvl %sand_wedge_lvl%
GuiControl, enable, sand_wedges_code_button

gosub, window_update_Drivers_code_button
return

picture_sub:
GuiControl, , all_clubs_pic, %all_clubs_img%
GuiControl, , hole_pic, %hole_img%
GuiControl, , rules_pic, %rules_img%

GuiControl, show, all_clubs_pic
GuiControl, show, hole_pic
GuiControl, show, rules_pic
return

^!NumpadSub::
InputBox, courses, Tooltips, Enter the name of the courses in the order they appear on the tabs. Seperate course names by a comma.
StringSplit, arr, courses, `,     ;arr0 is number of items
this_course := arr1
ToolTip, %this_course%, 300, 34, 2
this_course := arr2
ToolTip, %this_course%, 540, 34, 3
this_course := arr3
ToolTip, %this_course%, 771, 34, 4
return

#IfWinActive Fake Wind Chum ahk_class AutoHotkeyGUI
!n::gosub, all_clubs_pic_glabel
#IfWinActive


5GuiContextMenu:
SetTimer, gui5_timer, off
return

rules_pic_glabel:
ExitApp
return

all_clubs_pic_glabel:
gosub, subr
return

minimize_gui5:
WinMinimize, CPC Waiting ahk_class AutoHotkeyGUI
return

gui5_timer:
if gui5_showing
{
	IfWinNotActive, Fake Wind Chum ahk_class AutoHotkeyGUI
	{
		gui, 5: cancel
		gui5_showing =
	}
}
else
{
	IfWinActive, Fake Wind Chum ahk_class AutoHotkeyGUI
	{
		gui, 5: show, noactivate
		gui5_showing = 1
	}
}
return


#IfWinActive ahk_class AutoHotkey
MButton::gosub, get_var_contents
#IfWinActive


get_var_contents:
h_text=
WinActivate, ahk_class AutoHotkey
Clipboard=
send ^c
ClipWait
h_text := Clipboard
h_text := trim(h_text)
msgbox, % h_text . ": " . %h_text%
return


get_info:
if !img_file
	gosub, get_img_file
SplitPath, img_file, fn, fd, oe, onne
all_clubs_img := fd . "\all_clubs." . oe
rules_img := fd . "\rules." . oe
hole_img := fd . "\hole." . oe
driver_img := fd . "\driver." . oe
driver_lvl_img := fd . "\driver_lvl." . oe
wood_img := fd . "\wood." . oe
wood_lvl_img := fd . "\wood_lvl." . oe
long_iron_img := fd . "\long_iron." . oe
long_iron_lvl_img := fd . "\long_iron_lvl." . oe
short_iron_img := fd . "\short_iron." . oe
short_iron_lvl_img := fd . "\short_iron_lvl." . oe
wedge_img := fd . "\wedge." . oe
wedge_lvl_img := fd . "\wedge_lvl." . oe
rough_iron_img := fd . "\rough_iron." . oe
rough_iron_lvl_img := fd . "\rough_iron_lvl." . oe
sand_wedge_img := fd . "\sand_wedge." . oe
sand_wedge_lvl_img := fd . "\sand_wedge_lvl." . oe

ToolTip, processing pics
gc_cpc_create_pics_from_ss(img_file)


ToolTip, getting clubs
driver := get_club(driver_img, "driver")
wood := get_club(wood_img, "wood")
long_iron := get_club(long_iron_img, "long_iron")
short_iron := get_club(short_iron_img, "short_iron")
wedge := get_club(wedge_img, "wedge")
rough_iron := get_club(rough_iron_img, "rough_iron")
sand_wedge := get_club(sand_wedge_img, "sand_wedge")


ToolTip, getting club levels
driver_lvl := get_club_lvl(driver_lvl_img)
wood_lvl := get_club_lvl(wood_lvl_img)
long_iron_lvl := get_club_lvl(long_iron_lvl_img)
short_iron_lvl := get_club_lvl(short_iron_lvl_img)
wedge_lvl := get_club_lvl(wedge_lvl_img)
rough_iron_lvl := get_club_lvl(rough_iron_lvl_img)
sand_wedge_lvl := get_club_lvl(sand_wedge_lvl_img)

tooltip,
return




;/storage/emulated/0/DCIM/Screenshots/.pending-1757036180-Screenshot_20250828_213620_Automate.png

get_img_file:
ToolTip, getting screenshot
RunWait, adb.exe pull "/storage/emulated/0/Documents/NewSSPath.txt" "I:\Pictures\Tab_S7_plus\CPC\NewSSPath.txt"
fileread, img_file_andr1, I:\Pictures\Tab_S7_plus\CPC\NewSSPath.txt
StringReplace, p_img_file_andr_fn, img_file_andr1, /storage/emulated/0/DCIM/Screenshots/
StringSplit, arr, p_img_file_andr_fn, -     ;arr0 is number of items
img_file_andr2 := "/storage/emulated/0/DCIM/Screenshots/" . arr3
img_file := "I:\Pictures\Tab_S7_plus\CPC\" . arr3
StringReplace,img_file,img_file,%A_Space%,_, All
loop,
{
	RunWait, adb.exe pull `"%img_file_andr2%`" `"%img_file%`"
	IfExist, %img_file%
		break
	sleep, -1
}
return



get_club_lvl(img)	{

	command_var = tesseract.exe `"%img%`" stdout --psm 10
	club_lvl := RunWaitOne(command_var)
	StringReplace, club_lvl, club_lvl, `r`n,, All
	club_lvl := trim(club_lvl)
	IfEqual, club_lvl, A
		club_lvl = 4
	if club_lvl is not integer
	{
		loop, parse, club_lvl
		{
			if A_LoopField is integer
				new_club_lvl .= A_LoopField
		}
		if !(new_club_lvl = "") and !(new_club_lvl = 0) and (new_club_lvl is integer)
			return new_club_lvl
		else
			return ""
	}
	else
		return club_lvl
}






get_club(club_img, club_cat)	{

	IfEqual, club_cat, driver
	{
		command_var1 = magick `"%club_img%`" -format "#`%[hex:p{87`,102}]" info:
		code1 := RunWaitOne(command_var1)

		command_var2 = magick `"%club_img%`" -format "#`%[hex:p{166`,78}]" info:
		code2 := RunWaitOne(command_var2)

		if (code1 = "#FFFFFF") and (code2 = "#000000")
			return "Rocket"

		command_var3 = magick `"%club_img%`" -format "#`%[hex:p{38`,60}]" info:
		code3 := RunWaitOne(command_var3)

		%club_cat%_code := code1 . code2 . code3
		StringReplace, %club_cat%_code, %club_cat%_code, #FFFFFF, 0, All
		StringReplace, %club_cat%_code, %club_cat%_code, #000000, 1, All

		IfEqual, %club_cat%_code, 100
			return "Apocalypse"
		else
			IfEqual, %club_cat%_code, 101
				return "Big_Topper"
			else
				IfEqual, %club_cat%_code, 001
					return "Quarterback"
				else
					IfEqual, %club_cat%_code, 000
						return "Rock"
					else
						;~ IfEqual, %club_cat%_code, 011
							;~ return "Rocket"
						;~ else
							IfEqual, %club_cat%_code, 111
								return "Thors_Hammer"
							else
								IfEqual, %club_cat%_code, 110
									return "Extra_Mile"
	}



	IfEqual, club_cat, wood
	{
		command_var1 = magick `"%club_img%`" -format "#`%[hex:p{21`,95}]" info:
		code1 := RunWaitOne(command_var1)

		command_var2 = magick `"%club_img%`" -format "#`%[hex:p{161`,81}]" info:
		code2 := RunWaitOne(command_var2)

		if (code1 = "#FFFFFF") and (code2 = "#FFFFFF")
			return "Cataclysm"

		command_var3 = magick `"%club_img%`" -format "#`%[hex:p{171`,93}]" info:
		code3 := RunWaitOne(command_var3)

		%club_cat%_code := code1 . code2 . code3
		StringReplace, %club_cat%_code, %club_cat%_code, #FFFFFF, 0, All
		StringReplace, %club_cat%_code, %club_cat%_code, #000000, 1, All

		;~ IfEqual, %club_cat%_code, 000
			;~ return "Cataclysm"
		;~ else
			IfEqual, %club_cat%_code, 010
				return "Guardian"
			else
				IfEqual, %club_cat%_code, 011
					return "Hammerhead"
				else
					IfEqual, %club_cat%_code, 101
						return "Horizon"
					else
						IfEqual, %club_cat%_code, 100
							return "Viper"
						else
							IfEqual, %club_cat%_code, 111
								return "Big_Dawg"
							else
								IfEqual, %club_cat%_code, 110
									return "Sniper"
	}



	IfEqual, club_cat, long_iron
	{
		command_var1 = magick `"%club_img%`" -format "#`%[hex:p{87`,20}]" info:
		code1 := RunWaitOne(command_var1)

		command_var2 = magick `"%club_img%`" -format "#`%[hex:p{105`,55}]" info:
		code2 := RunWaitOne(command_var2)

		if (code1 = "#FFFFFF") and (code2 = "#000000")
			return "Backbone"

		command_var3 = magick `"%club_img%`" -format "#`%[hex:p{191`,89}]" info:
		code3 := RunWaitOne(command_var3)

		%club_cat%_code := code1 . code2 . code3
		StringReplace, %club_cat%_code, %club_cat%_code, #FFFFFF, 0, All
		StringReplace, %club_cat%_code, %club_cat%_code, #000000, 1, All

		IfEqual, %club_cat%_code, 110
			return "Grim_Reaper"
		else
			;~ IfEqual, %club_cat%_code, 010
				;~ return "Backbone"
			;~ else
				IfEqual, %club_cat%_code, 101
					return "Goliath"
				else
					IfEqual, %club_cat%_code, 100
						return "Saturn"
					else
						IfEqual, %club_cat%_code, 001
							return "B52"
						else
							IfEqual, %club_cat%_code, 111
								return "Grizzly"
							else
								IfEqual, %club_cat%_code, 000
									return "Tsunami"
	}




	IfEqual, club_cat, short_iron
	{
		command_var1 = magick `"%club_img%`" -format "#`%[hex:p{28`,77}]" info:
		code1 := RunWaitOne(command_var1)

		command_var2 = magick `"%club_img%`" -format "#`%[hex:p{171`,77}]" info:
		code2 := RunWaitOne(command_var2)

		command_var3 = magick `"%club_img%`" -format "#`%[hex:p{118`,80}]" info:
		code3 := RunWaitOne(command_var3)

		%club_cat%_code := code1 . code2 . code3
		StringReplace, %club_cat%_code, %club_cat%_code, #FFFFFF, 0, All
		StringReplace, %club_cat%_code, %club_cat%_code, #000000, 1, All

		If (%club_cat%_code = 110) or (%club_cat%_code = 111)
			return "Falcon"
		else
			IfEqual, %club_cat%_code, 010
				return "Hornet"
			else
				IfEqual, %club_cat%_code, 011
					return "Apache"
				else
					IfEqual, %club_cat%_code, 001
						return "Kingfisher"
					else
						IfEqual, %club_cat%_code, 000
							return "Runner"
						else
							IfEqual, %club_cat%_code, 101
								return "Thorn"
							else
								IfEqual, %club_cat%_code, 100
									return "Claw"
	}




	IfEqual, club_cat, wedge
	{
		command_var1 = magick `"%club_img%`" -format "#`%[hex:p{42`,94}]" info:
		code1 := RunWaitOne(command_var1)

		command_var2 = magick `"%club_img%`" -format "#`%[hex:p{43`,66}]" info:
		code2 := RunWaitOne(command_var2)

		if (code1 = "#000000") and (code2 = "#000000")
			return "Rapier"

		command_var3 = magick `"%club_img%`" -format "#`%[hex:p{125`,78}]" info:
		code3 := RunWaitOne(command_var3)

		%club_cat%_code := code1 . code2 . code3
		StringReplace, %club_cat%_code, %club_cat%_code, #FFFFFF, 0, All
		StringReplace, %club_cat%_code, %club_cat%_code, #000000, 1, All

		IfEqual, %club_cat%_code, 000
			return "Dart"
		else
			IfEqual, %club_cat%_code, 010
				return "Endbringer"
			else
				IfEqual, %club_cat%_code, 011
					return "Boomerang"
				else
					IfEqual, %club_cat%_code, 001
						return "Down_In_One"
					else
						IfEqual, %club_cat%_code, 100
							return "Skewer"
						else
							;~ IfEqual, %club_cat%_code, 111
								;~ return "Rapier"
							;~ else
								IfEqual, %club_cat%_code, 101
									return "Firefly"
	}



	IfEqual, club_cat, rough_iron
	{
		command_var1 = magick `"%club_img%`" -format "#`%[hex:p{26`,92}]" info:
		code1 := RunWaitOne(command_var1)

		command_var2 = magick `"%club_img%`" -format "#`%[hex:p{132`,61}]" info:
		code2 := RunWaitOne(command_var2)

		command_var3 = magick `"%club_img%`" -format "#`%[hex:p{15`,57}]" info:
		code3 := RunWaitOne(command_var3)

		%club_cat%_code := code1 . code2 . code3
		StringReplace, %club_cat%_code, %club_cat%_code, #FFFFFF, 0, All
		StringReplace, %club_cat%_code, %club_cat%_code, #000000, 1, All

		IfEqual, %club_cat%_code, 110
			return "Amazon"
		else
			IfEqual, %club_cat%_code, 111
				return "Machete"
			else
				IfEqual, %club_cat%_code, 000
					return "Nirvana"
				else
					IfEqual, %club_cat%_code, 001
						return "Razor"
					else
						IfEqual, %club_cat%_code, 011
							return "Roughcutter"
						else
							IfEqual, %club_cat%_code, 010
								return "Junglist"
							else
								IfEqual, %club_cat%_code, 101
									return "Off_Roader"
								else
									IfEqual, %club_cat%_code, 100
										return "Off_Roader"
	}


	IfEqual, club_cat, sand_wedge
	{
		command_var1 = magick `"%club_img%`" -format "#`%[hex:p{76`,89}]" info:
		code1 := RunWaitOne(command_var1)

		command_var2 = magick `"%club_img%`" -format "#`%[hex:p{51`,66}]" info:
		code2 := RunWaitOne(command_var2)

		if (code1 = "#000000") and (code2 = "#FFFFFF")
			return "Sahara"

		command_var3 = magick `"%club_img%`" -format "#`%[hex:p{174`,19}]" info:
		code3 := RunWaitOne(command_var3)

		%club_cat%_code := code1 . code2 . code3
		StringReplace, %club_cat%_code, %club_cat%_code, #FFFFFF, 0, All
		StringReplace, %club_cat%_code, %club_cat%_code, #000000, 1, All

		IfEqual, %club_cat%_code, 010
			return "Castaway"
		else
			IfEqual, %club_cat%_code, 011
				return "Dessert_Storm"
			else
				IfEqual, %club_cat%_code, 001
					return "Houdini"
				else
					IfEqual, %club_cat%_code, 000
						return "Spitfire"
					else
						IfEqual, %club_cat%_code, 110
							return "Malibu"
						else
							IfEqual, %club_cat%_code, 111
								return "Sand_Lizard"
							;~ else
								;~ IfEqual, %club_cat%_code, 100
									;~ return "Sahara"
	}

}








gc_cpc_create_pics_from_ss(img_file)	{

	Run, magick.exe `"%img_file%`" -crop 1252x424+264+1336 +repage %rules_img%
	Run, magick.exe `"%img_file%`" -crop 800x372+202+227 +repage -type Grayscale -despeckle -normalize -threshold 88`% %hole_img%
	Run, magick.exe `"%img_file%`" -crop 1104x684+324+1956 +repage %all_clubs_img%
	x = 339
	y = 2032
	run, magick.exe `"%img_file%`" -crop 220x113+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %driver_img%
	x += 284
	run, magick.exe `"%img_file%`" -crop 220x113+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %wood_img%
	x += 284
	run, magick.exe `"%img_file%`" -crop 220x113+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %long_iron_img%
	x += 284
	run, magick.exe `"%img_file%`" -crop 220x113+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %short_iron_img%
	x = 339
	y += 353
	run, magick.exe `"%img_file%`" -crop 220x113+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %wedge_img%
	x += 284
	run, magick.exe `"%img_file%`" -crop 220x113+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %rough_iron_img%
	x += 284
	run, magick.exe `"%img_file%`" -crop 220x113+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %sand_wedge_img%

	x = 328
	y = 2203
	run, magick.exe `"%img_file%`" -crop 65x54+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %driver_lvl_img%
	x += 283
	run, magick.exe `"%img_file%`" -crop 65x54+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %wood_lvl_img%
	x += 283
	run, magick.exe `"%img_file%`" -crop 65x54+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %long_iron_lvl_img%
	x += 283
	run, magick.exe `"%img_file%`" -crop 65x54+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %short_iron_lvl_img%
	x = 328
	y += 353
	run, magick.exe `"%img_file%`" -crop 65x54+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %wedge_lvl_img%
	x += 283
	run, magick.exe `"%img_file%`" -crop 65x54+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %rough_iron_lvl_img%
	x += 283
	run, magick.exe `"%img_file%`" -crop 65x54+%x%+%y% +repage -type Grayscale -despeckle -normalize -threshold 88`% %sand_wedge_lvl_img%

	return true
}







RunWaitOne(command) {
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}



^Del::del_files()


del_files()	{

	FileRemoveDir, I:\Pictures\Tab_S7_plus\Last_CPC, 1
	FileCreateDir, I:\Pictures\Tab_S7_plus\Last_CPC
	loop, files, I:\Pictures\Tab_S7_plus\CPC\*.*
	{
		;~ IfInString, A_LoopFileName, Golf_Clash.png
		;~ {
			;~ loop, files, I:\Pictures\Tab_S7_plus\full_ss*.png
				;~ num_full_ss := A_Index
			;~ num_full_ss++
			;~ FileCopy, %A_LoopFileLongPath%, I:\Pictures\Tab_S7_plus\full_ss%num_full_ss%.png
		;~ }
		FileMove, %A_LoopFileLongPath%, I:\Pictures\Tab_S7_plus\Last_CPC
	}
	return true
}



^!h::
hole_pic_glabel:
go_to_hole:
command_var = tesseract.exe `"%hole_img%`" stdout --psm 6
hole_text := RunWaitOne(command_var)
StringReplace, hole_text, hole_text, `r`n, `n, All
StringSplit, arr, hole_text, `n     ;arr0 is number of items
StringReplace,course,arr1,%A_Space%,-, All
StringLeft, hole, arr2, 1
;~ hole_url := "https://www.golfclashtommy.com/course/" . course . "/" . hole . "/2"
;~ WinActivate, ahk_class Chrome_WidgetWin_1
;~ WinWaitActive
;~ sleep, 200
;~ send, ^t
;~ WinWaitActive, New Tab - Google Chrome ahk_class Chrome_WidgetWin_1
;~ Clipboard := hole_url
;~ send, ^v{enter}
GuiControl,choosestring,course,%course%
GuiControl,choose,hole,%hole%
gosub, load_data

return


^!a::Run, adb.exe pull "/storage/emulated/0/DCIM/Screenshots/" "I:\Pictures\Tab_S7_plus"