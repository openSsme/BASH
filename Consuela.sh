#!/bin/bash

## Consuela is here to clean your mess
## Consuela utilizes lemon pledge (dd) for best cleaning results

ROOT_UID=0
E_NOROOT=13
E_WRONGARGS=22
E_NO_SUCH_FILE=2
ARGS=2
COUNTER=0
PARAMS=("--limpiar" "--descanso" "--ayuda")
#------------------------------------------------------------------------------
Limpiar(){
	SIZE=`ls -og "$1" |awk '{print $3'}`
	echo -e "\nok i clean $1 - $SIZE now\n"
	sync
	dd if=/dev/zero of="$1" bs=$SIZE count=1 iflag=fullblock 2>/dev/null
	sync
	echo "Wipe 1"
	tr '\0' '1' < /dev/zero |dd of="$1" bs=$SIZE count=1 iflag=fullblock 2>/dev/null
	sync
	echo "Wipe 2"
	dd if=/dev/urandom of="$1" bs=$SIZE count=1 iflag=fullblock 2>/dev/null
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
		echo -e "\nConsuela!, clean here: $1"
		Limpiar_Duro $1
		echo -e "\nphew.. limpié $COUNTER objetos. we need more lemon pledge! adiós :|\n"
	elif [[ ! -d $1 && -s $1 ]]
	then
		echo -e "\nConsuela!, clean this: $1"
		Limpiar $1
		echo -e "\nok i go now.. adiós :|\n"
	else
		echo -e "\nnnno.. no.. is already clean :|\n"
	fi
}

#------------------------------------------------------------------------------

if [ $UID -ne $ROOT_UID  ]
then
	echo "\nno.. mister root no home :|\n"
	exit $E_NOROOT
fi

if [[ $# -ne $ARGS && $1 != ${PARAMS[2]} ]]
then
	echo "Usage: Consuela [--command] [option], --ayuda shows help"
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

if [ $1 = ${PARAMS[1]} ]
then
	SIZE=$2
	for (( i=0;i<10;i++ ))
	do
		MC=`mcookie`
		dd if=/dev/urandom of=$MC bs=$SIZE count=1 iflag=fullblock 2>/dev/null
		DETAILS=`ls -hog $MC`
		echo "This was already broken :|	: $DETAILS"
	done
fi

if [ $1 = ${PARAMS[2]} ]
then
	echo -e "\nConsuela is here to clean your mess"
	echo -e "Consuela utilizes lemon pledge (dd) for best cleaning results\n"
	echo -e "\nCOMMANDS:"
	echo -e "	--limpiar <path/target>		:	securely wipe a single file or recursively wipe the contents of a directory"
	echo -e "	--descanso <block size>		:	creates 10 random files with a specified block size"
	echo -e "	--ayuda				:	show this screen\n"
	echo -e "EXAMPLES:"
	echo -e "	Clean a single file inside a directory:"
	echo -e "		Consuela --limpiar Dir1/Dir2/ab47b5e2c4b4d7ea4a19feaa71084d88.iso\n"
	echo -e "	Clean an entire directory and its sub-directories:"
	echo -e "		Consuela --limpiar Dir1/Dir2\n"
	echo -e "	Create 10 files of 100M worth of testing junk in current directory:"
	echo -e "		Consuela --descanso 100M\n"
fi
