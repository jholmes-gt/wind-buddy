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

#Include Chrome.ahk

courses_key = %1%
if !courses_key
{
	MsgBox, 8240, Ini Key required, You must run this script with the desired ini key to store the course list as a command line option.  Exiting script...
	exitapp
}

gc_other_ini_file = %A_ScriptDir%\GC_FWC.ini

all_courses = Acacia Reserve|Acacia Reserve 2|Bethpage f9|Centenary Harbour|Centenary harbour 2|Chateau Lavande|City Park|City park 2|Cursed Swamp|Dreaded dunes|Drumore Links|Drumore links 2|Eagle Peak|Eagle peak 2|East lake golf club|East lake golf club b9|East lake golf club f9|Glenmonarch Estate|Glenmonarch Estate 2|Gokasho Bay|Gokasho Bay 2|Greenoch Point|Greenoch point 2|Greenoch Point WM21|Grunberg Slopes|grunberg slopes 2|Jamil Dunes|Jamil dunes 2|Jubilee Grove|Jubilee grove 2|Juniper Point|Juniper point 2|Koh Hong Resort|Koh hong resort 2|Lake Wabasca|Lake wabasca 2|Maple Bay|Maple bay 2|Meadow Castle|Namhae Cliffs|Namhae cliffs 2|Nordic Fjords|Nordic fjords 2|Oakmont country club b9|Oakmont country club f9|Old Bridge Park|Old Bridge Park 2|Parc De Paris|Parc De Paris 2|Pebble beach b9|Pebble beach f9|Phantom Mansion|Porthello Cove|Quail hollow b9|Quail hollow f9|Royal Portrush b9|Royal Portrush f9|Sakura Hills|Sakura Hills 2|Santa Ventura|Santa ventura 2|Sequoia Creek|Sequoia Creek 2|Shi feng basin|Shiruba Springs|Sierra Plateau|Southern Pines|Southern Pines 2|St Andrew Links B9|St Andrew Links F9|Sunshine Glades|The Milano|The Milano 2|The Oasis|The Oasis 2|TPC Sawgrass|Tpc sawgrass b9|Tpc sawgrass f9|TPC Scottsdale|Vineyard Acres|Vineyard Acres 2|Waterfield Sands|Whistling Straits|Whistling Straits GS|White Cliffs Golf Club|Wiseacre Ranch|Wiseacre ranch 2|Yongsan gardens



iniread, last_courses, %gc_other_ini_file%, Main, %courses_key%, %A_Space%
StringReplace, last_courses_commas, last_courses,|,`,,All

Gui, 5: font, s21 bold underline, Mongolian Baiti
Gui, 5: add, text,, SELECT YOUR COURSES
Gui, 5: font,
Gui, 5: font, s13, Mongolian Baiti

loop, parse, all_courses, |
{
	StringReplace,course_var,A_LoopField,%A_Space%,, All
	If A_LoopField in %last_courses_commas%
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

	Gui, 5: add, checkbox, %options%, %A_LoopField%
}
Gui, 5: add, checkbox, xs-250 y+10 vopen_courses_browser, Open courses in browser?
Gui, 5: add, button, xs yp gclear_chk_boxes, Clear All
Gui, 5: add, button, x+15 yp gselect_courses, OK
Gui, 5: add, button, x+15 yp gexit_app, Cancel
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
StringSplit, course, courses, |     ;arr0 is number of items
IniWrite, %courses%, %gc_other_ini_file%, Main, %courses_key%
if open_courses_browser
	gosub, open_courses_browser
exitapp



open_courses_browser:
gctommy_tours_url := "https://www.golfclashtommy.com/tour"
FileCreateDir, ChromeProfile
ChromeInst := new Chrome("ChromeProfile", gctommy_tours_url)
sleep, 1000
PageInst_main := ChromeInst.GetPage()
PageInst_main.WaitForLoad()

var =
(
	document.title = '%course1%';

	const selectElement = document.getElementById('global-course-selection-list');

	// Set the value to the desired option, for example "Acacia Reserve"
	selectElement.value = '%course1%';

	// Manually dispatch the change event to run the event listener
	selectElement.dispatchEvent(new Event('change'));
)
PageInst_main.Evaluate(var)

if (course0 > 1)
{
	loop, % course0 - 1
	{
		sleep, 750
		this_course_num := A_Index + 1
		PageInst_main.Evaluate("window.open('https://www.golfclashtommy.com/tour', '_blank');")
		sleep, 2000
		PageInst%this_course_num% := ChromeInst.GetPage()
		PageInst%this_course_num%.WaitForLoad()
		this_course := course%this_course_num%
		var%this_course_num% =
		(
			document.title = '%this_course%';

			const selectElement%this_course_num% = document.getElementById('global-course-selection-list');

			// Set the value to the desired option, for example "Acacia Reserve"
			selectElement%this_course_num%.value = '%this_course%';

			// Manually dispatch the change event to run the event listener
			selectElement%this_course_num%.dispatchEvent(new Event('change'));
		)

		PageInst%this_course_num%.Evaluate(var%this_course_num%)
	}
}

return






clear_chk_boxes:
loop, parse, all_courses, |
{
	StringReplace,course_var,A_LoopField,%A_Space%,, All
	GuiControl, , %course_var%, 0
}
return



exit_app:
ExitApp
return


/*
send, ^+{tab}
sleep, 1000

PageInst3 := ChromeInst.GetPage()
PageInst3.WaitForLoad()
var3 =
(
		document.title = `"%course3%`";

		const selectElement3 = document.getElementById("global-course-selection-list");

		// Set the value to the desired option, for example "Acacia Reserve"
		selectElement3.value = `"%course3%`";

		// Manually dispatch the change event to run the event listener
		selectElement3.dispatchEvent(new Event('change'));
)

PageInst3.Evaluate(var3)
sleep, 1250

send, ^+{tab}
sleep, 1000

PageInst2 := ChromeInst.GetPage()
PageInst2.WaitForLoad()
var2 =
(
		document.title = `"%course2%`";

		const selectElement2 = document.getElementById("global-course-selection-list");

		// Set the value to the desired option, for example "Acacia Reserve"
		selectElement2.value = `"%course2%`";

		// Manually dispatch the change event to run the event listener
		selectElement2.dispatchEvent(new Event('change'));
)

PageInst2.Evaluate(var2)
*/


