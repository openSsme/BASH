#!/bin/bash

## Consuela is here to clean your mess
## Consuela utilizes lemon pledge (dd) for securely cleaning your mess

ROOT_UID=0
E_NOROOT=13
E_WRONGARGS=22
E_NO_SUCH_FILE=2
ARGS=2
COUNTER=0
declare -a PARAMS
PARAMS+=("--limpiar" "--ayuda" "--nuell")

Limpiar(){
	DIRT_SIZE=`ls -og "$1" |awk '{print $3'}`
	echo -e "\nok i clean $1 - $DIRT_SIZE now\n"
	sync
	dd if=/dev/zero of="$1" bs=$DIRT_SIZE count=1 iflag=fullblock 2>/dev/null
	sync
	echo "Wipe 1"
	tr '\0' '1' < /dev/zero |dd of="$1" bs=$DIRT_SIZE count=1 iflag=fullblock 2>/dev/null
	sync
	echo "Wipe 2"
	dd if=/dev/urandom of="$1" bs=$DIRT_SIZE count=1 iflag=fullblock 2>/dev/null
	sync
	echo "Wipe 3"
	rm -f "$1"
	sync
	echo "Polish"
}

Limpiar_Duro(){
	readarray -t SUB < <(ls -1 $1)
	for i in "${SUB[@]}"
	do
		if [ -d "$1/$i" ]
		then
			Limpiar_Duro "$1/$i"
		else
			Limpiar "$1/$i"
			let "COUNTER+=1"
		fi
	done
}

Consuela(){
	echo "Hola.. :|"
	if [ -d $1 ]
	then
		Limpiar_Duro $1
		echo -e "\nphew..limpié $COUNTER cosas. ok adiós :|\n"
	elif [[ ! -d $1 && -s $1 ]]
	then
		Limpiar $1
		echo -e "\nok i go now.. adiós :|\n"
	else
		echo -e "\nno.. no.. no :|\n"
	fi
}

if [ $UID -ne $ROOT_UID  ]
then
	echo "\nno.. mister root no home :|\n"
	exit $E_NOROOT
fi

if [[ $# -ne $ARGS || $1 = ${PARAMS[1]} ]]
then
	echo "Usage: `basename $0` ${PARAMS[0]} [this] : clean something, ${PARAMS[1]} : show help"
	exit $E_WRONGARGS
fi

if [ $1 = ${PARAMS[0]} ]
then
	if [ -e $2 ]
	then
		Consuela $2
		exit 0
	else
		echo -e "\nno.. no veu $2 :|\n"
		exit $E_NO_SUCH_FILE
	fi
fi

if [ $1 = ${PARAMS[2]} ]
then
	DIRT_SIZE=$2
	for (( i=0;i<10;i++ ))
	do
		MC=`mcookie`
		dd if=/dev/urandom of=$MC bs=$DIRT_SIZE count=1 iflag=fullblock 2>/dev/null
		echo "I made a mess :} - $MC"
	done
fi
