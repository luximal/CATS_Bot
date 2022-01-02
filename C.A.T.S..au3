;#######################################################
;
;		CATS: Crash Arena Turbo Stars bot by luximal
;		Version 0.1 beta
;
;#######################################################


;#######################################################
;	Hot Keys Section
;
; Set up a Hot key to be used later to end the script
;#######################################################
HotKeySet("{PAUSE}", "request_end")


;#######################################################
;	Globals
;#######################################################
$title = "C.A.T.S. Bot"
$win_title = "BlueStacks"
$tolerance = 0		; 0-255, color search tolerance
$search_step = 1	; 1-5


if not WinExists($win_title, "") then
	msg($win_title & " not run")
	Exit
else
	msg($win_title & " run. GO, GO, GO!!!")
endif


WinActivate($win_title, "")
WinSetOnTop($win_title, "", 0)
$size = WinGetPos("")
Sleep(500)


new_Battle()


;#######################################################
;	Start Quick Fight
;#######################################################
func new_Battle()

	Sleep(1000)

	$x = $size[0] + $size[2] * 0.8
	$y = $size[1] + $size[3] * 0.85
	MouseClick("left", $x, $y, 1, 10)   ;   Start Quick Fight

	find_health_bar()

	find_ok_button()

endfunc



;#######################################################
;	Find color 0xffffff from health bar
;#######################################################
func find_health_bar()
	; Coordinates health bar
    $left   = $size[0] + $size[2] * 0.8
    $top    = $size[1] + $size[3] * 0.13
    $right  = $size[0] + $size[2] * 0.85
    $bottom = $size[1] + $size[3] * 0.15
	;	mouse_move($left, $top, $right, $bottom, 20)

	while 1
		$pos = PixelSearch($left, $top, $right, $bottom, 0xffffff, $tolerance, $search_step)
		if @error then
			SetError(0)
		else
			$x = $size[0] + $size[2] * 0.5
			$y = $size[1] + $size[3] * 0.5
			MouseClick("left", $x, $y, 1, 5)   ;   Quick Fight
			ExitLoop
		endif
		Sleep(10)
	wend
endfunc

;#######################################################
;	Expect the end of the Quick Fight and
;	find color 0xd22325 from 'OK' button
;#######################################################
func find_ok_button()
	; Coordinates 'Œ ' buttons
	$left 	= $size[0] + $size[2] * 0.45
	$top 	= $size[1] + $size[3] * 0.9
	$right 	= $size[0] + $size[2] * 0.55
	$bottom = $size[1] + $size[3] * 0.8
	;	mouse_move($left, $top, $right, $bottom, 20)

	while 1
		$pos = PixelSearch($left, $top, $right, $bottom, 0xd22325, $tolerance, $search_step)
		if @error then
			SetError(0)
		else
			MouseClick("left", $pos[0], $pos[1], 1, 5)
			find_setting_icon()
		endif
		Sleep(10)
	wend
endfunc


;#######################################################
;	Find color 0xffffff from setting icon
;#######################################################
func find_setting_icon()
	; Coordinates setting icon
    $left   = $size[0] + $size[2] * 0.94
    $top    = $size[1] + $size[3] * 0.05
    $right  = $size[0] + $size[2] * 0.96
    $bottom = $size[1] + $size[3] * 0.04
	;	mouse_move($left, $top, $right, $bottom, 20)

	while 1
		$pos = PixelSearch($left, $top, $right, $bottom, 0xffffff, $tolerance, $search_step)
		if @error then
			SetError(0)
		else
			new_Battle()
		endif
		Sleep(10)
	wend
endfunc


;#######################################################
func request_end()
    $MB_YESNO = 4
    $MB_YES = 6
    if MsgBox($MB_YESNO, $title, "End script?") == $MB_YES then
        Exit
    endif
endfunc


;#######################################################
func msg($text)
	MsgBox(0, $title, $text)
endfunc


;#######################################################
func mouse_move($left, $top, $right, $bottom, $speed)
	MouseMove($left,	$top,	 $speed)
	MouseMove($right,	$top,	 $speed)
	MouseMove($right,	$bottom, $speed)
	MouseMove($left,	$bottom, $speed)
	MouseMove($left,	$top,	 $speed)
endfunc