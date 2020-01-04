#!/bin/bash

# me like pie

process(){
  for (( i = 0; i < $1; i++ )); do
    echo "PIE!!! - $1"
  done
}

case $1 in
    -p)
      for i in $@; do
        if [ -n $i ]; then
          for i in $*; do
            process $i
          done
        fi
      done;;
esac
