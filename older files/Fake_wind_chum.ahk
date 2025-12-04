/*
To do...
1. add a load/select tour button

load_current_tour:
Iniread, gcTour10, %ini_file%, %A_ComputerName% PS Gui pos, gcTour10, %A_Space%
StringReplace, gcTour10, gcTour10,%A_Space%,-, All
GuiControl,,course, |%gcTour10%|%A_Space%
IniWrite, %gcTour10%, %ini_file%, %A_ComputerName% PS Gui pos, last_courses
tooltip, Tour 10 loaded
SetTimer, endtt, 3000
GuiControl, choose, course, 1
GuiControl,choose,hole, 1
gosub, load_data
return



*/




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
GroupAdd, this_script, ahk_id %A_ScriptHwnd%
#HotkeyModifierTimeout 0
Thread, Interrupt, 0
Menu, tray, Icon, %A_ScriptDir%\golf.ico
Menu, Tray, MainWindow	;**********************************************************************************************************************************

;variables
{
ini_file := A_MyDocuments . "\Scripts\new1.ini"
gc_ini_file := A_ScriptDir . "\GC_clubs_wind_per_ring.ini"
gc_stats_ini_file := A_ScriptDir . "\GC_clubs_stats.ini"
gc_courses_ini_file:= A_ScriptDir . "\Golf_Clash_course_elevations.ini"
gc_other_ini_file := A_ScriptDir . "\GC_FWC.ini"

club_cats = Drivers|Woods|Long_Irons|Short_Irons|Wedges|Rough_Irons|Sand_Wedges
Drivers = Rocket|Extra_Mile|Big_Topper|Quarterback|Rock|Thors_Hammer|Apocalypse
Woods = Horizon|Viper|Big_Dawg|Hammerhead|Guardian|Sniper|Cataclysm
Long_Irons = Grim_Reaper|Backbone|Goliath|Saturn|B52|Grizzly|Tsunami
Short_Irons = Apache|Kingfisher|Runner|Thorn|Hornet|Claw|Falcon
Wedges = Dart|FireFly|Boomerang|Down_In_One|Skewer|Endbringer|Rapier
Rough_Irons = Roughcutter|Junglist|Machete|Off_Roader|Razor|Amazon|Nirvana
Sand_Wedges = Castaway|Desert_Storm|Malibu|Sahara|Sand_Lizard|Houdini|Spitfire
epics=Big_Topper,Thors_Hammer,Apocalypse,Horizon,Hammerhead,Cataclysm,Grim_Reaper,B52,Tsunami,Kingfisher,Falcon,FireFly,Boomerang,Endbringer,Junglist,Off_Roader,Amazon,Castaway,Sahara,Spitfire
rares=Extra_Mile,Rock,Big_Dawg,Guardian,Goliath,Grizzly,Apache,Thorn,Hornet,Down_In_One,Rapier,Roughcutter,Razor,Nirvana,Malibu,Houdini

IniRead, bag1_driver, %gc_other_ini_file%, Golf Bags, bag1_driver
IniRead, bag1_driver_lvl, %gc_other_ini_file%, Golf Bags, bag1_driver_lvl
IniRead, bag1_wood, %gc_other_ini_file%, Golf Bags, bag1_wood
IniRead, bag1_wood_lvl, %gc_other_ini_file%, Golf Bags, bag1_wood_lvl
IniRead, bag1_long_iron, %gc_other_ini_file%, Golf Bags, bag1_long_iron
IniRead, bag1_long_iron_lvl, %gc_other_ini_file%, Golf Bags, bag1_long_iron_lvl
IniRead, bag1_short_iron, %gc_other_ini_file%, Golf Bags, bag1_short_iron
IniRead, bag1_short_iron_lvl, %gc_other_ini_file%, Golf Bags, bag1_short_iron_lvl
IniRead, bag1_wedge, %gc_other_ini_file%, Golf Bags, bag1_wedge
IniRead, bag1_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag1_wedge_lvl
IniRead, bag1_rough_iron, %gc_other_ini_file%, Golf Bags, bag1_rough_iron
IniRead, bag1_rough_iron_lvl, %gc_other_ini_file%, Golf Bags, bag1_rough_iron_lvl
IniRead, bag1_sand_wedge, %gc_other_ini_file%, Golf Bags, bag1_sand_wedge
IniRead, bag1_sand_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag1_sand_wedge_lvl
IniRead, bag2_driver, %gc_other_ini_file%, Golf Bags, bag2_driver
IniRead, bag2_driver_lvl, %gc_other_ini_file%, Golf Bags, bag2_driver_lvl
IniRead, bag2_wood, %gc_other_ini_file%, Golf Bags, bag2_wood
IniRead, bag2_wood_lvl, %gc_other_ini_file%, Golf Bags, bag2_wood_lvl
IniRead, bag2_long_iron, %gc_other_ini_file%, Golf Bags, bag2_long_iron
IniRead, bag2_long_iron_lvl, %gc_other_ini_file%, Golf Bags, bag2_long_iron_lvl
IniRead, bag2_short_iron, %gc_other_ini_file%, Golf Bags, bag2_short_iron
IniRead, bag2_short_iron_lvl, %gc_other_ini_file%, Golf Bags, bag2_short_iron_lvl
IniRead, bag2_wedge, %gc_other_ini_file%, Golf Bags, bag2_wedge
IniRead, bag2_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag2_wedge_lvl
IniRead, bag2_rough_iron, %gc_other_ini_file%, Golf Bags, bag2_rough_iron
IniRead, bag2_rough_iron_lvl, %gc_other_ini_file%, Golf Bags, bag2_rough_iron_lvl
IniRead, bag2_sand_wedge, %gc_other_ini_file%, Golf Bags, bag2_sand_wedge
IniRead, bag2_sand_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag2_sand_wedge_lvl
IniRead, bag3_driver, %gc_other_ini_file%, Golf Bags, bag3_driver
IniRead, bag3_driver_lvl, %gc_other_ini_file%, Golf Bags, bag3_driver_lvl
IniRead, bag3_wood, %gc_other_ini_file%, Golf Bags, bag3_wood
IniRead, bag3_wood_lvl, %gc_other_ini_file%, Golf Bags, bag3_wood_lvl
IniRead, bag3_long_iron, %gc_other_ini_file%, Golf Bags, bag3_long_iron
IniRead, bag3_long_iron_lvl, %gc_other_ini_file%, Golf Bags, bag3_long_iron_lvl
IniRead, bag3_short_iron, %gc_other_ini_file%, Golf Bags, bag3_short_iron
IniRead, bag3_short_iron_lvl, %gc_other_ini_file%, Golf Bags, bag3_short_iron_lvl
IniRead, bag3_wedge, %gc_other_ini_file%, Golf Bags, bag3_wedge
IniRead, bag3_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag3_wedge_lvl
IniRead, bag3_rough_iron, %gc_other_ini_file%, Golf Bags, bag3_rough_iron
IniRead, bag3_rough_iron_lvl, %gc_other_ini_file%, Golf Bags, bag3_rough_iron_lvl
IniRead, bag3_sand_wedge, %gc_other_ini_file%, Golf Bags, bag3_sand_wedge
IniRead, bag3_sand_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag3_sand_wedge_lvl
IniRead, bag4_driver, %gc_other_ini_file%, Golf Bags, bag4_driver
IniRead, bag4_driver_lvl, %gc_other_ini_file%, Golf Bags, bag4_driver_lvl
IniRead, bag4_wood, %gc_other_ini_file%, Golf Bags, bag4_wood
IniRead, bag4_wood_lvl, %gc_other_ini_file%, Golf Bags, bag4_wood_lvl
IniRead, bag4_long_iron, %gc_other_ini_file%, Golf Bags, bag4_long_iron
IniRead, bag4_long_iron_lvl, %gc_other_ini_file%, Golf Bags, bag4_long_iron_lvl
IniRead, bag4_short_iron, %gc_other_ini_file%, Golf Bags, bag4_short_iron
IniRead, bag4_short_iron_lvl, %gc_other_ini_file%, Golf Bags, bag4_short_iron_lvl
IniRead, bag4_wedge, %gc_other_ini_file%, Golf Bags, bag4_wedge
IniRead, bag4_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag4_wedge_lvl
IniRead, bag4_rough_iron, %gc_other_ini_file%, Golf Bags, bag4_rough_iron
IniRead, bag4_rough_iron_lvl, %gc_other_ini_file%, Golf Bags, bag4_rough_iron_lvl
IniRead, bag4_sand_wedge, %gc_other_ini_file%, Golf Bags, bag4_sand_wedge
IniRead, bag4_sand_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag4_sand_wedge_lvl
IniRead, bag5_driver, %gc_other_ini_file%, Golf Bags, bag5_driver
IniRead, bag5_driver_lvl, %gc_other_ini_file%, Golf Bags, bag5_driver_lvl
IniRead, bag5_wood, %gc_other_ini_file%, Golf Bags, bag5_wood
IniRead, bag5_wood_lvl, %gc_other_ini_file%, Golf Bags, bag5_wood_lvl
IniRead, bag5_long_iron, %gc_other_ini_file%, Golf Bags, bag5_long_iron
IniRead, bag5_long_iron_lvl, %gc_other_ini_file%, Golf Bags, bag5_long_iron_lvl
IniRead, bag5_short_iron, %gc_other_ini_file%, Golf Bags, bag5_short_iron
IniRead, bag5_short_iron_lvl, %gc_other_ini_file%, Golf Bags, bag5_short_iron_lvl
IniRead, bag5_wedge, %gc_other_ini_file%, Golf Bags, bag5_wedge
IniRead, bag5_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag5_wedge_lvl
IniRead, bag5_rough_iron, %gc_other_ini_file%, Golf Bags, bag5_rough_iron
IniRead, bag5_rough_iron_lvl, %gc_other_ini_file%, Golf Bags, bag5_rough_iron_lvl
IniRead, bag5_sand_wedge, %gc_other_ini_file%, Golf Bags, bag5_sand_wedge
IniRead, bag5_sand_wedge_lvl, %gc_other_ini_file%, Golf Bags, bag5_sand_wedge_lvl

IniRead, cList, %gc_other_ini_file%, Controls, cList, %A_Space%


k_fontsize = 11
k_fontsize2 := k_fontsize * 1.07
k_fontsize3 := k_fontsize * 3.4
k_fontsize80p := k_fontsize * 0.97625
k_fontsize70p := k_fontsize * 0.88
k_fontsize60p := k_fontsize * 0.75
k_fontsize_half := k_fontsize * .39
k_button_height := k_fontsize * 3
k_button_width := k_fontsize * 16
k_button_width_small := k_fontsize * 12
k_font = Comic Sans MS
k_font2 = Impact

input_width := k_fontsize * 8
input_width_small := k_fontsize * 4
small_hor_space := k_fontsize * 11.1
large_hor_space := k_fontsize * 12.75
larger_hor_space := k_fontsize * 15

slider_length := 20 * k_fontsize

}

xpos = 18
ypos = 5
Gui, +resize +Minsize1699x904
Gui, color, FFFFFF


loop, parse, club_cats, |
{
	cat := A_LoopField
	StringUpper, u_cat, cat
	StringSplit, %cat%, %cat%, |     ;arr0 is number of items

	Gui, Font,
	Gui, Font, s%k_fontsize2% bold underline, %k_font%
	Gui, Add, text, x%xpos% y%ypos% v%cat%_header, %u_cat%

	Gui, Font,
	Gui, Font, s%k_fontsize%, %k_font%
	loop, parse, %cat%, |
	{
		club := A_LoopField
		Gui, Add, radio, +0x1000 xp y+10 w%k_button_width_small% gwindow_update_%cat%_club v%club%, %club%
	}

	xpos += large_hor_space

	if (A_Index = 1)
		ebs_x := xpos + 1.15 * input_width_small

	Gui, Font,
	Gui, Font, s%k_fontsize2% bold underline, %k_font%
	Gui, Add, text, x%xpos% y%ypos% v%cat%_lvl_header, LEVEL

	Gui, Font,
	Gui, Font, s%k_fontsize%, %k_font%
	loop, 10
	{
		IfEqual, A_Index, 9
			var = section
		else
			var =
		Gui, Add, radio, +0x1000 xp y+10 w%input_width_small% gwindow_update_%cat%_level v%cat%_lvl_%A_Index% %var%, %A_Index%
	}

	xpos += small_hor_space
}




Gui, font
Gui, font, s%k_FontSize70p% underline bold, %k_font%
Gui, add, text, x%ebs_x% ys vebs0 hidden, ENDBRINGER SCHOOL
Gui, font
Gui, font, s%k_FontSize70p%, %k_font%
loop, 13
{
	perc := 135 - (5 * A_Index)
	IfEqual, A_Index, 1
		var = section
	else
		var =
	Gui, add, text, xp y+3 vebs%perc% %var% hidden, %perc%`%:%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%
}
loop, 13
{
	perc := 70 - (5 * A_Index)
	IfEqual, A_Index, 1
	{
		xpos := "+5"
		ypos := "s"
	}
	else
	{
		xpos := "p"
		ypos := "+3"
	}
	Gui, add, text, x%xpos% y%ypos% vebs%perc% hidden,  %perc%`%:%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%
}


;buddy controls for slider
Gui, Font,
Gui, Font, s%k_fontsize3%, %k_font2%
Gui, Add, edit, x1031 y479 w100 vring_adj ReadOnly center, 0
Gui, Font,
Gui, Font, s%k_fontsize70p%, %k_font%
Gui, Add, text, x855 y479 vslider_pos center, 100



Gui, Font,
Gui, Font, s%k_fontsize2% bold underline, %k_font%
Gui, add, text, x10 y330 w200 center vgolf_bagsHdr_text backgroundtrans, %A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%Golf Bags%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%
Gui, Font,
Gui, Font, s%k_fontsize70p%, %k_font%
;~ Gui, add, text, x58 y+5 vgolf_bagsPar3_text, Par 3 bag
;~ Gui, add, text, x70 y+5 vsave_bag_text, Save Clubs

Gui, Font,
Gui, Font, s%k_fontsize%, %k_font%
Gui, add, radio, +0x1000 x10 y+5 w54 h30 disabled vgolf_bag1 gload_golf_bag1 section, Bag 1
Gui, add, radio, +0x1000 xp y+5 w57 h30 disabled vgolf_bag2 gload_golf_bag2, Bag 2
Gui, add, radio, +0x1000 xp y+5 w57 h30 disabled vgolf_bag3 gload_golf_bag3, Bag 3
Gui, add, radio, +0x1000 xp y+5 w57 h30 disabled vgolf_bag4 gload_golf_bag4, Bag 4
Gui, add, radio, +0x1000 xp y+5 w57 h30 disabled vgolf_bag5 gload_golf_bag5, Bag 5
Gui, add, radio, +0x1000 xp y+15 h30 vcpc greset_clubs_and_levels, CPC mode

Gui, add, button, x+40 ys gsave_bag1 vsave_bag1 disabled, Save Current
Gui, add, button, xp y+5 h30 gsave_bag2 vsave_bag2 disabled, Save Current
Gui, add, button, xp y+5 h30 gsave_bag3 vsave_bag3 disabled, Save Current
Gui, add, button, xp y+5 h30 gsave_bag4 vsave_bag4 disabled, Save Current
Gui, add, button, xp y+5 h30 gsave_bag5 vsave_bag5 disabled, Save Current


xpos := 2*large_hor_space + input_width
Gui, Font,
Gui, Font, s%k_fontsize70p%, %k_font%
Gui, add, button, x%xpos% ys+15 gendbringer_school vebsButton, Endbringer School
Gui, add, button, xp y+10 gtourney1_notes vtourneyNotes1Button, Tournament 1 Notes
Gui, add, button, xp y+10 gtourney2_notes vtourneyNotes2Button, Tournament 2 Notes
Gui, add, button, xp y+10 greset_clubs_and_levels vreset_clubs_and_levels_Button, Reset clubs/levels


Gui, Font,
Gui, Font, s%k_fontsize2% bold underline, %k_font%
Gui, add, text, x+10 ys W200 center vclubInfo_header, CLUB INFORMATION
Gui, Font,
Gui, Font, s%k_fontsize80p%, %k_font%
Gui, Add, ListView, xp-3 y+3 r8 w200 -Hdr Grid Count8 CBlack BackgroundWhite +ReadOnly vclub_info section, Attribute|Value


;~ xpos := (871/11.77)*k_fontsize
;~ ypos := (450/11.77)*k_fontsize
Gui, Font,
Gui, Font, s%k_fontsize2%, %k_font%
;~ Gui, add, edit, section x%xpos% y%ypos% w%input_width_small% h30 vwind gwindow_update_wind center, 0
Gui, add, edit, section vwind gwindow_update_wind center, 0
Gui, add, text, x+1 yp+3 vmph_text, mph

Gui, Font,
Gui, Font, s%k_fontsize2% bold underline, %k_font%
;~ ypos -= (25/11.77)*k_fontsize
;~ Gui, add, text, xs y%ypos% vwindHdr_text, Wind
Gui, add, text, vwindHdr_text, Wind

Gui, Font,
Gui, Font, s%k_fontsize2% bold underline, %k_font%
Gui, add, text, vball_powerHdr_text, Ball Power
Gui, Font,
Gui, Font, s%k_fontsize2%, %k_font%
Gui, add, ddl, section vball_power gwindow_update_wind center, 0|1|2|3|4|5|6||7|8|9|10



xpos := 73*k_fontsize
ypos := (550/11.77)*k_fontsize
Gui, Font,
Gui, Font, s%k_fontsize2% bold underline, %k_font%
Gui, add, text, x%xpos% y%ypos% velevationHdr_text, Elevation
Gui, Font,
Gui, Font, s%k_fontsize%, %k_font%
Gui, add, combobox, xp-2 y+0 w%input_width% velevation gwindow_update_elevation, -65`%|-60`%|-50`%|-45`%|-40`%|-35`%|-30`%|-25`%|-20`%|-15`%|-10`%|-5`%|0`%|5`%|10`%||15`%|20`%|25`%|30`%|35`%|40`%|45`%|50`%|55`%|60`%|65`%


xpos := 72.73*k_fontsize
ypos := 42.0 * k_fontsize
Gui, Font,
Gui, Font, s%k_fontsize2% bold underline, %k_font%
Gui, add, text, x%xpos% y%ypos% vclub_distanceHdr_text, Club Distance
xpos := 68.73 * k_fontsize
;~ ypos := 49.5 * k_fontsize
Gui, Add, Slider, x%xpos% y+5 w%slider_length% vclub_distance Buddy2ring_adj Buddy1slider_pos Line2 ToolTip AltSubmit TickInterval10 gwindow_update_slider section, 100


xpos := slider_length*1.03
ypos := (468/11.77)*k_fontsize
Gui, Font,
Gui, Font, s%k_fontsize2% bold underline, %k_font%
Gui, Add, text, xs+%xpos% y%ypos% w171 h25 vring_adjHdr_text center section, RINGS TO ADJUST


xpos := (1157 /11.77)*k_fontsize
ypos := (495/11.77)*k_fontsize
wpos := (86/11.77)*k_fontsize
Gui, Font,
Gui, Font, s%k_fontsize%, %k_font%
Gui, add, text, x%xpos% y%ypos% w%wpos% h23 vmin_rings_txt, Min:
Gui, add, text, xp y+2 w%wpos% h23 v25p_rings_txt, 25`%:
Gui, add, text, xp y+2 w%wpos% h23 vmid_rings_txt, Mid:
Gui, add, text, xp y+2 w%wpos% h23 v75p_rings_txt, 75`%:
Gui, add, text, xp y+2 w%wpos% h23 vmax_rings_txt, Max:


Gui, Font,
Gui, Font, s%k_fontsize%, %k_font%
xpos = 5
ypos = 632
loop, parse, club_cats, |
{
	StringTrimRight, cat_no_s, A_LoopField, 1
	Gui, add, radio, +0x1000 x%xpos% y%ypos% w170 h%k_button_height% v%A_LoopField%_code_button disabled gwindow_update_%A_LoopField%_code_button, %cat_no_s%
	xpos += 175
	ypos := "p"
}


xpos := "+" . (30/11.77)*k_fontsize
Gui, Font
Gui, Font, s%k_FontSize% bold,%k_font%
Gui, Add, Button, x%xpos% y395 w131 h30 gcourse_selecter vselect_courses_button, Select Courses

Gui, Font
Gui, Font, s%k_FontSize% bold underline,%k_font%
Gui, Add, Text, xp y+5 w110 h20 section vcourseHdr_text, Course

Iniread, courses, %gc_other_ini_file%, Main, last_courses
sort, courses, D|
courses .= "| |"

Gui, Font
Gui, Font, s%k_FontSize%,%k_font%
Gui, Add, combobox, xp y+2 w160 vcourse gload_data section, %courses%

;~ Gui, Add, Button, x+10 yp h30 gload_current_tour vloadCurrentTour_button, Tour 10

Gui, Font
Gui, Font, s%k_FontSize% underline bold, %k_font%
Gui, Add, Text, xs y+5 w110 h20 vholeHdr_text, Hole

Gui, Font
Gui, Font, s%k_FontSize%, %k_font%
Gui, Add, combobox, xp y+2 w40 vhole gload_data section center, 1|2|3|4|5|6|7|8|9

Gui, Font
Gui, Font, s%k_FontSize2% bold, %k_font%
Gui, Add, Text, x+10 yp-5 hidden vpar, Par 4


ypos := (30/11.77)*k_fontsize
Gui, Font
Gui, Font, s%k_FontSize% bold, %k_font%
Gui, Add, Text, xs y+%ypos% h23 vshot1hdr_text gprep_shot1 section, Shot 1
Gui, Add, Text, xs y+5 h23 vshot2Hdr_text gprep_shot2, Shot 2


ypos := (25/11.77)*k_fontsize
Gui, Font
Gui, Font, s%k_FontSize% bold,%k_font%
Gui, Add, Text, x+%k_fontsize% ys-%ypos% w68 h23 vcourse_hole_elevationHdr_text section, Elevation
Gui, Font
Gui, Font, s%k_FontSize% bold,%k_font%
xpos := 2*k_fontsize
Gui, Add, Text, x+%xpos% yp w60 h20 vcourse_hole_clubHdr_text, Club

Gui, Font
Gui, Font, s%k_FontSize% , %k_font%
Gui, Add, Edit, xs y+5 w40 h30 center velevation1 section,
Gui, Add, Edit, xp y+5 w40 h30 center velevation2,


Gui, Add, combobox, x+5 ys w100 vclub_cat1, driver|wood|long_Iron|short_Iron|Wedge|Rough_Iron|Sand_Wedge|%A_Space%
Gui, Add, combobox, xp y+5 w100 vclub_cat2 section, wood|long_Iron|short_Iron|Wedge|Rough_Iron|Sand_Wedge|%A_Space%


Gui, Font
Gui, Font, s%k_FontSize% bold,%k_font%
xpos := (1249/11.77)*k_fontsize
Gui, Add, Button, x%xpos% y+5 w80 h30 gsave_data vcourse_hole_SaveInfoHdr_button, Save
Gui, Add, Button, x+5 yp w87 h30 gplay_hole vplay_hole_button, Play Hole
Gui, Add, Button, x+5 yp h30 gplay_next_hole vplay_next_hole_button disabled section, Play Next Hole

Gui, add, picture, vcourse_pic w-1 h500 ggoto_gct_website BackgroundTrans, I:\Pictures\GC_holes\FWC_BlankImage.png


;removed with removal of deluxe CPC mode
;~ Gui, add, picture, x10 ys+60 w386 h-1 gall_clubs_pic_glabel vall_clubs_pic hidden, %A_ScriptDir%\all_clubs_php.png
;~ Gui, add, picture, x+5 yp w400 h-1 ghole_pic_glabel vhole_pic hidden, %A_ScriptDir%\hole_php.png
;~ Gui, add, picture, x+5 yp w438 h-1 grules_pic_glabel vrules_pic hidden, %A_ScriptDir%\rules_php.png


Gui, Font, norm s%k_fontsize70p%, %k_font%
Gui, add, text, x+10 yp-40 vHole_notesHdr_txt, Notes
Gui, add, edit, xp y+0 w300 h100 multi vHole_notes gsave_hole_notes disabled,


WinGet, tb_pid, pid, ahk_class Shell_TrayWnd
WinGet, tb_id, id, ahk_class Shell_TrayWnd
WinGetPos,,,, tbHeight, ahk_id %tb_id%
SysGet, title_bar_height, 31
ypos := A_ScreenHeight*.046
ghpos := (A_ScreenHeight * 0.95) - tbHeight - title_bar_height
Gui, show, x0 y%ypos% w%A_ScreenWidth% h%ghpos%, Fake Wind Chum


enable_golf_bags:
loop, 5
{
	bagnum_to_check := A_Index
	enable_bag := "enable"
	loop, parse, club_cats, |
	{
		StringTrimRight, club_cat_no_s, A_LoopField, 1
		StringReplace,Outputvar,%A_LoopField%,|,`,, All
		if bag%bagnum_to_check%_%club_cat_no_s% not in %Outputvar%
		{
			enable_bag := "disable"
			break
		}
		if bag%bagnum_to_check%_%club_cat_no_s%_lvl not in 1,2,3,4,5,6,7,8,9,10
		{
			enable_bag := "disable"
			break
		}
	}
	GuiControl, %enable_bag%, golf_bag%A_Index%
}
return



enable_save_golf_bag_buttons:
loop, parse, club_cats, |
{
	club_cat_to_check := A_LoopField
	%club_cat_to_check%_club_selected =
	%club_cat_to_check%_lvl_selected =
	StringTrimRight, club_cat_to_check_no_s, club_cat_to_check, 1
	loop, parse, %club_cat_to_check%, |
	{
		if (%A_LoopField% = 1)
		{
			%club_cat_to_check%_club_selected = 1
			%club_cat_to_check_no_s% := A_LoopField
			break
		}
	}
	if !%club_cat_to_check%_club_selected
	{
		%club_cat_to_check_no_s% =
		loop, 5
			GuiControl, disable, save_bag%A_Index%
		return
	}
	loop, 10
	{
		if (%club_cat_to_check%_lvl_%A_Index% = 1)
		{
			%club_cat_to_check%_lvl_selected = 1
			%club_cat_to_check_no_s%_lvl := A_Index
			break
		}
	}
	if !%club_cat_to_check%_lvl_selected
	{
		%club_cat_to_check_no_s%_lvl =
		loop, 5
			GuiControl, disable, save_bag%A_Index%
		return
	}
}
loop, 5
	GuiControl, enable, save_bag%A_Index%
return



save_par3_bag:
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
StringRight, par3_bag, arr2, 1
IniWrite, %par3_bag%, %gc_other_ini_file%, Golf Bags, par3_bag
ToolTip, Par3 bag updated to Golf Bag%par3_bag%
SetTimer, endtt, -3000
return


save_bag1:
save_bag2:
save_bag3:
save_bag4:
save_bag5:
StringRight, this_golf_bag, A_ThisLabel, 1
tttxt=Updated Golf Bag %this_golf_bag%:`n
loop, parse, club_cats, |
{
	StringTrimRight, club_cat_no_s, A_LoopField, 1
	club := %club_cat_no_s%
	club_lvl := %club_cat_no_s%_lvl
	IniWrite, %club%, %gc_other_ini_file%, Golf Bags, bag%this_golf_bag%_%club_cat_no_s%
	IniWrite, %club_lvl%, %gc_other_ini_file%, Golf Bags, bag%this_golf_bag%_%club_cat_no_s%_lvl
	bag%this_golf_bag%_%club_cat_no_s% := club
	bag%this_golf_bag%_%club_cat_no_s%_lvl := club_lvl
	tttxt .= club_cat_no_s . ": " . club . " Level " . club_lvl . "`n"
}
StringTrimRight, tttxt, tttxt, 1
ToolTip, %tttxt%
SetTimer, endtt, 10000
return





tourney2_notes:
IfWinNotExist, Tournament 2 Notes ahk_class AutoHotkeyGUI
{
	Gui, 4: destroy
	Gui, 4: -dpiscale
	Gui, 4: color, FFFFFF
	Gui, 4: font, s%k_FontSize60p% bold, %k_font%
	Gui, 4: Add, Text, x0 y3 section, Tournament Name:
	IniRead, tourney2_name, %gc_other_ini_file%, Tournament2 Notes, tourney2_name, %A_Space%
	Gui, 4: Add, Edit, x+0 yp w200 vtourney2_name, %tourney2_name%
	Gui, 4: Add, Tab3, xs y+5, Front 9|Back 9
	xp = p
	yp = +5

	Gui, 4: font
	Gui, 4: font, s%k_FontSize60p%, %k_font%
	Gui, 4: add, Button, h22 gclear_tourney2_notes, Clear Notes
	loop, 9
	{
		Gui, 4: font
		Gui, 4: font, s%k_FontSize60p% underline, %k_font%
		Gui, 4: add, text, x%xp% y%yp% center, Hole %A_Index%

		Iniread, t2_f9_h%A_Index%_notes, %gc_other_ini_file%, Tournament2 Notes, t2_f9_h%A_Index%_notes, %A_Space%
		StringReplace, t2_f9_h%A_Index%_notes, t2_f9_h%A_Index%_notes,|,`n, All
		Gui, 4: font
		Gui, 4: font, s%k_FontSize60p%, %k_font%
		Gui, 4: add, Edit, xp y+2 multi w500 r3 vt2_f9_h%A_Index%_notes, % t2_f9_h%A_Index%_notes
		xp := "p"
		yp := "+5"
	}

	Gui, 4: Tab, Back 9,, Exact
	Gui, 4: add, Button, h22 gclear_tourney2_notes, Clear Notes
	loop, 9
	{
		Gui, 4: font
		Gui, 4: font, s%k_FontSize60p% underline, %k_font%
		Gui, 4: add, text, x%xp% y%yp% center, Hole %A_Index%

		Iniread, t2_b9_h%A_Index%_notes, %gc_other_ini_file%, Tournament2 Notes, t2_b9_h%A_Index%_notes, %A_Space%
		StringReplace, t2_b9_h%A_Index%_notes, t2_b9_h%A_Index%_notes,|,`n, All
		Gui, 4: font
		Gui, 4: font, s%k_FontSize60p%, %k_font%
		Gui, 4: add, Edit, xp y+2 multi w500 r3 vt2_b9_h%A_Index%_notes, % t2_b9_h%A_Index%_notes
		xp := "p"
		yp := "+5"
	}

	Gui, 4: show,, Tournament 2 Notes
}
return




clear_tourney2_notes:
loop, 9
{
	GuiControl, 4:, t2_b9_h%A_Index%_notes,
	GuiControl, 4:, t2_f9_h%A_Index%_notes,
	IniDelete, t2_b9_h%A_Index%_notes, %gc_other_ini_file%, Tournament2 Notes, t2_b9_h%A_Index%_notes
	IniDelete, t2_f9_h%A_Index%_notes, %gc_other_ini_file%, Tournament2 Notes, t2_f9_h%A_Index%_notes
}
return



4GuiClose:
Gui, 4: submit
Gui, 4: destroy
loop, 9
{
	notes_text := t2_f9_h%A_Index%_notes
	StringReplace, notes_text, notes_text,`n,|, All
	IniWrite, %notes_text%, %gc_other_ini_file%, Tournament2 Notes, t2_f9_h%A_Index%_notes

	notes_text := t2_b9_h%A_Index%_notes
	StringReplace, notes_text, notes_text,`n,|, All
	IniWrite, %notes_text%, %gc_other_ini_file%, Tournament2 Notes, t2_b9_h%A_Index%_notes
}
return


tourney1_notes:
IfWinNotExist, Tournament 1 Notes ahk_class AutoHotkeyGUI
{
	Gui, 3: destroy
	Gui, 3: -dpiscale
	Gui, 3: color, FFFFFF
	Gui, 3: font, s%k_FontSize60p% bold, %k_font%
	Gui, 3: Add, Text, x0 y3 section, Tournament Name:
	IniRead, tourney1_name, %gc_other_ini_file%, Tournament1 Notes, tourney1_name, %A_Space%
	Gui, 3: Add, Edit, x+0 yp w200 vtourney1_name, %tourney1_name%
	Gui, 3: Add, Tab3, xs y+5, Front 9|Back 9
	xp = p
	yp = +5

	Gui, 3: font
	Gui, 3: font, s%k_FontSize60p%, %k_font%
	Gui, 3: add, Button, h22 gclear_tourney1_notes, Clear Notes
	loop, 9
	{
		Gui, 3: font
		Gui, 3: font, s%k_FontSize60p% underline, %k_font%
		Gui, 3: add, text, x%xp% y%yp% center, Hole %A_Index%

		Iniread, t1_f9_h%A_Index%_notes, %gc_other_ini_file%, Tournament1 Notes, t1_f9_h%A_Index%_notes, %A_Space%
		StringReplace, t1_f9_h%A_Index%_notes, t1_f9_h%A_Index%_notes,|,`n, All
		Gui, 3: font
		Gui, 3: font, s%k_FontSize60p%, %k_font%
		Gui, 3: add, Edit, xp y+2 multi w500 r3 vt1_f9_h%A_Index%_notes, % t1_f9_h%A_Index%_notes
	}

	Gui, 3: Tab, Back 9,, Exact
	Gui, 3: add, Button, h22 gclear_tourney1_notes, Clear Notes
	loop, 9
	{
		Gui, 3: font
		Gui, 3: font, s%k_FontSize60p% underline, %k_font%
		Gui, 3: add, text, x%xp% y%yp% center, Hole %A_Index%

		Iniread, t1_b9_h%A_Index%_notes, %gc_other_ini_file%, Tournament1 Notes, t1_b9_h%A_Index%_notes, %A_Space%
		StringReplace, t1_b9_h%A_Index%_notes, t1_b9_h%A_Index%_notes,|,`n, All
		Gui, 3: font
		Gui, 3: font, s%k_FontSize60p%, %k_font%
		Gui, 3: add, Edit, xp y+2 multi w500 r3 vt1_b9_h%A_Index%_notes, % t1_b9_h%A_Index%_notes
		xp := "p"
		yp := "+5"
	}

	Gui, 3: show,, Tournament 1 Notes
}
return




clear_tourney1_notes:
loop, 9
{
	GuiControl, 3:, t1_b9_h%A_Index%_notes,
	GuiControl, 3:, t1_f9_h%A_Index%_notes,
	IniDelete, t1_b9_h%A_Index%_notes, %gc_other_ini_file%, Tournament1 Notes, t1_b9_h%A_Index%_notes
	IniDelete, t1_f9_h%A_Index%_notes, %gc_other_ini_file%, Tournament1 Notes, t1_f9_h%A_Index%_notes
}
return



3GuiClose:
Gui, 3: submit
Gui, 3: destroy
IniWrite, %tourney1_name%, %gc_other_ini_file%, Tournament1 Notes, tourney1_name
loop, 9
{
	notes_text := t1_f9_h%A_Index%_notes
	StringReplace, notes_text, notes_text,`n,|, All
	IniWrite, %notes_text%, %gc_other_ini_file%, Tournament1 Notes, t1_f9_h%A_Index%_notes

	notes_text := t1_b9_h%A_Index%_notes
	StringReplace, notes_text, notes_text,`n,|, All
	IniWrite, %notes_text%, %gc_other_ini_file%, Tournament1 Notes, t1_b9_h%A_Index%_notes
}
return



reset_clubs_and_levels:
loop, parse, club_cats, |
{
	r_club_cat := A_LoopField
	loop, parse, %r_club_cat%, |
	{
		GuiControl, , %A_LoopField%, 0
	}
	loop, 10
	{
		GuiControl, , %r_club_cat%_lvl_%A_Index%, 0
	}
	GuiControl, , %r_club_cat%_code_button, 0
	StringTrimRight, cat_no_s, r_club_cat, 1
	GuiControl, , %r_club_cat%_code_button, %cat_no_s%
}
loop, 5
	GuiControl, , golf_bag%A_Index%, 0
LV_Delete()
Gui, submit, nohide
gosub, enable_save_golf_bag_buttons
return





endbringer_school:
if !endbringer_school
{
	GuiControl, ChooseString, elevation, 20`%
	GuiControl, ,Endbringer, 1
	GuiControl, ,Wedges_lvl_%bag1_wedge_lvl%, 1
	loop, 27
	{
		num := 135 - (A_Index * 5)
		GuiControl, show, ebs%num%
	}
	endbringer_school = 1
	gosub, window_update_Wedges_club
}
else
{
	loop, 27
	{
		num := 135 - (A_Index * 5)
		GuiControl, hide, ebs%num%
	}
	endbringer_school =
}
return




course_selecter:
RunWait, %A_ScriptDir%\GC_Course_Selecter.ahk selected_courses
Iniread, selected_courses, %gc_other_ini_file%, Main, selected_courses, %A_Space%
StringReplace,selected_courses,selected_courses,%A_Space%,-, All
available_courses=
loop, Read, %A_ScriptDir%\Golf_Clash_course_elevations.ini
{
	StringLeft, Outputvar, A_LoopReadLine, 1
	if (Outputvar = "[")
	{
		StringTrimLeft, var, A_LoopReadLine, 1
		StringTrimRight, var, var, 1
		available_courses .= var . ","
	}
}
StringTrimRight, available_courses, available_courses, 1
loop, parse, selected_courses, |
{
	if A_LoopField not in %available_courses%
	{
		if (A_Index = 1)
			StringReplace, selected_courses, selected_courses, %A_LoopField%|
		else
			StringReplace, selected_courses, selected_courses, |%A_LoopField%
	}
}
GuiControl,,course, |%selected_courses%|%A_Space%
GuiControl,choose,course, 1
GuiControl,choose,hole, 1
gosub, load_data
IniWrite, %selected_courses%, %gc_other_ini_file%, Main, last_courses
return






save_data:
Gui, submit, nohide
IniWrite, %elevation1%, %gc_courses_ini_file%, %course%, Hole%hole%_shot1
IniWrite, %club_cat1%, %gc_courses_ini_file%, %course%, Hole%hole%_club_cat1
IfNotEqual, par, 3
{
	IniWrite, %elevation2%, %gc_courses_ini_file%, %course%, Hole%hole%_elevation2
	IniWrite, %club_cat2%, %gc_courses_ini_file%, %course%, Hole%hole%_club_cat2
}
tooltip, info saved!
SetTimer, endtt, 3000
return




next_hole:
GuiControlGet, Outputvar, focusv
if (Outputvar = "Hole_notes")
{
	send, %A_ThisHotkey%
	return
}
gui, submit, nohide
GuiControl, choose, hole, % "|" . hole + 1
sleep, 500
gosub, prep_shot1
return



prev_hole:
GuiControlGet, Outputvar, focusv
if (Outputvar = "Hole_notes")
{
	send, %A_ThisHotkey%
	return
}
gui, submit, nohide
GuiControl, choose, hole, % "|" . hole - 1
sleep, 500
gosub, prep_shot1
return



play_next_hole:
gui, submit, nohide
GuiControl, choose, hole, % "|" . hole + 1
sleep, 500
play_hole:
gui, submit, nohide
gosub, prep_shot1
IfNotEqual, par, 3
{
	playing_hole_timer_on = 1
	settimer, playing_hole_timer, 1000
	pht_secs_rem = 35
	if pht_reset
		reset_text := "Timer was reset`n"
	else
		reset_text := ""
	ToolTip,%reset_text%Changing club/elevation for 2nd shot in %pht_secs_rem% seconds`nRight click anywhere to reset timer,421,741,2
	settimer, prep_shot2, -35000
}
return


playing_hole_timer:
pht_secs_rem--
if (pht_secs_rem = 0)
{
	ToolTip,,,,2
	tooltip, Changed club/elevation for next hole,421,741
	SetTimer, endtt, 10000
	SetTimer, %A_ThisLabel%, off
	return
}
ToolTip,Changing club/elevation for 2nd shot in %pht_secs_rem% seconds`nRight click anywhere to reset timer,421,741,2
return




prep_shot1:
gui, submit, nohide
if (elevation1 = "")
	elevation1 := "10%"
else
	elevation1 .= "%"
GuiControl, ChooseString, elevation, %elevation1%
GuiControl, , club_distance, 100

if !(cpc_mode = 1)
{
	loop, parse, club_cats, |
	{
		club_cat_empty = 1
		loop, parse, %A_LoopField%, |
		{
			if (%A_LoopField% = 1)
			{
				club_cat_empty =
				break
			}
		}
		if club_cat_empty
			break
	}
	if club_cat_empty
	{
		GuiControl,, golf_bag1, 1
		tooltip, Clubs were't selected.  Golf Bag 1 was autoselected for you.
		SetTimer, endtt, 3000
		gosub, load_golf_bag1
	}
}

code_button := club_cat1 . "s_code_button"
GuiControl, , %code_button%, 1
label1 := "window_update_" . club_cat1 . "s_code_button"
gosub, %label1%
return


prep_shot2:
playing_hole_timer_on =
gui, submit, nohide
if (elevation2 = "")
	elevation2 := "10%"
else
	elevation2 .= "%"
GuiControl, ChooseString, elevation, %elevation2%
GuiControl, , club_distance, 100

if !(cpc_mode = 1)
{
	loop, parse, club_cats, |
	{
		club_cat_empty = 1
		loop, parse, %A_LoopField%, |
		{
			if (%A_LoopField% = 1)
			{
				club_cat_empty =
				break
			}
		}
		if club_cat_empty
			break
	}
	if club_cat_empty
	{
		GuiControl,, golf_bag1, 1
		tooltip, Clubs were't selected.  Golf Bag 1 was autoselected for you.
		SetTimer, endtt, 3000
		gosub, load_golf_bag1
	}
}

code_button := club_cat2 . "s_code_button"
GuiControl, , %code_button%, 1
label2 := "window_update_" . club_cat2 . "s_code_button"
gosub, %label2%
return



load_data:
Gui, submit, nohide
if !course or !hole
{
	GuiControl, disable, play_next_hole_button
	GuiControl, disable, play_hole_button
	GuiControl, disable, Hole_notes
	return
}
GuiControl, enable, play_hole_button
GuiControl, enable, Hole_notes
if (hole = 9)
	GuiControl, disable, play_next_hole_button
else
	GuiControl, enable, play_next_hole_button

Iniread, par, %gc_courses_ini_file%, %course%, Hole%hole%_par, %A_Space%
iniread, elevation1, %gc_courses_ini_file%, %course%, Hole%hole%_Shot1, %A_Space%
iniread, Hole_notes, %gc_courses_ini_file%, %course%, Hole%hole%_notes, %A_Space%
StringReplace, Hole_notes, Hole_notes,|,`n, All
GuiControl,,Hole_notes,%Hole_notes%

IfNotEqual, par, 3
{
	iniread, elevation2, %gc_courses_ini_file%, %course%, Hole%hole%_Shot2, %A_Space%
	iniread, club_cat2, %gc_courses_ini_file%, %course%, Hole%hole%_club_cat2, wood
	driver_or_Wood = driver
}
else
	driver_or_wood = wood
iniread, club_cat1, %gc_courses_ini_file%, %course%, Hole%hole%_club_cat1, %driver_or_wood%

GuiControl, , elevation1, %elevation1%
GuiControl, , par, Par %par%
GuiControl, ChooseString, club_cat1, %club_cat1%
GuiControl, show, elevation1
GuiControl, show, par

IfNotEqual, par, 3
{
	GuiControl, , elevation2, %elevation2%
	GuiControl, ChooseString, club_cat2, %club_cat2%
}
else
{
	GuiControl, Choose, club_cat2, 0
	GuiControl, , elevation2, %A_Space%

}
GuiControl, , course_pic, *w-1 *h500 %A_ScriptDir%\GC_holes\%course%-%hole%.png
course_pic = %A_ScriptDir%\GC_holes\%course%-%hole%.png
return



goto_gct_website:
gui, submit, nohide
url = https://www.golfclashtommy.com/course/%course%/%hole%/1
run, %url%
return


save_hole_notes:
settimer, %A_ThisLabel%_timer, -2500
return


save_hole_notes_timer:
Gui, submit, nohide
StringReplace, Hole_notes, Hole_notes,`n,|, All
IniWrite, %Hole_notes%, %gc_courses_ini_file%, %course%, Hole%hole%_notes
return




load_golf_bag1:
GuiControl,,%bag1_driver%, 1
GuiControl,,Drivers_lvl_%bag1_driver_lvl%, 1
GuiControl,,Drivers_code_button, %bag1_driver% Lvl %bag1_driver_lvl%
GuiControl, enable, Drivers_code_button

GuiControl,,%bag1_wood%, 1
GuiControl,,Woods_lvl_%bag1_wood_lvl%, 1
GuiControl,,Woods_code_button, %bag1_Wood% Lvl %bag1_Wood_lvl%
GuiControl, enable, Woods_code_button

GuiControl,,%bag1_Long_Iron%, 1
GuiControl,,Long_Irons_lvl_%bag1_Long_Iron_lvl%, 1
GuiControl,,Long_Irons_code_button, %bag1_Long_Iron% Lvl %bag1_Long_Iron_lvl%
GuiControl, enable, Long_Irons_code_button

GuiControl,,%bag1_Short_Iron%, 1
GuiControl,,Short_Irons_lvl_%bag1_Short_Iron_lvl%, 1
GuiControl,,Short_Irons_code_button, %bag1_Short_Iron% Lvl %bag1_Short_Iron_lvl%
GuiControl, enable, Short_Irons_code_button

GuiControl,,%bag1_Wedge%, 1
GuiControl,,Wedges_lvl_%bag1_Wedge_lvl%, 1
GuiControl,,Wedges_code_button, %bag1_Wedge% Lvl %bag1_Wedge_lvl%
GuiControl, enable, Wedges_code_button

GuiControl,,%bag1_Rough_Iron%, 1
GuiControl,,Rough_Irons_lvl_%bag1_Rough_Iron_lvl%, 1
GuiControl,,Rough_Irons_code_button, %bag1_Rough_Iron% Lvl %bag1_Rough_Iron_lvl%
GuiControl, enable, Rough_Irons_code_button

GuiControl,,%bag1_Sand_Wedge%, 1
GuiControl,,Sand_Wedges_lvl_%bag1_Sand_Wedge_lvl%, 1
GuiControl,,Sand_Wedges_code_button, %bag1_Sand_Wedge% Lvl %bag1_Sand_Wedge_lvl%
GuiControl, enable, Sand_Wedges_code_button

Gui, submit, nohide
gosub, enable_save_golf_bag_buttons
GuiControl, , Drivers_code_button, 1
StringRight, bag_num, A_ThisLabel, 1
this_club := bag%bag_num%_driver
this_club_lvl := bag%bag_num%_driver_lvl
this_club_cat := "Drivers"
gosub, calculate_rings
ControlFocus, Edit2, Fake Wind Chum ahk_class AutoHotkeyGUI
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





load_golf_bag2:
GuiControl,,%bag2_driver%, 1
GuiControl,,Drivers_lvl_%bag2_driver_lvl%, 1
GuiControl,,Drivers_code_button, %bag2_driver% Lvl %bag2_driver_lvl%
GuiControl, enable, Drivers_code_button

GuiControl,,%bag2_wood%, 1
GuiControl,,Woods_lvl_%bag2_wood_lvl%, 1
GuiControl,,Woods_code_button, %bag2_Wood% Lvl %bag2_Wood_lvl%
GuiControl, enable, Woods_code_button

GuiControl,,%bag2_Long_Iron%, 1
GuiControl,,Long_Irons_lvl_%bag2_Long_Iron_lvl%, 1
GuiControl,,Long_Irons_code_button, %bag2_Long_Iron% Lvl %bag2_Long_Iron_lvl%
GuiControl, enable, Long_Irons_code_button

GuiControl,,%bag2_Short_Iron%, 1
GuiControl,,Short_Irons_lvl_%bag2_Short_Iron_lvl%, 1
GuiControl,,Short_Irons_code_button, %bag2_Short_Iron% Lvl %bag2_Short_Iron_lvl%
GuiControl, enable, Short_Irons_code_button

GuiControl,,%bag2_Wedge%, 1
GuiControl,,Wedges_lvl_%bag2_Wedge_lvl%, 1
GuiControl,,Wedges_code_button, %bag2_Wedge% Lvl %bag2_Wedge_lvl%
GuiControl, enable, Wedges_code_button

GuiControl,,%bag2_Rough_Iron%, 1
GuiControl,,Rough_Irons_lvl_%bag2_Rough_Iron_lvl%, 1
GuiControl,,Rough_Irons_code_button, %bag2_Rough_Iron% Lvl %bag2_Rough_Iron_lvl%
GuiControl, enable, Rough_Irons_code_button

GuiControl,,%bag2_Sand_Wedge%, 1
GuiControl,,Sand_Wedges_lvl_%bag2_Sand_Wedge_lvl%, 1
GuiControl,,Sand_Wedges_code_button, %bag2_Sand_Wedge% Lvl %bag2_Sand_Wedge_lvl%
GuiControl, enable, Sand_Wedges_code_button

Gui, submit, nohide
gosub, enable_save_golf_bag_buttons
GuiControl, , Drivers_code_button, 1
StringRight, bag_num, A_ThisLabel, 1
this_club := bag%bag_num%_driver
this_club_lvl := bag%bag_num%_driver_lvl
this_club_cat := "Drivers"
gosub, calculate_rings
ControlFocus, Edit2, Fake Wind Chum ahk_class AutoHotkeyGUI
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return




load_golf_bag3:
GuiControl,,%bag3_driver%, 1
GuiControl,,Drivers_lvl_%bag3_driver_lvl%, 1
GuiControl,,Drivers_code_button, %bag3_driver% Lvl %bag3_driver_lvl%
GuiControl, enable, Drivers_code_button

GuiControl,,%bag3_wood%, 1
GuiControl,,Woods_lvl_%bag3_wood_lvl%, 1
GuiControl,,Woods_code_button, %bag3_Wood% Lvl %bag3_Wood_lvl%
GuiControl, enable, Woods_code_button

GuiControl,,%bag3_Long_Iron%, 1
GuiControl,,Long_Irons_lvl_%bag3_Long_Iron_lvl%, 1
GuiControl,,Long_Irons_code_button, %bag3_Long_Iron% Lvl %bag3_Long_Iron_lvl%
GuiControl, enable, Long_Irons_code_button

GuiControl,,%bag3_Short_Iron%, 1
GuiControl,,Short_Irons_lvl_%bag3_Short_Iron_lvl%, 1
GuiControl,,Short_Irons_code_button, %bag3_Short_Iron% Lvl %bag3_Short_Iron_lvl%
GuiControl, enable, Short_Irons_code_button

GuiControl,,%bag3_Wedge%, 1
GuiControl,,Wedges_lvl_%bag3_Wedge_lvl%, 1
GuiControl,,Wedges_code_button, %bag3_Wedge% Lvl %bag3_Wedge_lvl%
GuiControl, enable, Wedges_code_button

GuiControl,,%bag3_Rough_Iron%, 1
GuiControl,,Rough_Irons_lvl_%bag3_Rough_Iron_lvl%, 1
GuiControl,,Rough_Irons_code_button, %bag3_Rough_Iron% Lvl %bag3_Rough_Iron_lvl%
GuiControl, enable, Rough_Irons_code_button

GuiControl,,%bag3_Sand_Wedge%, 1
GuiControl,,Sand_Wedges_lvl_%bag3_Sand_Wedge_lvl%, 1
GuiControl,,Sand_Wedges_code_button, %bag3_Sand_Wedge% Lvl %bag3_Sand_Wedge_lvl%
GuiControl, enable, Sand_Wedges_code_button

Gui, submit, nohide
gosub, enable_save_golf_bag_buttons
GuiControl, , Drivers_code_button, 1
StringRight, bag_num, A_ThisLabel, 1
this_club := bag%bag_num%_driver
this_club_lvl := bag%bag_num%_driver_lvl
this_club_cat := "Drivers"
gosub, calculate_rings
ControlFocus, Edit2, Fake Wind Chum ahk_class AutoHotkeyGUI
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





load_golf_bag4:
GuiControl,,%bag4_driver%, 1
GuiControl,,Drivers_lvl_%bag4_driver_lvl%, 1
GuiControl,,Drivers_code_button, %bag4_driver% Lvl %bag4_driver_lvl%
GuiControl, enable, Drivers_code_button

GuiControl,,%bag4_wood%, 1
GuiControl,,Woods_lvl_%bag4_wood_lvl%, 1
GuiControl,,Woods_code_button, %bag4_Wood% Lvl %bag4_Wood_lvl%
GuiControl, enable, Woods_code_button

GuiControl,,%bag4_Long_Iron%, 1
GuiControl,,Long_Irons_lvl_%bag4_Long_Iron_lvl%, 1
GuiControl,,Long_Irons_code_button, %bag4_Long_Iron% Lvl %bag4_Long_Iron_lvl%
GuiControl, enable, Long_Irons_code_button

GuiControl,,%bag4_Short_Iron%, 1
GuiControl,,Short_Irons_lvl_%bag4_Short_Iron_lvl%, 1
GuiControl,,Short_Irons_code_button, %bag4_Short_Iron% Lvl %bag4_Short_Iron_lvl%
GuiControl, enable, Short_Irons_code_button

GuiControl,,%bag4_Wedge%, 1
GuiControl,,Wedges_lvl_%bag4_Wedge_lvl%, 1
GuiControl,,Wedges_code_button, %bag4_Wedge% Lvl %bag4_Wedge_lvl%
GuiControl, enable, Wedges_code_button

GuiControl,,%bag4_Rough_Iron%, 1
GuiControl,,Rough_Irons_lvl_%bag4_Rough_Iron_lvl%, 1
GuiControl,,Rough_Irons_code_button, %bag4_Rough_Iron% Lvl %bag4_Rough_Iron_lvl%
GuiControl, enable, Rough_Irons_code_button

GuiControl,,%bag4_Sand_Wedge%, 1
GuiControl,,Sand_Wedges_lvl_%bag4_Sand_Wedge_lvl%, 1
GuiControl,,Sand_Wedges_code_button, %bag4_Sand_Wedge% Lvl %bag4_Sand_Wedge_lvl%
GuiControl, enable, Sand_Wedges_code_button

Gui, submit, nohide
gosub, enable_save_golf_bag_buttons
GuiControl, , Drivers_code_button, 1
StringRight, bag_num, A_ThisLabel, 1
this_club := bag%bag_num%_driver
this_club_lvl := bag%bag_num%_driver_lvl
this_club_cat := "Drivers"
gosub, calculate_rings
ControlFocus, Edit2, Fake Wind Chum ahk_class AutoHotkeyGUI
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return








load_golf_bag5:
GuiControl,,%bag5_driver%, 1
GuiControl,,Drivers_lvl_%bag5_driver_lvl%, 1
GuiControl,,Drivers_code_button, %bag5_driver% Lvl %bag5_driver_lvl%
GuiControl, enable, Drivers_code_button

GuiControl,,%bag5_wood%, 1
GuiControl,,Woods_lvl_%bag5_wood_lvl%, 1
GuiControl,,Woods_code_button, %bag5_Wood% Lvl %bag5_Wood_lvl%
GuiControl, enable, Woods_code_button

GuiControl,,%bag5_Long_Iron%, 1
GuiControl,,Long_Irons_lvl_%bag5_Long_Iron_lvl%, 1
GuiControl,,Long_Irons_code_button, %bag5_Long_Iron% Lvl %bag5_Long_Iron_lvl%
GuiControl, enable, Long_Irons_code_button

GuiControl,,%bag5_Short_Iron%, 1
GuiControl,,Short_Irons_lvl_%bag5_Short_Iron_lvl%, 1
GuiControl,,Short_Irons_code_button, %bag5_Short_Iron% Lvl %bag5_Short_Iron_lvl%
GuiControl, enable, Short_Irons_code_button

GuiControl,,%bag5_Wedge%, 1
GuiControl,,Wedges_lvl_%bag5_Wedge_lvl%, 1
GuiControl,,Wedges_code_button, %bag5_Wedge% Lvl %bag5_Wedge_lvl%
GuiControl, enable, Wedges_code_button

GuiControl,,%bag5_Rough_Iron%, 1
GuiControl,,Rough_Irons_lvl_%bag5_Rough_Iron_lvl%, 1
GuiControl,,Rough_Irons_code_button, %bag5_Rough_Iron% Lvl %bag5_Rough_Iron_lvl%
GuiControl, enable, Rough_Irons_code_button

GuiControl,,%bag5_Sand_Wedge%, 1
GuiControl,,Sand_Wedges_lvl_%bag5_Sand_Wedge_lvl%, 1
GuiControl,,Sand_Wedges_code_button, %bag5_Sand_Wedge% Lvl %bag5_Sand_Wedge_lvl%
GuiControl, enable, Sand_Wedges_code_button

Gui, submit, nohide
gosub, enable_save_golf_bag_buttons
GuiControl, , Drivers_code_button, 1
StringRight, bag_num, A_ThisLabel, 1
this_club := bag%bag_num%_driver
this_club_lvl := bag%bag_num%_driver_lvl
this_club_cat := "Drivers"
gosub, calculate_rings
ControlFocus, Edit2, Fake Wind Chum ahk_class AutoHotkeyGUI
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return







wheel_wind:
StringReplace, up_or_down, A_ThisHotkey, Wheel
GuiControlGet, focused_control, Focus
if !(focused_control = "Edit2")
{
	send, {%A_ThisHotkey%}
	return
}
gui, submit, nohide
if (up_or_down = "up")
	new_wind := Round(wind + 0.3,1)
else
	new_wind := Round(wind - 0.3,1)
GuiControl, , wind, %new_wind%
gosub, window_update_wind
return



;window_update_%A_LoopField%_code_button

window_update_Drivers_code_button:
gui, submit, nohide
GuiControl, , Drivers_code_button, 1
this_club_cat := "Drivers"
loop, 10
	if (Drivers_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
loop, parse, Drivers, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return



window_update_Woods_code_button:
gui, submit, nohide
GuiControl, , woods_code_button, 1
this_club_cat := "Woods"
loop, 10
	if (Woods_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
loop, parse, Woods, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return



window_update_Long_Irons_code_button:
gui, submit, nohide
GuiControl, , long_irons_code_button, 1
this_club_cat := "Long_Irons"
loop, 10
	if (Long_Irons_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
loop, parse, Long_Irons, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return



window_update_Short_Irons_code_button:
gui, submit, nohide
GuiControl, , short_irons_code_button, 1
this_club_cat := "Short_Irons"
loop, 10
	if (Short_Irons_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
loop, parse, Short_Irons, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return



window_update_Wedges_code_button:
gui, submit, nohide
GuiControl, , wedges_code_button, 1
this_club_cat := "Wedges"
loop, 10
	if (Wedges_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
loop, parse, Wedges, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return



window_update_Rough_Irons_code_button:
gui, submit, nohide
GuiControl, , rough_irons_code_button, 1
this_club_cat := "Rough_Irons"
loop, 10
	if (Rough_Irons_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
loop, parse, Rough_Irons, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return



window_update_Sand_Wedges_code_button:
gui, submit, nohide
GuiControl, , sand_wedges_code_button, 1
this_club_cat := "Sand_Wedges"
loop, 10
	if (Sand_Wedges_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
loop, parse, Sand_Wedges, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





;window_update_%cats%_club


window_update_Drivers_club:
gui, submit, nohide
this_club_cat := "Drivers"
loop, parse, Drivers, |
{
	if (%A_LoopField% = 1)
	{
		this_club := A_LoopField
		break
	}
}
if this_club in %epics%
{
	GuiControl, disable, Drivers_lvl_9
	GuiControl, , Drivers_lvl_9, 0
	GuiControl, disable, Drivers_lvl_10
	GuiControl, , Drivers_lvl_10, 0
}
else
	if this_club in %rares%
	{
		GuiControl, enable, Drivers_lvl_9
		GuiControl, disable, Drivers_lvl_10
		GuiControl, , Drivers_lvl_10, 0
	}
	else
	{
		GuiControl, enable, Drivers_lvl_9
		GuiControl, enable, Drivers_lvl_10
	}
Gui, submit, nohide
this_club_lvl =
loop, 10
	if (Drivers_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
if !this_club_lvl
{
	GuiControl,,Drivers_code_button, Driver
	GuiControl, disable, Drivers_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Drivers_code_button, 0
	return
}

GuiControl,,Drivers_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Drivers_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Drivers_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return




window_update_Woods_club:
gui, submit, nohide
this_club_cat := "Woods"
loop, parse, Woods, |
{
	if (%A_LoopField% = 1)
	{
		this_club := A_LoopField
		break
	}
}
if this_club in %epics%
{
	GuiControl, disable, Woods_lvl_9
	GuiControl, , Woods_lvl_9, 0
	GuiControl, disable, Woods_lvl_10
	GuiControl, , Woods_lvl_10, 0
}
else
	if this_club in %rares%
	{
		GuiControl, enable, Woods_lvl_9
		GuiControl, disable, Woods_lvl_10
		GuiControl, , Woods_lvl_10, 0
	}
	else
	{
		GuiControl, enable, Woods_lvl_9
		GuiControl, enable, Woods_lvl_10
	}
gui, submit, nohide
this_club_lvl =
loop, 10
	if (Woods_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
if !this_club_lvl
{
	GuiControl,,Woods_code_button, Wood
	GuiControl, disable, Woods_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Woods_code_button, 0
	return
}

GuiControl,,Woods_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Woods_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Woods_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return




window_update_Long_Irons_club:
gui, submit, nohide
this_club_cat := "Long_Irons"
loop, parse, Long_Irons, |
{
	if (%A_LoopField% = 1)
	{
		this_club := A_LoopField
		break
	}
}
if this_club in %epics%
{
	GuiControl, disable, Long_Irons_lvl_9
	GuiControl, , Long_Irons_lvl_9, 0
	GuiControl, disable, Long_Irons_lvl_10
	GuiControl, , Long_Irons_lvl_10, 0
}
else
	if this_club in %rares%
	{
		GuiControl, enable, Long_Irons_lvl_9
		GuiControl, disable, Long_Irons_lvl_10
		GuiControl, , Long_Irons_lvl_10, 0
	}
	else
	{
		GuiControl, enable, Long_Irons_lvl_9
		GuiControl, enable, Long_Irons_lvl_10
	}
gui, submit, nohide
this_club_lvl =
loop, 10
	if (Long_Irons_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
if !this_club_lvl
{
	GuiControl,,Long_Irons_code_button, Long_Iron
	GuiControl, disable, Long_Irons_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	GuiControl,,Long_Irons_code_button, 0
	LV_Delete()
	return
}

GuiControl,,Long_Irons_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Long_Irons_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Long_Irons_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return




window_update_Short_Irons_club:
gui, submit, nohide
this_club_cat := "Short_Irons"
loop, parse, Short_Irons, |
{
	if (%A_LoopField% = 1)
	{
		this_club := A_LoopField
		break
	}
}
if this_club in %epics%
{
	GuiControl, disable, Short_Irons_lvl_9
	GuiControl, , Short_Irons_lvl_9, 0
	GuiControl, disable, Short_Irons_lvl_10
	GuiControl, , Short_Irons_lvl_10, 0
}
else
	if this_club in %rares%
	{
		GuiControl, enable, Short_Irons_lvl_9
		GuiControl, disable, Short_Irons_lvl_10
		GuiControl, , Short_Irons_lvl_10, 0
	}
	else
	{
		GuiControl, enable, Short_Irons_lvl_9
		GuiControl, enable, Short_Irons_lvl_10
	}
Gui, submit, nohide
this_club_lvl =
loop, 10
	if (Short_Irons_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
if !this_club_lvl
{
	GuiControl,,Short_Irons_code_button, Short_Iron
	GuiControl, disable, Short_Irons_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Short_Irons_code_button, 0
	return
}

GuiControl,,Short_Irons_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Short_Irons_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Short_Irons_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return




window_update_Wedges_club:
gui, submit, nohide
this_club_cat := "Wedges"
loop, parse, Wedges, |
{
	if (%A_LoopField% = 1)
	{
		this_club := A_LoopField
		break
	}
}
if this_club in %epics%
{
	GuiControl, disable, Wedges_lvl_9
	GuiControl, , Wedges_lvl_9, 0
	GuiControl, disable, Wedges_lvl_10
	GuiControl, , Wedges_lvl_10, 0
}
else
	if this_club in %rares%
	{
		GuiControl, enable, Wedges_lvl_9
		GuiControl, disable, Wedges_lvl_10
		GuiControl, , Wedges_lvl_10, 0
	}
	else
	{
		GuiControl, enable, Wedges_lvl_9
		GuiControl, enable, Wedges_lvl_10
	}
Gui, submit, nohide
this_club_lvl =
loop, 10
	if (Wedges_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
if !this_club_lvl
{
	GuiControl,,Wedges_code_button, Wedge
	GuiControl, disable, Wedges_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Wedges_code_button, 0
	return
}

GuiControl,,Wedges_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Wedges_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Wedges_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return




window_update_rough_irons_club:
gui, submit, nohide
this_club_cat := "rough_irons"
loop, parse, rough_irons, |
{
	if (%A_LoopField% = 1)
	{
		this_club := A_LoopField
		break
	}
}
if this_club in %epics%
{
	GuiControl, disable, rough_irons_lvl_9
	GuiControl, , rough_irons_lvl_9, 0
	GuiControl, disable, rough_irons_lvl_10
	GuiControl, , rough_irons_lvl_10, 0
}
else
	if this_club in %rares%
	{
		GuiControl, enable, rough_irons_lvl_9
		GuiControl, disable, rough_irons_lvl_10
		GuiControl, , rough_irons_lvl_10, 0
	}
	else
	{
		GuiControl, enable, rough_irons_lvl_9
		GuiControl, enable, rough_irons_lvl_10
	}
gui, submit, nohide
this_club_lvl =
loop, 10
	if (rough_irons_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
if !this_club_lvl
{
	GuiControl,,rough_irons_code_button, rough_iron
	GuiControl, disable, rough_irons_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,rough_irons_code_button, 0
	return
}

GuiControl,,rough_irons_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, rough_irons_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,rough_irons_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return




window_update_sand_wedges_club:
gui, submit, nohide
this_club_cat := "sand_wedges"
loop, parse, sand_wedges, |
{
	if (%A_LoopField% = 1)
	{
		this_club := A_LoopField
		break
	}
}
if this_club in %epics%
{
	GuiControl, disable, sand_wedges_lvl_9
	GuiControl, , sand_wedges_lvl_9, 0
	GuiControl, disable, sand_wedges_lvl_10
	GuiControl, , sand_wedges_lvl_10, 0
}
else
	if this_club in %rares%
	{
		GuiControl, enable, sand_wedges_lvl_9
		GuiControl, disable, sand_wedges_lvl_10
		GuiControl, , sand_wedges_lvl_10, 0
	}
	else
	{
		GuiControl, enable, sand_wedges_lvl_9
		GuiControl, enable, sand_wedges_lvl_10
	}
Gui, submit, nohide
this_club_lvl =
loop, 10
	if (sand_wedges_lvl_%A_Index% = 1)
		this_club_lvl := A_Index
if !this_club_lvl
{
	GuiControl,,sand_wedges_code_button, sand_wedge
	GuiControl, disable, sand_wedges_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,sand_wedges_code_button, 0
	return
}

GuiControl,,sand_wedges_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, sand_wedges_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,sand_wedges_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return








;window_update_%cat%_level
{

window_update_Drivers_level:
this_club_cat := "Drivers"
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
this_club_lvl := arr%arr0%
gui, submit, nohide
this_club =
loop, parse, Drivers, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
if !this_club
{
	GuiControl,,Drivers_code_button, Driver
	GuiControl, disable, Drivers_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Drivers_code_button, 0
	return
}

GuiControl,,Drivers_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Drivers_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Drivers_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





window_update_Woods_level:
this_club_cat := "Woods"
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
this_club_lvl := arr%arr0%
gui, submit, nohide
this_club =
loop, parse, Woods, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
if !this_club
{
	GuiControl,,Woods_code_button, Wood
	GuiControl, disable, Woods_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Woods_code_button, 0
	return
}

GuiControl,,Woods_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Woods_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Woods_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





window_update_Long_Irons_level:
this_club_cat := "Long_Irons"
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
this_club_lvl := arr%arr0%
gui, submit, nohide
this_club =
loop, parse, Long_Irons, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
if !this_club
{
	GuiControl,,Long_Irons_code_button, Long_Iron
	GuiControl, disable, Long_Irons_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Long_Irons_code_button, 0
	return
}

GuiControl,,Long_Irons_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Long_Irons_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Long_Irons_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





window_update_Short_Irons_level:
this_club_cat := "Short_Irons"
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
this_club_lvl := arr%arr0%
gui, submit, nohide
this_club =
loop, parse, Short_Irons, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
if !this_club
{
	GuiControl,,Short_Irons_code_button, Short_Iron
	GuiControl, disable, Short_Irons_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Short_Irons_code_button, 0
	return
}

GuiControl,,Short_Irons_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Short_Irons_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Short_Irons_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





window_update_Wedges_level:
this_club_cat := "Wedges"
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
this_club_lvl := arr%arr0%
gui, submit, nohide
this_club =
loop, parse, Wedges, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
if !this_club
{
	GuiControl,,Wedges_code_button, Wedge
	GuiControl, disable, Wedges_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Wedges_code_button, 0
	return
}

GuiControl,,Wedges_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Wedges_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Wedges_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





window_update_Rough_Irons_level:
this_club_cat := "Rough_Irons"
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
this_club_lvl := arr%arr0%
gui, submit, nohide
this_club =
loop, parse, Rough_Irons, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
if !this_club
{
	GuiControl,,Rough_Irons_code_button, Rough_Iron
	GuiControl, disable, Rough_Irons_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Rough_Irons_code_button, 0
	return
}

GuiControl,,Rough_Irons_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Rough_Irons_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Rough_Irons_code_button, 1
gosub, calculate_rings
ControlClick,Edit2,Fake Wind Chum ahk_class AutoHotkeyGUI,, L, 3, x5 y5
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return





window_update_Sand_Wedges_level:
this_club_cat := "Sand_Wedges"
StringSplit, arr, A_GuiControl, _     ;arr0 is number of items
this_club_lvl := arr%arr0%
gui, submit, nohide
this_club =
loop, parse, Sand_Wedges, |
	if (%A_LoopField% = 1)
		this_club := A_LoopField
if !this_club
{
	GuiControl,,Sand_Wedges_code_button, Sand_Wedge
	GuiControl, disable, Sand_Wedges_code_button
	loop, 5
		GuiControl, disable, save_bag%A_Index%
	LV_Delete()
	GuiControl,,Sand_Wedges_code_button, 0
	return
}

GuiControl,,Sand_Wedges_code_button, %this_club% Lvl %this_club_lvl%
GuiControl, enable, Sand_Wedges_code_button
gosub, enable_save_golf_bag_buttons
GuiControl,,Sand_Wedges_code_button, 1
gosub, calculate_rings
ControlFocus, Edit2, Fake Wind Chum ahk_class AutoHotkeyGUI
ControlSend, Edit2, +{end}, Fake Wind Chum ahk_class AutoHotkeyGUI
return

}





window_update_wind:
gui, submit, nohide
StringReplace, wind_chk, wind, .
If (StrLen(wind_chk) >= 2 )
{
	wind := Round(wind_chk/10,1)
	GuiControl,, wind, %wind%
	ControlSend, Edit2, {end}, Fake Wind Chum ahk_class AutoHotkeyGUI
}
gosub, calculate_rings
return








window_update_elevation:
gui, submit, nohide
gosub, calculate_rings
return






window_update_slider:
calculate_rings:
gui, submit, nohide
GuiControl, , slider_pos, %club_distance%
IniRead, wind_per_ring, %gc_ini_file%, %this_club_cat%, %this_club%%this_club_lvl%, oops
if (wind_per_ring = "oops")
{
	ToolTip, an error occurred
	SetTimer, endtt, -5000
	return
}

StringReplace,elevation,elevation, `%
elevation := trim(elevation)
elevation += 0

if (ball_power < 6)
	adj := 1 - (0.0119 * (6 -ball_power))
else
	if (ball_power = 6)
		adj := 1
	else
		if (ball_power > 6)
			adj := 1 + (0.0119 * (ball_power - 6))



StringSplit, arr, wind_per_ring, |     ;arr0 is number of items
max_rings := Round(((wind/arr1) * (1 + elevation/100))*adj,1)
mid_rings := Round(((wind/arr2) * (1 + elevation/100))*adj,1)
min_rings := Round(((wind/arr3) * (1 + elevation/100))*adj,1)
25p_rings := Round((min_rings + mid_rings)/2,1)
75p_rings := Round((max_rings + mid_rings)/2,1)

if this_club_cat in Wedges,Rough_Irons,Sand_Wedges
{
	min_rings_actual = 0	;actual min amount as there is no min club distance
	25p_rings_actual := Round(max_rings * .25,1)
}
else
{
	min_rings_actual := min_rings
	25p_rings_actual := 25p_rings
}

max_min_diff := max_rings - min_rings_actual
true_club_rings := Round(min_rings_actual + (max_min_diff * (club_distance/100)), 1)

GuiControl,,ring_adj, %true_club_rings%

GuiControl,,max_rings_txt, Max: %max_rings%
GuiControl,,75p_rings_txt, 75`%: %75p_rings%
GuiControl,,mid_rings_txt, Mid: %mid_rings%
GuiControl,,25p_rings_txt, 25`%: %25p_rings_actual%
GuiControl,,min_rings_txt, Min: %min_rings_actual%


if (endbringer_school = 1)
{
	loop, 26
	{
		num := 135 - (A_Index * 5)
		eb_rings := Round(min_rings_actual + (max_min_diff * (num/100)), 1)
		GuiControl, , ebs%num%, %num%`%: %eb_rings%
	}
}



if !(last_club = this_club) or !(last_club_lvl = this_club_lvl)
{
	IniRead, power, %gc_stats_ini_file%, %this_club_cat%, %this_club%%this_club_lvl%_power
	IniRead, accuracy, %gc_stats_ini_file%, %this_club_cat%, %this_club%%this_club_lvl%_accuracy
	IniRead, top_spin, %gc_stats_ini_file%, %this_club_cat%, %this_club%%this_club_lvl%_top_spin
	IniRead, back_spin, %gc_stats_ini_file%, %this_club_cat%, %this_club%%this_club_lvl%_back_spin
	IniRead, curl, %gc_stats_ini_file%, %this_club_cat%, %this_club%%this_club_lvl%_curl
	IniRead, ball_guide, %gc_stats_ini_file%, %this_club_cat%, %this_club%%this_club_lvl%_ball_guide

	LV_Delete()
	LV_Add(,"Club", this_club)
	LV_Add(,"Level", this_club_lvl)
	LV_Add(,"Power", power)
	LV_Add(,"Accuracy", accuracy)
	LV_Add(,"Top Spin", top_spin)
	LV_Add(,"Back Spin", back_spin)
	LV_Add(,"Curl", curl)
	LV_Add(,"Ball Guide", ball_guide)

	GuiControl, , club_distance, 100
}

if !(this_club = last_club)
	if this_club in %epics%
	{
		GuiControl, disable, %this_club_cat%_lvl_9
		GuiControl, disable, %this_club_cat%_lvl_10
	}
	else
		if this_club in %rares%
		{
			GuiControl, enable, %this_club_cat%_lvl_9
			GuiControl, disable, %this_club_cat%_lvl_10
		}
		else
		{
			GuiControl, enable, %this_club_cat%_lvl_9
			GuiControl, enable, %this_club_cat%_lvl_10
		}


last_club := this_club
last_club_cat := this_club_cat
last_club_lvl := this_club_lvl
return



endtt:
SetTimer, %A_ThisLabel%, off
ToolTip,
return


Guiclose:
PostMessage, 0x111, 65405,,, checkpoint_challenge_pic_backup.ahk - AutoHotkey ahk_class AutoHotkey
ExitApp
return


;~ #Include %A_ScriptDir%\checkpoint_challenge.ahk



#IfWinActive Fake Wind Chum ahk_class AutoHotkeyGUI
WheelUp::gosub, wheel_wind
WheelDown::gosub, wheel_wind
!e::gosub, endbringer_school
n::gosub, next_hole
p::gosub, prev_hole
#IfWinActive



edit_course_pic:
run, edit `"%course_pic%`"
return




Guicontextmenu:
if !playing_hole_timer_on
{
	if (A_GuiControl = "course_pic")
	{
		Menu, context, Add
		Menu, context, DeleteAll
		Menu, context, add, Open the image for editing, edit_course_pic
		Menu, context, show
	}
	return
}
settimer, playing_hole_timer, off
pht_reset = 1
gosub, play_hole
pht_reset =
return

;~ GuiWidth = 1920
;~ GuiHeight = 998
;~ GuiControlGet, cName, Name, %A_GuiControl%
;~ GuiControlGet, cPos, Pos, %A_GuiControl%
;~ IniRead, cList, %gc_other_ini_file%, Controls, cList
;~ if !InStr(cList, cName)
	;~ IniWrite, %cList%|%cName%, %gc_other_ini_file%, Controls, cList
;~ xperc := Round(cPosx/GuiWidth, 4)
;~ yperc := Round(cPosy/GuiHeight, 4)
;~ wperc := Round(cPosw/GuiWidth, 4)
;~ hperc := Round(cPosh/GuiHeight, 4)
;~ IniWrite, %xperc%|%yperc%|%wperc%|%hperc%, %gc_other_ini_file%, Controls, %cName%_pos
;~ tooltip, %cName%`n%xperc%|%yperc%|%wperc%|%hperc%
;~ SetTimer, endtt, 3000
;~ return

;~ mbutton::
;~ GuiWidth = 1920
;~ GuiHeight = 998
;~ IniRead, cList, %gc_other_ini_file%, Controls, cList
;~ if !InStr(cList, varctrl)
	;~ IniWrite, %cList%|%varctrl%, %gc_other_ini_file%, Controls, cList
;~ MouseGetPos, VarX, VarY, VarWin, VarCtrl
;~ ControlGetPos, cX, cY, cW, cH, %varctrl%, ahk_id %varwin%
;~ cy -= 25
;~ xperc := Round(cx/GuiWidth, 4)
;~ yperc := Round(cy/GuiHeight, 4)
;~ wperc := Round(cw/GuiWidth, 4)
;~ hperc := Round(ch/GuiHeight, 4)
;~ IniWrite, %xperc%|%yperc%|%wperc%|%hperc%, %gc_other_ini_file%, Controls, %varctrl%_pos
;~ tooltip, %varctrl%`n%xperc%|%yperc%|%wperc%|%hperc%
;~ SetTimer, endtt, 3000
;~ return


Guisize:
if (A_GuiWidth = 0) or (A_GuiHeight = 0)
	return
If (cList = " ") and ( !(A_GuiWidth=last_GuiWidth) or !(A_GuiHeight=last_GuiHeight) )
{
	MsgBox, Error. Cannot find resize info (%gc_other_ini_file%). The program cannot continue and will exit now.
	ExitApp
}
loop, parse, cList, |
{
	this_ctrl := A_LoopField
	IniRead, %this_ctrl%_pos, %gc_other_ini_file%, Controls, %this_ctrl%_pos, %A_Space%
	if (%this_ctrl%_pos = " ")
	{
		MsgBox, Can't find resize info for %this_ctrl%. Continuing...
		continue
	}
	StringSplit, arr, %this_ctrl%_pos, |     ;arr0 is number of items
	GuiControl, move, %this_ctrl%, % "x" arr1*A_GuiWidth "y" arr2*A_GuiHeight "w" arr3*A_GuiWidth "h" arr4*A_GuiHeight
}
last_guiwidth := A_GuiWidth
last_guiheight := A_GuiHeight
WinSet, Redraw,, Fake Wind Chum ahk_class AutoHotkeyGUI
return


redraw_gui:
WinSet, Redraw,, Fake Wind Chum ahk_class AutoHotkeyGUI
return



	;~ if last_guiheight and last_guiwidth and !(A_GuiHeight - last_guiheight = 0) and !(A_GuiWidth - last_guiwidth = 0)
	;~ {
		;~ k_fontsize := (1 + ( (0.5 * (A_GuiWidth - last_guiwidth)/last_guiwidth) + (0.5 * (A_GuiHeight - last_guiheight)/last_guiheight) ) ) * k_fontsize
		;~ k_fontsize2 := k_fontsize * 1.07
		;~ k_fontsize3 := k_fontsize * 3.4
		;~ k_fontsize80p := k_fontsize * 0.97625
		;~ k_fontsize70p := k_fontsize * 0.88
		;~ k_fontsize60p := k_fontsize * 0.75
		;~ if InStr(this_ctrl, "Hdr_text") or InStr(this_ctrl, "header")
		;~ {
			;~ Gui, Font, norm bold underline s%k_fontsize2%, %k_font%
			;~ GuiControl, Font, %this_ctrl%
		;~ }
		;~ else
			;~ if !InStr(this_ctrl, "ebs") and !InStr(this_ctrl, "ring_adj") and !InStr(this_ctrl, "club_info")
			;~ {
				;~ Gui, Font, norm s%k_fontsize%, %k_font%
				;~ GuiControl, Font, %this_ctrl%
			;~ }
			;~ else
				;~ if (this_ctrl = "ring_adj")
				;~ {
					;~ Gui, Font, norm s%k_fontsize3%, %k_font2%
					;~ GuiControl, Font, %this_ctrl%
				;~ }
				;~ else
					;~ if (this_ctrl = "club_info")
					;~ {
						;~ Gui, Font, norm s%k_fontsize80p%, %k_font%
						;~ GuiControl, Font, %this_ctrl%
					;~ }
	;~ }
