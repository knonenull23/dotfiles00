#!/bin/sh

# DISPLAY=:1 xininfo  # and click, to get information about x11 window 
# sleep 5 && DISPLAY=:1 xdotool search --name 'WINDOW' windowmove 0 0 windowsize 100% 100% &
termux-x11 :1 -xstartup 'startxfce4'
