club_cats = Drivers|Woods|Long_Irons|Short_Irons|Wedges|Rough_Irons|Sand_Wedges
Drivers = Rocket|Extra_Mile|Big_Topper|Quarterback|Rock|Thors_Hammer|Apocalypse
Woods = Horizon|Viper|Big_Dawg|Hammerhead|Guardian|Sniper|Cataclysm
Long_Irons = Grim_Reaper|Backbone|Goliath|Saturn|B52|Grizzly|Tsunami
Short_Irons = Apache|Kingfisher|Runner|Thorn|Hornet|Claw|Falcon
Wedges = Dart|FireFly|Boomerang|Down_In_One|Skewer|Endbringer|Rapier
Rough_Irons = Roughcutter|Junglist|Machete|Off_Roader|Razor|Amazon|Nirvana
Sand_Wedges = Castaway|Desert_Storm|Malibu|Sahara|Sand_Lizard|Houdini|Spitfire
k_fontsize = 11
small_hor_space := k_fontsize * 11.1
large_hor_space := k_fontsize * 12.75
larger_hor_space := k_fontsize * 15


Gui, +resize +Minsize1699x904
Gui, color, FFFFFF


loop, parse, club_cats, |
{
	cat := A_LoopField
	StringUpper, u_cat, cat
	StringSplit, %cat%, %cat%, |     ;arr0 is number of items

	Gui, Add, text, x%xpos% y%ypos% v%cat%_header, %u_cat%

	loop, parse, %cat%, |
	{
		club := A_LoopField
		Gui, Add, radio, +0x1000 xp y+10 w%k_button_width_small% gwindow_update_%cat%_club v%club%, %club%
	}

	xpos += large_hor_space

	if (A_Index = 1)
		ebs_x := xpos + 1.15 * input_width_small

	Gui, Add, text, x%xpos% y%ypos% v%cat%_lvl_header, LEVEL

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




Gui, add, text, x%ebs_x% ys vebs0 hidden, ENDBRINGER SCHOOL
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

Gui, Add, edit, x1031 y479 w100 vring_adj ReadOnly center, 0
Gui, Add, text, x855 y479 vslider_pos center, 100

Gui, add, text, x10 y330 w200 center vgolf_bagsHdr_text backgroundtrans, %A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%Golf Bags%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%
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

Gui, add, button, x%xpos% ys+15 gendbringer_school vebsButton, Endbringer School
Gui, add, button, xp y+10 gtourney1_notes vtourneyNotes1Button, Tournament 1 Notes
Gui, add, button, xp y+10 gtourney2_notes vtourneyNotes2Button, Tournament 2 Notes
Gui, add, button, xp y+10 greset_clubs_and_levels vreset_clubs_and_levels_Button, Reset clubs/levels

Gui, add, text, x+10 ys W200 center vclubInfo_header, CLUB INFORMATION
Gui, Add, ListView, xp-3 y+3 r8 w200 -Hdr Grid Count8 CBlack BackgroundWhite +ReadOnly vclub_info section, Attribute|Value

Gui, add, edit, section vwind gwindow_update_wind center, 0
Gui, add, text, x+1 yp+3 vmph_text, mph

Gui, add, text, vwindHdr_text, Wind

Gui, add, text, vball_powerHdr_text, Ball Power
Gui, add, ddl, section vball_power gwindow_update_wind center, 0|1|2|3|4|5|6||7|8|9|10

Gui, add, text, x%xpos% y%ypos% velevationHdr_text, Elevation
Gui, add, combobox, xp-2 y+0 w%input_width% velevation gwindow_update_elevation, -65`%|-60`%|-50`%|-45`%|-40`%|-35`%|-30`%|-25`%|-20`%|-15`%|-10`%|-5`%|0`%|5`%|10`%||15`%|20`%|25`%|30`%|35`%|40`%|45`%|50`%|55`%|60`%|65`%

Gui, add, text, x%xpos% y%ypos% vclub_distanceHdr_text, Club Distance
Gui, Add, Slider, x%xpos% y+5 w%slider_length% vclub_distance Buddy2ring_adj Buddy1slider_pos Line2 ToolTip AltSubmit TickInterval10 gwindow_update_slider section, 100

Gui, Add, text, xs+%xpos% y%ypos% w171 h25 vring_adjHdr_text center section, RINGS TO ADJUST

Gui, add, text, x%xpos% y%ypos% w%wpos% h23 vmin_rings_txt, Min:
Gui, add, text, xp y+2 w%wpos% h23 v25p_rings_txt, 25`%:
Gui, add, text, xp y+2 w%wpos% h23 vmid_rings_txt, Mid:
Gui, add, text, xp y+2 w%wpos% h23 v75p_rings_txt, 75`%:
Gui, add, text, xp y+2 w%wpos% h23 vmax_rings_txt, Max:

xpos = 5
ypos = 632
loop, parse, club_cats, |
{
	StringTrimRight, cat_no_s, A_LoopField, 1
	Gui, add, radio, +0x1000 x%xpos% y%ypos% w170 h%k_button_height% v%A_LoopField%_code_button disabled gwindow_update_%A_LoopField%_code_button, %cat_no_s%
	xpos += 175
	ypos := "p"
}

Gui, Add, Button, x%xpos% y395 w131 h30 gcourse_selecter vselect_courses_button, Select Courses

Gui, Add, Text, xp y+5 w110 h20 section vcourseHdr_text, Course

Iniread, courses, %gc_other_ini_file%, Main, last_courses
sort, courses, D|
courses .= "| |"

Gui, Add, combobox, xp y+2 w160 vcourse gload_data section, %courses%

Gui, Add, Text, xs y+5 w110 h20 vholeHdr_text, Hole

Gui, Add, combobox, xp y+2 w40 vhole gload_data section center, 1|2|3|4|5|6|7|8|9

Gui, Add, Text, x+10 yp-5 hidden vpar, Par 4

Gui, Add, Text, xs y+%ypos% h23 vshot1hdr_text gprep_shot1 section, Shot 1
Gui, Add, Text, xs y+5 h23 vshot2Hdr_text gprep_shot2, Shot 2


Gui, Add, Text, x+%k_fontsize% ys-%ypos% w68 h23 vcourse_hole_elevationHdr_text section, Elevation
Gui, Add, Text, vcourse_hole_clubHdr_text, Club

Gui, Add, Edit, center velevation1 section,
Gui, Add, Edit, center velevation2,

Gui, Add, combobox, vclub_cat1, driver|wood|long_Iron|short_Iron|Wedge|Rough_Iron|Sand_Wedge|%A_Space%
Gui, Add, combobox, vclub_cat2 section, wood|long_Iron|short_Iron|Wedge|Rough_Iron|Sand_Wedge|%A_Space%

Gui, Add, Button, gsave_data vcourse_hole_SaveInfoHdr_button, Save
Gui, Add, Button, gplay_hole vplay_hole_button, Play Hole
Gui, Add, Button, gplay_next_hole vplay_next_hole_button disabled section, Play Next Hole

Gui, add, picture, vcourse_pic ggoto_gct_website BackgroundTrans, I:\Pictures\GC_holes\FWC_BlankImage.png

Gui, add, text, vHole_notesHdr_txt, Notes
Gui, add, edit, multi vHole_notes gsave_hole_notes disabled,
