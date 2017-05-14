#!/bin/bash


# NAOQI
#--------------------------------
cd ~
mkdir pepper_dep

# qibuild 3.8.3, newest version required CMake 2.8.12
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/qibuild/archive/v3.8.3.tar.gz -O qibuild-3.8.3.tar.gz
tar -xvzf qibuild-3.8.3.tar.gz
mkdir -p qibuild-3.8.3/build
cd qibuild-3.8.3/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps   
make
sudo make install

# libqiprobes 2.4
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/libqiprobes/archive/release-2.4.tar.gz -O libqiprobes-2.4.tar.gz
tar -xvzf libqiprobes-2.4.tar.gz
mkdir -p libqiprobes-release-2.4/build
cd libqiprobes-release-2.4/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps   
make
sudo make install

# libqi 2.3, newest version required -std=gnu++11
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/libqi/archive/v2.3.tar.gz -O libqi-2.3.tar.gz
tar -xvzf libqi-2.3.tar.gz
mkdir -p libqi-2.3/build
cd libqi-2.3/build
cmake .. -DQI_WITH_TESTS=OFF -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps   
make
sudo make install


# ROS deps
#--------------------------------

# m4 1.4.16
cd ~/pepper_dep
wget https://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.gz
tar -xvzf m4-1.4.16.tar.gz
cd m4-1.4.16
./configure --prefix=/home/nao/external_deps
make
sudo make install

# autoconf 2.69
cd ~/pepper_dep
wget https://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
tar -xvzf autoconf-2.69.tar.gz 
cd autoconf-2.69
./configure --prefix=/home/nao/external_deps
make
sudo make install

# automake 1.15
cd ~/pepper_dep
wget http://git.savannah.gnu.org/cgit/automake.git/snapshot/automake-1.15.tar.gz
tar -xvzf automake-1.15.tar.gz
cd automake-1.15
./bootstrap.sh
./configure --prefix=/home/nao/external_deps
make
sudo make install

# libtool 2.4.6
cd ~/pepper_dep
wget https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
tar -xvzf libtool-2.4.6.tar.gz 
cd libtool-2.4.6
./configure --prefix=/home/nao/external_deps
make
sudo make install

# apr 1.5.2
cd ~/pepper_dep
wget http://www-eu.apache.org/dist/apr/apr-1.5.2.tar.gz
tar -xvzf apr-1.5.2.tar.gz
cd apr-1.5.2/
./configure --prefix=/home/nao/external_deps
make
sudo make install

# apr util 1.5.4
cd ~/pepper_dep
wget http://www-us.apache.org/dist/apr/apr-util-1.5.4.tar.gz
tar -xvzf apr-util-1.5.4.tar.gz
cd apr-util-1.5.4/
./configure --with-apr=/usr/local/apr --prefix=/home/nao/external_deps
make
sudo make install

# Apache log4cxx
# @TODO Test with realease
cd ~/pepper_dep
git clone https://github.com/uchile-robotics-forks/log4cxx
cd log4cxx
./autogen.sh
./configure --prefix=/home/nao/external_deps
make
sudo make install

# yaml cpp
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/yaml-cpp/archive/yaml-cpp-0.5.3.tar.gz
tar -xvzf yaml-cpp-0.5.3.tar.gz
mkdir -p yaml-cpp-yaml-cpp-0.5.3/build
cd yaml-cpp-yaml-cpp-0.5.3/build
cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/home/nao/ros/indigo 
make
sudo make install

# tinyxml 2.6.2
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/tinyxml/archive/v2.6.2.tar.gz -O tinyxml-2.6.2.tar.gz
tar -xvzf tinyxml-2.6.2.tar.gz
mkdir -p tinyxml-2.6.2/build
cd tinyxml-2.6.2/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps
make
sudo make install

# console bridge 0.2.5
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/console_bridge/archive/0.2.5.tar.gz -O console_bridge-0.2.5.tar.gz
tar -xvzf console_bridge-0.2.5.tar.gz
mkdir -p console_bridge-0.2.5/build
cd console_bridge-0.2.5/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps
make
sudo make install

# lz4 r131
cd ~/pepper_dep
wget https://github.com/lz4/lz4/archive/r131.tar.gz -O lz4-r131.tar.gz
tar -xvzf lz4-r131.tar.gz
cd lz4-r131/ 
#change the install prefix in the Makefile
make
sudo make install

# poco 1.6.1
cd ~/pepper_dep
wget http://pocoproject.org/releases/poco-1.6.1/poco-1.6.1.tar.gz
tar -xvzf poco-1.6.1.tar.gz
cd poco-1.6.1/
./configure --prefix=/home/nao/external_deps
make
sudo make install

# gtest 1.7.0
cd ~/pepper_dep
wget https://github.com/google/googletest/archive/release-1.7.0.tar.gz
tar -xvzf release-1.7.0.tar.gz
cd googletest-release-1.7.0/
cmake . -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps
make
sudo cp -a include/gtest /usr/include
sudo cp -a libgtest_main.so libgtest.so /usr/lib/

# eigen
cd ~/pepper_dep
wget http://bitbucket.org/eigen/eigen/get/3.3.1.tar.gz -O eigen-3.3.1.tar.gz
tar -xvzf eigen-3.3.1.tar.gz
mkdir -p eigen-eigen-f562a193118d/build
cd eigen-eigen-f562a193118d/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps
make
sudo make install

# collada dom
cd ~/pepper_dep
wget https://github.com/rdiankov/collada-dom/archive/v2.4.4.tar.gz -O collada-dom-2.4.4.tar.gz
tar -xvzf collada-dom-2.4.4.tar.gz
mkdir -p collada-dom-2.4.4/build
cd collada-dom-2.4.4/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps
make
sudo make install

# urdfdom_headers
cd ~/pepper_dep
wget https://github.com/ros/urdfdom_headers/archive/0.2.3.tar.gz -O urdfdom_headers-0.2.3.tar.gz
tar -xvzf urdfdom_headers-0.2.3.tar.gz
mkdir -p urdfdom_headers-0.2.3/build
cd urdfdom_headers-0.2.3/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps
make
sudo make install

# urdf dom
cd ~/pepper_dep
wget https://github.com/ros/urdfdom/archive/0.2.10.tar.gz -O urdfdom-0.2.10.tar.gz
tar -xvzf urdfdom-0.2.10.tar.gz
mkdir -p urdfdom-0.2.10/build
cd urdfdom-0.2.10/build
cmake .. -DCMAKE_INSTALL_PREFIX=/home/nao/external_deps
sudo make install

# ROS Python deps
#--------------------------------

# netifaces
cd ~/pepper_dep
wget https://bitbucket.org/uchile-robotics-die/netifaces/get/release_0_10_4.tar.gz -O netifaces-0.10.4.tar.gz
tar -xvzf netifaces-0.10.4.tar.gz
cd uchile-robotics-die-netifaces-1d6d179f8bce/
sudo python setup.py install --prefix=/home/nao/external_deps

# sip
cd ~/pepper_dep
wget https://sourceforge.net/projects/pyqt/files/sip/sip-4.19/sip-4.19.tar.gz
tar -xvzf sip-4.19.tar.gz
cd sip-4.19
python configure.py 
make
sudo make install

sudo pip install -U pip --install-option="--prefix=/home/nao/external_deps"
sudo pip install -U six --install-option="--prefix=/home/nao/external_deps"
sudo pip install -U setuptools --install-option="--prefix=/home/nao/external_deps"
sudo pip install -U catkin_pkg rosdep rosinstall_generator wstool rosinstall empy nose rosinstall pillow mock coverage rospkg --install-option="--prefix=/home/nao/external_deps"

# ROS Base
#--------------------------------

# Add to bash profile
cat >> ~/.bash_profile <<"EOF"
export ROS_INSTALL_PREFIX=/home/nao/ros
export PYTHONPATH=$PYTHONPATH:${ROS_INSTALL_PREFIX}/indigo/lib/python2.7/site-packages:/home/nao/external_deps/lib/python2.7/site-packages
export PATH=$PATH:${ROS_INSTALL_PREFIX}/indigo/bin:/home/nao/external_deps/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib:/usr/local/lib/:${ROS_INSTALL_PREFIX}/indigo/lib:/home/nao/external_deps/lib

export ROS_MASTER_URI=http://localhost:11311
export ROS_HOSTNAME=localhost
source ${ROS_INSTALL_PREFIX}/indigo/setup.bash
EOF

