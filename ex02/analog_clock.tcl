# Analog Clocks
# 
# 


# @param a
# @param length
# @param resolution
# @returns position_array[2]
proc degree2position {a length resolution} {
    global width
    set center_x [expr $width / 2]
    set center_y [expr $width / 2]
    set pi [expr 2.0 * asin(1.0)]
    set step [expr 360 / $resolution]
    set theta [expr $step * $a - 90]
    return [list\
        [expr $center_x + $length * cos(2 * $pi * $theta / 360.0)]\
        [expr $center_y + $length * sin(2 * $pi * $theta / 360.0)]\
    ]
}

proc set_num {length} {
    set pi [expr 2.0 * asin(1.0)]
    set nums_id_list []
    for {set index 1} {$index <= 12} {incr index} {
        set theta [expr 30 * $index - 90]
        lappend nums_id_list [.c create text \
        [degree2position $index $length 12]\
        -anchor c -font Purisa -text $index ]
    }
    return $nums_id_list
}

# return unique object id
proc set_oval {center_position r} {
   return [.c create oval [list [expr $center_position - $r] [expr $center_position - $r] [expr $center_position + $r] [expr $center_position + $r]] -fill pink]
}

proc draw_oval {center_position r} {
    global oval_id
    .c coords $oval_id [list [expr $center_position - $r] [expr $center_position - $r] [expr $center_position + $r] [expr $center_position + $r]]
}


# 
proc draw_num {length} {
    global nums_id_list
    set pi [expr 2.0 * asin(1.0)]
    set index 1
    foreach num_id $nums_id_list {
        .c coords $num_id [degree2position $index $length 12]
        incr index
    }
}

proc draw_hand {x y h_length m_length s_length} {
    global seconds_id
    global minutes_id
    global hours_id
    scan [clock format [clock seconds] -format "%H"] "%d" h
    scan [clock format [clock seconds] -format "%M"] "%d" m
    scan [clock format [clock seconds] -format "%S"] "%d" s
    set args [list $x $y]
    .c coords $seconds_id [concat $args [degree2position $s $s_length 60.0]]
    .c coords $minutes_id [concat $args [degree2position $m $m_length 60.0]]
    .c coords $hours_id   [concat $args [degree2position [expr ($h % 12) * 60 + $m] $h_length [expr 60.0 * 12.0]]]
}

proc floop {} {
    global width
    draw_hand \
        [expr $width / 2.0]\
        [expr $width / 2.0]\
        [expr $width / 6.0]\
        [expr $width / 3.0]\
        [expr $width / 3.0]
    after 500 floop
}

proc window_size_changed {} {
    global width
    set w [winfo width .c]
    set h [winfo height .c]
    if {$w > $h} {
        set width $h
    } else {
        set width $w
    }
    draw_num [expr 0.4 * $width]
    draw_oval [expr $width / 2.0] [expr $width * 0.5]
    draw_hand \
        [expr $width / 2.0]\
        [expr $width / 2.0]\
        [expr $width / 6.0]\
        [expr $width / 3.0]\
        [expr $width / 3.0]
}

wm title   . clock
wm minsize . 200 50

# setting font
option add *font {FixedSys 16}

canvas .c -width 300 -height 300 -bg #9e9e9e
pack   .c -in . -expand 1 -fill both

# bind setting
# on changed window size
bind .c <Configure> window_size_changed

set width 300


# .c create oval [list 10 10 290 290] -fill pink
set oval_id [set_oval 150 [expr $width * 0.5]]
# 1 - 12番までに割り当てられたidが格納される
set nums_id_list [set_num 120]
puts $nums_id_list 


scan [clock format [clock seconds] -format "%I"] "%d" h
scan [clock format [clock seconds] -format "%M"] "%d" m
scan [clock format [clock seconds] -format "%S"] "%d" s
set args [list [expr $width / 2.0] [expr $width / 2.0]]
set seconds_id [.c create line [concat $args [degree2position $s 100 60]] -fill red   -arrow last -width 2]
set minutes_id [.c create line [concat $args [degree2position $m 100 60]] -fill black -arrow last -width 5]
set hours_id   [.c create line [concat $args [degree2position $s 100 60]] -fill black -arrow last -width 5]

# default clock width

# start loop
floop

