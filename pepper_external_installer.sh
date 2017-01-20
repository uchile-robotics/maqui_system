#!/bin/bash

mkdir -p pepper_ws/src
wget -O .rosinstall
rosws update
cd ..
catkin_make
