#!/bin/bash

# Who the fuck is alice

MESS=(18 11 7 3 13 14 8 10 1 4 5 2 9 12 6 17 15 16)
SLAVES=(10.0.0.11 10.0.0.13 10.0.0.16 10.0.0.17)
n=`echo ${#MESS[@]}`
echo -e "\n$n members in:	(${MESS[@]})\n"
sort(){
	for i in ${SLAVES[@]}; do
		scp Bob.sh $i:/home/wcon
	done
	for i in ${SLAVES[@]}; do
		ssh $i ./Bob.sh -p ${MESS[@]} &
	done; echo ""
}
sort
