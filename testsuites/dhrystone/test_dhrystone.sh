#!/bin/bash 
CC=bfin-uclinux-gcc
CFLAGS=
tmp=
cpu=
ITT=10000000
IP=$1
DIR=$2
DHRYSTONE_DIR="output/build/dhrystone-2"
cd $DIR
       cpu=`rsh -l root $IP 'grep "cpu MHz" /proc/cpuinfo' | awk -F ":" '{print $2}' | awk -F "/" '{print $1}' | sed 's/^[ \t]*//;s/[ \t]*$$//'` ;\
	echo "testing on $cpu MHz with $CC" ;\
	echo "^ Flags ((standard ''CFLAGS'' include ''OPTIMIZATION''))  ^  size (bytes)  ^  Loops  ^  Dhrystones per Second ((Based on $CC)) ^  Dhrystone MIPS ((DMIPS is obtained when the Dhrystone score is divided by 1,757 (the number of Dhrystones per second obtained on the VAX 11/780, nominally a 1 MIPS machine))  ^  DMIPS/MHz  ^";\
	( for level in -O{s,0,1,2,3}{" "," -fomit-frame-pointer"}{" "," -static"}{""," -ffast-math"}{""," -funroll-loops"}{""," -funsafe-loop-optimizations"} ; do \
	    if [ `echo $CC |grep uclibc|wc -l` -eq 1 -a `echo ${level} | grep static | wc -l` -eq 1 ] ; then \
		continue; \
	    fi; \
	    echo -n "| ''${level}'' " | sed 's/ [ ]*/ /g' | sed "s/ '' /''/" ; \
	    make -s dhrystone-clean-for-rebuild
	    make -s --no-print-directory dhrystone TARGET_OPTIMIZATION="$level" -w > /dev/null; \
	    rcp $DHRYSTONE_DIR/dhrystone root@$IP:/var/dhrystone ; \
	    tmp=`rsh -l root $IP /var/dhrystone $ITT` ;\
	    echo $cpu $tmp | awk '{print $NF "  |  " $NF/1757 "  |  " $NF/(1757*$1) "  |" }' ; \
	  done; \
	)
