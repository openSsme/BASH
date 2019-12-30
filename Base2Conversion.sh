#!/bin/bash

n=$1
convert=`echo "obase=2; $n" |bc`
extract=`echo $convert |tr -d '0'`
solution=`echo ${#extract}`
echo $solution
