# Degital
# Degital Clock

proc show_time {} {
    # show time
    global buffer
    set buffer [clock format [clock seconds] -format "%H:%M:%S"]
    after 1000 show_time
}

# set title
wm title . clock
wm minsize . 200 50

# setting font
option add *font {FixedSys 16}

# setting label
label .l0 -textvariable buffer
pack .l0

show_time
