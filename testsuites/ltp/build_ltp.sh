#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 cvs_server_addr arch_type"
    echo "Please append SVN repository ip address and arch type"
    exit 1
fi       

cvs_server_addr=$1
arch_type=$2
CWD=`pwd`
LTP_SUB_DIR=ltp-full-20120903


# Remove old ltp source directory
if [ -d $LTP_SUB_DIR ]
then
    rm -rf $LTP_SUB_DIR
    echo "$0:	Clean directory"
fi


# Checkout ltp source directory
echo "$0:	Checking out from SVN, ltp/$LTP_SUB_DIR"
svn -q co svn://$cvs_server_addr/ltp/trunk/$LTP_SUB_DIR
if [ $? -ne 0 ]
then
    echo "$0:	Error, SVN checkout failed"
    exit 1
fi


# Go to working directory
echo "$0:	Go to working directory"
cd $LTP_SUB_DIR


# configure ltp
echo "$0:	Configure ..."
if [ $arch_type == "arm" ] ; then
    ./configure --prefix=$CWD/$LTP_SUB_DIR/installation --host=arm-none-linux-gnueabi --build=i686-pc-linux-gnu > /dev/null 2>&1
elif [ $arch_type == "blackfin" ] ; then
    ./configure --prefix=$CWD/$LTP_SUB_DIR/installation --host=bfin-uclinux --build=i686-pc-linux-gnu LDFLAGS="-elf2flt=-s65536" > /dev/null 2>&1
fi
if [ $? -ne 0 ]
then
    echo "$0:	Error, configure failed" 
    exit 1
fi


## We don't need patch for Makefile now ##
# Patch for Makefiles
#echo "$0:	Patching Makefiles"
#patch -p0 < ../Makefile.patch
#if [ $? -ne 0 ]
#then
#	echo "$0:	Error, patching Makefiles failed"
#	exit 1
#fi


# Build ltp testsuites
echo "$0:	Make ..."
if [ $arch_type == "arm" ] ; then
    make all > /dev/null 2>&1
elif [ $arch_type == "blackfin" ] ; then
    make UCLINUX=1 > /dev/null 2>&1
fi

if [ $? -ne 0 ]
then
    echo "$0:	Error, make failed" 
    exit 1
fi


# Install ltp testsuites
echo "$0:	make install ..."
if [ $arch_type == "arm" ] ; then
    make install > /dev/null 2>&1
elif [ $arch_type == "blackfin" ] ; then
    make UCLINUX=1 install > /dev/null 2>&1
fi

if [ $? -ne 0 ]
then
    echo "$0:	Error, make install failed" 
    exit 1
fi
echo "$0:	LTP build done"

cd $CWD
exit 0
