#!/bin/bash

mkdir -p maqui_ws/src
cd maqui_ws

# Add repositories
wstool init src https://raw.githubusercontent.com/uchile-robotics/maqui_system/master/maqui_external.rosinstall

# Install system and ROS dependencies
rosdep install -i -y --from-paths src

# this just finishes here!, dont know why, but anything at this point is not called.
