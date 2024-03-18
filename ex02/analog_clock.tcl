# Analog Clocks



wm title . clock
wm minsize . 200 50

# setting font
option add *font {FixedSys 16}

# setting label
# set buffer "hello world"
# label .l0 -textvariable buffer
# pack .l0 -in .

canvas .c -width 300 -height 300 -bg #9e9e9e
pack .c -in .

# .c create arc 20 20 280 280 -start 0 -extent 270 -fill yellow
# .c create arc 20 20 280 280 -start 270 -extent 90 -fill red
#.c create text 10 30 -anchor w -font Consolas -text "hello world"

.c create oval 10 10 290 290 -fill pink

.c create line 150 150 280 150 -fill red -arrow last -width 3