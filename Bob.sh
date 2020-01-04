#!/bin/bash

# me like pie

process(){
  for (( i = 0; i < $1; i++ )); do
    echo "PIE!!!"
  done
}

case $1 in
  )
    process;;
esac
