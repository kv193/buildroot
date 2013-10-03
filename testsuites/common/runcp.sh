#!/bin/sh

rm -rf /lib/modules
rm -rf /lib/libgfortran*
rm -rf /lib/libthread*
rm -rf /lib/libstdc*

SUBDIR=`ls / | grep -v mnt | grep -v proc | grep -v sys | grep -v usr | grep -v tmp`

for i in $SUBDIR
do
	cp -ar $i /mnt/rootfs
	echo "copy $i finish"
done

mkdir /mnt/rootfs/mnt
mkdir /mnt/rootfs/proc
mkdir /mnt/rootfs/tmp
mkdir /mnt/rootfs/sys
mkdir /mnt/rootfs/usr
mkdir /mnt/rootfs/usr/libexec
mkdir /mnt/rootfs/usr/bin

cp /usr/libexec/rshd /mnt/rootfs/usr/libexec
cp /usr/bin/rcp /mnt/rootfs/usr/bin
cp /usr/bin/rsh /mnt/rootfs/usr/bin

chmod 777 /usr/libexec/rshd /usr/bin/rcp /usr/bin/rsh

echo "copy rootfs done"
