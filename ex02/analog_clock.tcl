# Analog Clocks

proc degree2position {a length resolution} {
    set pi [expr 2.0 * asin(1.0)]
    set step [expr 360 / $resolution]
    set theta [expr $step * $a - 90]
    return [list\
        [expr 150 + $length * cos(2 * $pi * $theta / 360.0)]\
        [expr 150 + $length * sin(2 * $pi * $theta / 360.0)]\
    ]
}

proc set_num {length} {
    set pi [expr 2.0 * asin(1.0)]
    for {set index 1} {$index <= 12} {incr index} {
        set theta [expr 30 * $index - 90]
        .c create text \
        [degree2position $index 120 12]\
        -anchor c -font Purisa -text $index 
    }
}

proc floop {} {
    global seconds_id
    global minutes_id
    global hours_id
    set length 100
    scan [clock format [clock seconds] -format "%H"] "%d" h
    scan [clock format [clock seconds] -format "%M"] "%d" m
    scan [clock format [clock seconds] -format "%S"] "%d" s
    set args [list 150 150]
    .c coords $seconds_id [concat $args [degree2position $s 100 60.0]]
    .c coords $minutes_id [concat $args [degree2position $m 100 60.0]]
    .c coords $hours_id   [concat $args [degree2position [expr ($h % 12) * 60 + $m] 50 [expr 60.0 * 12.0]]]
    after 500 floop
}

wm title   . clock
wm minsize . 200 50

# setting font
option add *font {FixedSys 16}

canvas .c -width 300 -height 300 -bg #9e9e9e
pack   .c -in .

.c create oval [list 10 10 290 290] -fill pink
set_num 120

scan [clock format [clock seconds] -format "%I"] "%d" h
scan [clock format [clock seconds] -format "%M"] "%d" m
scan [clock format [clock seconds] -format "%S"] "%d" s
set args [list 150 150]
set seconds_id [.c create line [concat $args [degree2position $s 100 60]] -fill red   -arrow last -width 2]
set minutes_id [.c create line [concat $args [degree2position $m 100 60]] -fill black -arrow last -width 5]
set hours_id   [.c create line [concat $args [degree2position $s 100 60]] -fill black -arrow last -width 5]

floop

