#!/bin/bash

## Consuela is here to clean your mess
## Consuela utilizes lemon pledge (dd) for best cleaning results

ROOT_UID=0
E_NOROOT=13
E_WRONGARGS=22
E_404=2
ARGS=2
COUNTER=0
#------------------------------------------------------------------------------
Limpiar(){ # TODO: SOLVE TIME COMPLEXION WITH ANSIBLE/DOCKER + STREAM WINDOW
	SIZE=`ls -og "$1" |awk '{print $3'}`
	echo -e "\nok now i clean $1 for \$$SIZE\n"
	sync
	dd if=/dev/zero of="$1" bs=$SIZE count=1 iflag=fullblock 1>&- 2>&-
	sync
	echo "Wipe 1"
	tr '\0' '1' < /dev/zero |dd of="$1" bs=$SIZE count=1 iflag=fullblock 1>&- 2>&-
	sync
	echo "Wipe 2"
	dd if=/dev/urandom of="$1" bs=$SIZE count=1 iflag=fullblock 1>&- 2>&-
	sync
	echo "Wipe 3"
	rm -f "$1"
	sync
	echo "Polish"
}

Limpiar_Duro(){
	readarray -t SUB < <(ls -1 $1)
	for i in "${SUB[@]}"; do
		if [ -d "$1/$i" ]; then
			Limpiar_Duro "$1/$i"
		elif [[ ! -d "$1/$i" && -s "$1/$i" ]]; then
			Limpiar "$1/$i"
			let "COUNTER+=1"
		fi
	done
}

Consuela(){
	echo "Hola.. :|"
	if [ -e $1 ]; then
		while true; do
			if [[ -d $1 && -s $1 ]]; then
				echo -e "\nConsuela!, clean here: $1"
				Limpiar_Duro $1
				if [ $COUNTER -ne 0 ]; then
					echo -e "\nphew.. limpié $COUNTER objetos. we need more lemon pledge!\n"
					let "COUNTER=0"
				else
					echo -e "\nnnno.. no.. is already clean in there :|\n"
				fi
			elif [[ ! -d $1 && -s $1 ]]; then
				echo -e "\nConsuela!, clean this: $1"
				Limpiar $1
				echo -e "\nok i go now.. adiós :|\n"
				break
			else
				echo -e "\nnnno.. no.. is already clean :|\n"
				break
			fi
			sleep 5
		done
	else
		echo -e "\nno.. no veu $1 :|\n"
		exit $E_404
	fi
	exit 0
}

#------------------------------------------------------------------------------

if [ $UID -ne $ROOT_UID  ]; then
	echo "\nno.. mister root no home :|\n"
	exit $E_NOROOT
fi

if [[ $# -ne $ARGS && $1 != "--ayuda" ]]; then
	echo "Usage: Consuela [--limpiar] <directory/file>"
	echo "       Consuela [--descanso] <100M>"
	echo "       Consuela [--ayuda]"
	exit $E_WRONGARGS
fi

case "$1" in
	--limpiar)
		Consuela $2;;

	--descanso)
		SIZE=$2
		for (( i=0;i<10;i++ )); do
			MC=`mcookie`
			dd if=/dev/urandom of=$MC bs=$SIZE count=1 iflag=fullblock 2>/dev/null
			DETAILS=`ls -hog $MC`
			echo "This was already broken :|	 $DETAILS"
			exit 0
		done;;

	--ayuda)
		echo -e "\nConsuela is here to clean your mess"
		echo -e "Consuela utilizes lemon pledge (dd) for best cleaning results"
		echo -e "Consuela charges \$1 per byte\n\n"
		echo -e "COMMANDS:"
		echo -e "	--limpiar <path/target>		:	securely wipe a single file or recursively wipe the contents of a directory"
		echo -e "	--descanso <block size>		:	creates 10 random files with a specified block size"
		echo -e "	--ayuda				:	show this screen\n"
		echo -e "EXAMPLES:"
		echo -e "	Clean a single file inside a directory:"
		echo -e "		Consuela --limpiar Dir1/Dir2/ab47b5e2c4b4d7ea4a19feaa71084d88.iso\n"
		echo -e "	Clean an entire directory and its sub-directories:"
		echo -e "		Consuela --limpiar Dir1/Dir2\n"
		echo -e "	Create 10 files of 100M worth of testing junk in current directory:"
		echo -e "		Consuela --descanso 100M\n";;
		
esac
