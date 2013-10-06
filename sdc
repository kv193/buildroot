#!/bin/sh
set -x

make savedefconfig
make linux-savedefconfig

mv defconfig configs/bf533-perch_defconfig
mv output/build/linux-custom/defconfig linux/linux-kernel/arch/blackfin/configs/BF533-PERCH_defconfig
