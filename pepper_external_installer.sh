#!/bin/bash

mkdir -p pepper_ws/src
cd pepper_ws/src
catkin_init_workspace
wget https://raw.githubusercontent.com/uchile-robotics/pepper_system/master/pepper_external.rosinstall -O .rosinstall
rosws update
cd ..
catkin_make
echo "source ~/pepper_ws/devel/setup.bash" >> ~/.bashrc

# Install Pepper meshes on pepper_ws/src/pepper_meshes
./devel/tmp/installer.run



