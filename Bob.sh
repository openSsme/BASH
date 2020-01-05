#!/bin/bash

# me like pie
# TODO: Process a sort algo
process(){
  for (( i = 0; i < $1; i++ )); do
    echo "PIE!!! - $1"
  done
}

case $1 in # Using a switch here for "Hachana Lemazgan"
    -p)
      for i in $@; do
        if [ -n $i ]; then
            process $i
        fi
      done;;
esac
