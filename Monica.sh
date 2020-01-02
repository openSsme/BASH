#!/bin/bash

identify(){
  L_USERS=(`w -h |awk '{print $1}'`)
  R_PROC=`ps ux --no-headers |wc -l`
  echo $R_PROC
  echo $L_USERS
}

useradd(){
  PASS=`echo "d3f@Lt pA55w0Rd Mu5t 8e Ch@n63d" |openssl passwd -stdin -6`
  useradd -c "Shaqed's Clone$i" -m Clone$i -p $PASS
}
