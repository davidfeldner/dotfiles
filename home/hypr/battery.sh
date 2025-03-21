#!/bin/sh

# Control variable
# Possible values: NONE, FULL, LOW, CRITICAL
last="NONE"

# Default values for LOW/CRITICAL status
low=25
critical=15

while true; do

  # If battery is plugged, do stuff
  battery="/sys/class/power_supply/BAT0"
  if [ -d $battery ]; then

    capacity=$(cat $battery/capacity)
    status=$(cat $battery/status)

    # If battery full and not already warned about that
    if [ "$last" != "FULL" ] && [ "$status" = "Full" ]; then
      notify-send " Battery full. Remove the adapter!"
      last="FULL"
    fi

    # If low and discharging
    if [ "$last" != "LOW" ] && [ "$status" = "Discharging" ] &&
      [ $capacity -le $low ]; then
      notify-send " Battery low: $capacity%. Plug in the adapter!"
      last=LOW
    fi

    # If critical and discharging
    if [ "$status" = "Discharging" ] && [ $capacity -le $critical ]; then
      notify-send -u critical " Battery very low: $capacity%. Plug in the adapter!!!"
      last=CRITICAL
    fi
  fi
  sleep 1000
done
