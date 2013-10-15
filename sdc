#!/bin/sh
set -x

make savedefconfig
make linux-savedefconfig

mv defconfig ~/KV/buildroot/bf533-perch_defconfig
mv output/build/linux-custom/defconfig ~/KV/buildroot/BF533-PERCH_defconfig
