#!/bin/sh
STATE="${XDG_RUNTIME_DIR:-/tmp}/nightlight-on"
TEMP=1000
case "$1" in
  toggle)
    if [ -f "$STATE" ]; then
      hyprctl hyprsunset identity
      rm -f "$STATE"
    else
      hyprctl hyprsunset temperature "$TEMP"
      touch "$STATE"
    fi
    pkill -RTMIN+8 waybar
    ;;
  *)
    if [ -f "$STATE" ]; then
      echo '{"text":"NIGHT ON","class":"on"}'
    else
      echo '{"text":"NIGHT OFF","class":"off"}'
    fi
    ;;
esac
