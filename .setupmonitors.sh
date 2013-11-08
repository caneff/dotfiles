#!/bin/bash

echo "+ ${0}"

monitor_number=0
dvi_present=`xrandr | grep "DVI-I-1 connected"`
dvi_status="$?"
vga_present=`xrandr | grep "DP1 connected"`
vga_status="$?"

# LVDS1: 1280x800, 60.2
# VGA1 (eth): 1680x1050, 60.0


if [ "$vga_status" -ne "0" ]; then
    echo "- VGA1 NOT found, setting 1 monitor"
    xrandr --output LVDS1 --primary --auto
    xrandr --output DP1 --off
    monitor_number=1
elif [ "$dvi_status" -ne "0" ]; then
    echo "- VGA1 found, setting up 2 monitors"
    xrandr --output LVDS1 --auto
    xrandr --output DP1 --primary --auto --below LVDS1
    monitor_number=2
fi

echo "+ DONE (${0})"
