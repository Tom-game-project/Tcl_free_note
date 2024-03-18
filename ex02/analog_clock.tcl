# Analog Clocks

proc degree2position {a length resolution} {
    set pi [expr 2.0 * asin(1.0)]
    set step [expr 360 / $resolution]
    set theta [expr $step * $a - 90]
    return [list [expr 150 + $length * cos(2 * $pi * $theta / 360)] [expr 150 + $length * sin(2 * $pi * $theta / 360)]]
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


proc show_time {} {
    # show time
    global buffer
    set length 100
    set buffer [clock format [clock seconds] -format "%H:%M:%S"]
    set h [clock format [clock seconds] -format "%H"]
    set m [clock format [clock seconds] -format "%M"]
    set s [clock format [clock seconds] -format "%S"]
    .c create line 150 150 150 150 -fill red -arrow last -width 2
    after 1000 show_time
}

wm title . clock
wm minsize . 200 50

# setting font
option add *font {FixedSys 16}

canvas .c -width 300 -height 300 -bg #9e9e9e
pack .c -in .

.c create oval 10 10 290 290 -fill pink
set_num 120

show_time