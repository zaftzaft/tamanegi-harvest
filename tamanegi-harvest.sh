#!/bin/sh

basedir=/opt/tamanegi-harvest
logdir=$basedir/log
monthdir=$logdir/`date +%Y%m`
logprefix=$monthdir/`date +%Y%m%d`
rawfilename=$logprefix.raw.txt
addrfilename=$logprefix.addr.txt

mkdir -p $logdir
mkdir -p $monthdir

curl https://check.torproject.org/exit-addresses -s -o $rawfilename

cat $rawfilename | grep Addr | cut -f 2 -d " " > $addrfilename
