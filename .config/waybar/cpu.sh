#!/bin/sh
read -r _ a1 b1 c1 d1 e1 f1 g1 h1 _ < /proc/stat
sleep 0.5
read -r _ a2 b2 c2 d2 e2 f2 g2 h2 _ < /proc/stat
idle=$(( (d2 + e2) - (d1 + e1) ))
total=$(( (a2+b2+c2+d2+e2+f2+g2+h2) - (a1+b1+c1+d1+e1+f1+g1+h1) ))
[ "$total" -gt 0 ] && usage=$(( 100 * (total - idle) / total )) || usage=0
for h in /sys/class/hwmon/hwmon*; do
  if [ "$(cat "$h/name")" = "k10temp" ]; then
    temp=$(( $(cat "$h/temp1_input") / 1000 ))
    break
  fi
done
echo "CPU ${usage}% ${temp}°C"
