#!/bin/bash

BUILD_DIR=$1/output/build/libbfgdots-*
TARGET_DIR=$1/output/target

cd $BUILD_DIR
mkdir -p $TARGET_DIR/g729
cp -fr test/* $TARGET_DIR/g729
cp src.fdpic/libg729ab.so $TARGET_DIR/lib

cd $TARGET_DIR/g729
rm *.c *.o *.gdb Makefile quick.sh
