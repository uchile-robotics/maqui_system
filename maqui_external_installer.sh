#!/bin/bash

mkdir -p maqui_ws/src
cd maqui_ws

# Add repositories
wstool init src https://raw.githubusercontent.com/uchile-robotics/maqui_system/master/maqui_external.rosinstall

# Install system and ROS dependencies
rosdep install -i -y --from-paths src

# Build
sudo apt-get install python-catkin-tools
catkin build --summarize

# Add source file to bashrc (bash user)
echo "source ~/maqui_ws/devel/setup.bash" >> ~/.bashrc
# zsh users
# echo "source ~/maqui_ws/devel/setup.zsh" >> ~/.zshrc

# Install Pepper meshes on maqui_ws/src/pepper_meshes
./devel/tmp/installer.run --prefix ~/maqui_ws/src/pepper_meshes --mode unattended

cat << EOF
# Test in a new terminal
# Open RViz with Pepper model
    roslaunch pepper_description display.launch
# Open Gazebo with Pepper robot
# Remember kill "Gazebo controllers" terminal first
    roslaunch maqui_sim maqui.launch
EOF
