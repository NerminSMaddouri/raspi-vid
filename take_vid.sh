#!/bin/bash - 


play_time=3000
flip_vert=""
flip_hori=""

if [[ $# = 1 ]]; then 
  play_time=$1
fi



for arg in "$@"; do
  case $arg in
    --length=*)
      play_time="${arg:9}"
      ;;
    --flipv)
      flip_vert="-vf"
      ;;
    --fliph)
      flip_hori="-hf"
      ;;
  esac
done


raspivid -w 960 -h 540 $flip_vert $flip_hori -t $play_time
