#NoEnv
#SingleInstance force
CoordMode, Mouse, Screen
CoordMode, Pixel,Screen
CoordMode, Tooltip, Screen
CoordMode, Menu, window
SetTitleMatchMode, 2
SetTitleMatchMode, Slow
DetectHiddenWindows, On
DetectHiddenText, On
#InstallKeybdHook
#Persistent
SendMode, Input
GroupAdd, this_script, ahk_id %A_ScriptHwnd%
OnMessage(0x2100, "sci_get_highlighted_text_for_info")

courses_key = %1%
if !courses_key
{
	MsgBox, 8240, Ini Key required, You must run this script with the desired ini key to store the course list as a command line option.  Exiting script...
	exitapp
}


gc_other_ini_file = %A_ScriptDir%\GC_FWC.ini

all_courses = Acacia Reserve|Acacia Reserve 2|Bethpage b9|Bethpage f9|Centenary Harbour|Centenary harbour 2|Chateau Lavande|City Park|City park 2|Cursed Swamp|Dreaded dunes|Drumore Links|Drumore links 2|Eagle Peak|Eagle peak 2|East lake golf club|East lake golf club b9|East lake golf club f9|Glenmonarch Estate|Glenmonarch Estate 2|Gokasho Bay|Gokasho Bay 2|Greenoch Point|Greenoch point 2|Greenoch Point WM21|Grunberg Slopes|grunberg slopes 2|Jamil Dunes|Jamil dunes 2|Jubilee Grove|Jubilee grove 2|Juniper Point|Juniper point 2|Koh Hong Resort|Koh hong resort 2|Lake Wabasca|Lake wabasca 2|Maple Bay|Maple bay 2|Meadow Castle|Namhae Cliffs|Namhae cliffs 2|Nordic Fjords|Nordic fjords 2|Oakmont country club b9|Oakmont country club f9|Old Bridge Park|Old Bridge Park 2|Parc De Paris|Parc De Paris 2|Pebble beach b9|Pebble beach f9|Phantom Mansion|Porthello Cove|Quail hollow b9|Quail hollow f9|Royal Portrush b9|Royal Portrush f9|Sakura Hills|Sakura Hills 2|Santa Ventura|Santa ventura 2|Sequoia Creek|Sequoia Creek 2|Shi feng basin|Shiruba Springs|Sierra Plateau|Southern Pines|Southern Pines 2|St Andrew Links B9|St Andrew Links F9|Sunshine Glades|The Milano|The Milano 2|The Oasis|The Oasis 2|TPC Sawgrass|Tpc sawgrass b9|Tpc sawgrass f9|TPC Scottsdale|Vineyard Acres|Vineyard Acres 2|Waterfield Sands|Whistling Straits|Whistling Straits GS|White Cliffs Golf Club|Wiseacre Ranch|Wiseacre ranch 2|Yongsan gardens



iniread, last_courses, %gc_other_ini_file%, Main, %courses_key%, %A_Space%

If (courses_key = "selected_courses") or (courses_key = "gc_courses_get_elvts")
{
	loop, Read, %A_ScriptDir%\Golf_Clash_course_elevations.ini
	{
		StringLeft, Outputvar, A_LoopReadLine, 1
		if (Outputvar = "[")
		{
			StringTrimLeft, var, A_LoopReadLine, 1
			StringTrimRight, var, var, 1
			available_courses_ns .= var . ","
		}
	}
	StringTrimRight, available_courses_ns, available_courses_ns, 1
	StringReplace,available_courses,available_courses_ns,-,%A_Space%, All
	IniWrite, %available_courses%, %gc_other_ini_file%, Main, gc_courses_with_elvtn_logged
}
else
	available_courses =

Gui, 5: color, FFFFFF
Gui, 5: font, s21 bold underline, Franklin Gothic Medium
Gui, 5: add, text,, SELECT YOUR COURSES
Gui, 5: font,
Gui, 5: font, s13, Franklin Gothic Medium

loop, parse, all_courses, |
{
	StringReplace,course_var,A_LoopField,%A_Space%,, All
	IfInString, last_courses, %A_LoopField%
		checked = 1
	else
		checked = 0

	IfEqual, A_Index, 1
		options = x5 y+10 v%course_var% checked%checked% Section
	else
		if (A_Index > 1) and (A_Index < 23)
			options = xp y+8 v%course_var% checked%checked%
		else
			if (A_Index = 23)
				options = xp+220 ys v%course_var% checked%checked%
			else
				if (A_Index > 23) and (A_Index < 45)
					options = xp y+8 v%course_var% checked%checked%
				else
					if (A_Index = 45)
						options =  xp+220 ys v%course_var% checked%checked% Section
					else
						if (A_Index > 45) and (A_Index < 67)
							options = xp y+8 v%course_var% checked%checked%
						else
							if (A_Index = 67)
								options = xp+220 ys v%course_var% checked%checked%
							else
								if (A_Index > 67)
									options = xp y+8 v%course_var% checked%checked%

	if available_courses
	{
		If (courses_key = "selected_courses")
		{
			If A_LoopField not in %available_courses%
				options .= " disabled"
		}
		else
			if (courses_key = "gc_courses_get_elvts")
			{
				If A_LoopField in %available_courses%
					options .= " disabled"
			}
	}

	Gui, 5: add, checkbox, %options%, %A_LoopField%
}
Gui, 5: add, button, xs y+10 gclear_chk_boxes, Clear All
Gui, 5: add, button, x+15 yp gselect_courses, OK
Gui, 5: Show, , Course Selection
return


select_courses:
Gui, 5: submit
loop, parse, all_courses, |
{
	StringReplace,course_var,A_LoopField,%A_Space%,, All
	if (%course_var% = 1)
		courses .= A_LoopField . "|"
}
StringTrimRight, courses, courses, 1
sort, courses, D|
IniWrite, %courses%, %gc_other_ini_file%, Main, %courses_key%
ExitApp


clear_chk_boxes:
loop, parse, all_courses, |
{
	StringReplace,course_var,A_LoopField,%A_Space%,, All
	GuiControl, , %course_var%, 0
}
return

5guiclose:
ExitApp