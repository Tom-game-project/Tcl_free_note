# Analog Clocks

proc show_time {args} {
    global buffer
    # show time
    set buffer [clock format [clock seconds] -format "%h:%m:%s"]

    set h [clock format [clock seconds] -format "%H"]
    set m [clock format [clock seconds] -format "%M"]
    set s [clock format [clock seconds] -format "%S"]
    set h [expr $h + 1]
    puts $h
    puts $m
    puts $s
    after 1000 show_time
}


wm title . clock
wm minsize . 200 50

# setting font
option add *font {FixedSys 16}

# setting label
label .l0 -textvariable buffer
pack .l0

show_time
