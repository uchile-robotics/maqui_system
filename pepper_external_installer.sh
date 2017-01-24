#!/bin/bash

mkdir -p pepper_ws/src
cd pepper_ws/src
catkin_init_workspace
wget https://raw.githubusercontent.com/uchile-robotics/pepper_system/master/pepper_external.rosinstall -O .rosinstall
rosws update
# Install system and ROS dependencies
rosdep install -i -y --from-paths .
cd ..
catkin_make
# Add source file to bashrc
echo "source ~/pepper_ws/devel/setup.bash" >> ~/.bashrc

# Install Pepper meshes on pepper_ws/src/pepper_meshes
./devel/tmp/installer.run

# Test in a new terminal
# Open Rviz with Pepper model
roslaunch pepper_description display.launch
# Open Gazebo with Pepper robot
# Remember kill "Gazebo controllers" terminal first
roslaunch pepper_gazebo_plugin pepper_gazebo.launch
