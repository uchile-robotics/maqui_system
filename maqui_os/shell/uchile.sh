#!/bin/sh

# Can modify

export ROS_MASTER_URI=http://192.168.1.126:11311
export ROS_IP=192.168.1.126
export ROS_NETWORK_INTERFACE=wlan0

export UCHILE_ROBOT="maqui"

export robot_ip="127.0.0.1"
export robot_port="9559"
export FACE_DETECTOR="naoqi"
export PERSON_DETECTOR="naoqi"

# WARNING!
# Don't modify unless you know what you are doing!

export UCHILE_WS="${HOME}/uchile_ws"
export UCHILE_ROS_WS="${UCHILE_WS}/ros"
export UCHILE_PKGS_WS="${UCHILE_WS}/pkgs"
export UCHILE_SYSTEM="${UCHILE_WS}"
export UCHILE_SHELL="${UCHILE_WS}/.shell/"
export UCHILE_SHELL_CFG=${HOME}/uchile.sh
export EDITOR=nano

source ${UCHILE_ROS_WS}/forks_ws/devel/setup.bash
source ${UCHILE_ROS_WS}/base_ws/devel/setup.bash
source ${UCHILE_ROS_WS}/soft_ws/devel/setup.bash
source ${UCHILE_ROS_WS}/high_ws/devel/setup.bash

#source $UCHILE_SHELL/setup.sh # comment if dont want to overload the shell (i.e. in testing robocup scenarios)
