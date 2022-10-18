#!/bin/bash -

current_hour=$(date +"%H")
mode=auto
output_dir=time-lapse-street-two
sleep_for=30
width=960
height=540

mkdir -p $output_dir

# Between 8pm (20) and 7am use night exposure mode.
# However, the computer time is returning the hour 2 hours ahead,
# so just adjust by adding 2.

while true; do
  current_hour=$(date +"%H")
  if [[ "${current_hour#0}" -gt 21 || "${current_hour#0}" -lt 9 ]]; then
    mode=night
  fi
  current_datetime=$(date +"%FT%H-%M-%S%Z")
  raspistill -w "$width" -h "$height" -ex "$mode" --nopreview -o "$output_dir/${current_datetime}.jpg"
  sleep $sleep_for
done
