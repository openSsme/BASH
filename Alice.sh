#!/bin/bash

# Who the fuck is alice

MESS=(18 11 7 3 13 14 8 10 1 4 5 2 9 12 6 17 15 16)
n=`echo ${#MESS[@]}`
echo -e "\n$n members in:	(${MESS[@]})\n"
sort(){
	for i in ${MESS[@]}
	do
		./Bob.sh $i
	done; echo ""
}
sort 0
