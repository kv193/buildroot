#!/bin/bash -x

export BOARD_CONFIG=$NODE_NAME
custom_workspace=$WORKSPACE
mkdir -p $custom_workspace/../../../../dl


# Set repository info
MAIN_PROJ_REPO_NAME=buildroot
TEST_FRAME_REPO_NAME=testsuites
KERNEL_REPO_NAME=kernel

use_local_src_server=1
SERVER_ADDR=10.99.29.20
TEST_FRAME_REPO_ADDR=git://$SERVER_ADDR/buildroot_test
KERNEL_REPO_ADDR=git://$SERVER_ADDR/linux-kernel


# Set branch info
INDEX=trunk
if [ "$INDEX" == "trunk" ] ; then
    MAIN_PROJ_INDEX=trunk
    TEST_FRAME_INDEX=trunk
    KERNEL_INDEX=trunk
elif [ "$INDEX" == "branch" ] ; then
    MAIN_PROJ_INDEX="2012R1"
    TEST_FRAME_INDEX="2012R1"
    KERNEL_INDEX="2012R1"
elif [ "$INDEX" == "tag" ] ; then
    MAIN_PROJ_INDEX="2012R1-RC6-BF60X"
    TEST_FRAME_INDEX="2012R1-RC6-BF60X"
    KERNEL_INDEX="2012R1-RC6-BF60X"
fi


# Link to real directory for downloading
cd $custom_workspace
ln -sf ../../../../dl


# check if use right source
debug=0

check_git_info ()
{
    echo "##########"
    if [ -d $custom_workspace ] ; then
        cd $custom_workspace
        git branch
        git remote -v
    fi


    if [ -d $custom_workspace/testsuites ] ; then
        cd $custom_workspace/testsuites
        git branch
        git remote -v
    fi

    if [ -d $custom_workspace/linux/linux-kernel ] ; then
        cd $custom_workspace/linux/linux-kernel
        git branch
        git remote -v
    fi
    echo "##########"
}

if [ $debug -eq 1 ] ; then
    check_git_info
fi


# Before checkout master project, fetch related info
cd $custom_workspace
git fetch -t git://$SERVER_ADDR/$MAIN_PROJ_REPO_NAME


# Checkout master project, switch to desired branch and get the latest source.
cd $custom_workspace
if [ "$INDEX" == "tag" ] || [ "`git branch | grep -c \"$MAIN_PROJ_INDEX\"`" -ne 0 ] ; then
    git checkout $MAIN_PROJ_INDEX
else
    git checkout -b $MAIN_PROJ_INDEX remotes/$MAIN_PROJ_REPO_NAME/$MAIN_PROJ_INDEX
fi

if [ "`git branch | grep -c \"$MAIN_PROJ_INDEX\"`" -ne 0 ] ; then
    git pull $MAIN_PROJ_REPO_NAME $MAIN_PROJ_INDEX
fi


# Use local submodule git server
cd $custom_workspace
git submodule init
if [ $use_local_src_server -eq 1 ] ; then
    git config submodule.testsuites.url $TEST_FRAME_REPO_ADDR
    git config submodule.linux/linux-kernel.url $KERNEL_REPO_ADDR
fi
git submodule update


if [ $debug -eq 1 ] ; then
    check_git_info
fi


# Checkout test frame and switch to desired branch/tag.
cd $custom_workspace/testsuites
git fetch -t $TEST_FRAME_REPO_ADDR
if [ "$INDEX" == "tag" ] || [ "`git branch | grep -c \"$TEST_FRAME_INDEX\"`" -ne 0 ] ; then
    git checkout $TEST_FRAME_INDEX
else
    git checkout -b $TEST_FRAME_INDEX remotes/origin/$TEST_FRAME_INDEX
fi


# Checkout kernel and switch to desired branch.
cd $custom_workspace/linux/linux-kernel
git fetch -t $KERNEL_REPO_ADDR
git checkout .
if [ "$INDEX" == "tag" ] || [ "`git branch | grep -c \"$KERNEL_INDEX\"`" -ne 0 ] ; then
    git checkout $KERNEL_INDEX
else
    git checkout -b $KERNEL_INDEX remotes/origin/$KERNEL_INDEX
fi


# Get the latest source for all submodules.
cd $custom_workspace/
if [ "$INDEX" != "tag" ] ; then
    git submodule foreach git pull
fi

if [ $debug -eq 1 ] ; then
    check_git_info
fi


# In WORKSPACE dir, make soft link to test log, so we can browse in hudson
rm -fr $WORKSPACE/thisrun $WORKSPACE/logs
ln -s /home/test/workspace/logs $WORKSPACE/logs


# Start regression test
cd $custom_workspace/testsuites/common/
./run_kernel_test

