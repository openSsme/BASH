#!/bin/bash

ROOT_UID=0
E_NOROOT=13

identify(){
  cols=`tput cols`
  split=`printf '%0.s#' $(seq 1 $cols)`
  systemctl list-machines; echo $split
  free -hw; echo $split
  cat /etc/*release*; echo $split
  pvscan; echo ""
  pvdisplay; echo $split
  vgscan; echo ""
  vgdisplay; echo $split
  lvscan; echo ""
  lvdisplay; echo $split
  cat /etc/fstab; echo $split
  fdisk -l /dev/sd*; echo $split
  ip addr; echo $split
  L_USR=(`w -h |awk '{print $1}'`)
  for i in "${L_USR[@]}"; do
    R_PROC=`ps x -u $i --no-headers |wc -l`
    echo -e "$i Running: $R_PROC" #TODO: fix this nonsense
  done; echo $split
  systemctl list-units |grep service; echo $split
  systemctl list-units |grep target; echo $split
  systemctl list-sockets; echo $split
}

useradd(){
  PASS=`echo "d3f@Lt pA55w0Rd Mu5t 8e Ch@n63d" |openssl passwd -stdin -6`
  sudo groupadd -g 509 $1-509
  mkdir /mnt/$1509
  chgrp $1-509 /mnt/$1509
  chmod 2775 /mnt/$1509
  for (( i=0;i<20;i++ )); do
    sudo useradd -c "$1-Clone$i" -p $PASS -m "$1-$i"
    sudo usermod -aG "$1-509" "$1-$i"
  done
  exit 0
}

if [ $UID -ne $ROOT_UID  ]; then
	echo "not gonna happen. get root!"
	exit $E_NOROOT
fi

case $1 in
  add)
    useradd $2;;

  id)
    identify;;
esac
