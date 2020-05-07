#/bin/bash!

export LBLUE='\033[1;34m'
export RED='\033[1;31m'
export NC='\033[0m' # No Color
export sline="${LBLUE}#####################################"
export iline="#####################################${NC} "
export UCH_WS=${HOME}/uchile_ws
export PKGS=${UCH_WS}/pkgs
export ROS=${UCH_WS}/ros

export PP_INS=${PWD}

mkdir -p $ROS
mkdir -p $PKGS

cd $ROS 
mkdir -p forks_ws/src base_ws/src soft_ws/src high_ws/src

cd $PP_INS

bash maqui_install_forks_ws.sh
source $ROS/forks_ws/devel/setup.bash

bash maqui_install_base_ws.sh
source $ROS/base_ws/devel/setup.bash

bash maqui_install_soft_ws.sh
source $ROS/soft_ws/devel/setup.bash

bash maqui_install_high_ws.sh
source $ROS/high_ws/devel/setup.bash





