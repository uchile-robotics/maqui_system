#!/bin/bash

function _check_errno
{
    local status=$1
    if [ $status -ne 0 ]; then
        echo "[FAIL] Error with $2" | tee -a robot_install.log 1>&2
        return 1
    else
        echo "[OK] $2"
    fi
}
# NAOQI
#--------------------------------
cd ~
ROBOT_ROOT=~/maqui_root
echo "export ROBOT_ROOT=${ROBOT_ROOT}" >> .bash_profile
mkdir -p ${ROBOT_ROOT}/usr ${ROBOT_ROOT}/src ${ROBOT_ROOT}/usr/include ${ROBOT_ROOT}/usr/lib/python2.7/site-packages

# Empty PYTHONPATH for clean installation
export PYTHONPATH=${ROBOT_ROOT}/usr/lib/python2.7/site-packages
export PATH=${ROBOT_ROOT}/usr/bin:$PATH
export LD_LIBRARY_PATH=${ROBOT_ROOT}/usr/lib:$LD_LIBRARY_PATH

# qibuild 3.8.3, newest version required CMake 2.8.12
cd ${ROBOT_ROOT}/src
wget https://github.com/uchile-robotics-forks/qibuild/archive/v3.8.3.tar.gz -O qibuild-3.8.3.tar.gz
tar -xvzf qibuild-3.8.3.tar.gz
mkdir -p qibuild-3.8.3/build
cd qibuild-3.8.3/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "qibuild"

#export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:${ROBOT_ROOT}/usr/share/cmake


# libqiprobes 2.4
cd ${ROBOT_ROOT}/src
wget https://github.com/uchile-robotics-forks/libqiprobes/archive/release-2.4.tar.gz -O libqiprobes-2.4.tar.gz
tar -xvzf libqiprobes-2.4.tar.gz
mkdir -p libqiprobes-release-2.4/build
cd libqiprobes-release-2.4/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "libqiprobes"

# libqi 2.3, newest version required -std=gnu++11
cd ${ROBOT_ROOT}/src
wget https://github.com/uchile-robotics-forks/libqi/archive/v2.3.tar.gz -O libqi-2.3.tar.gz
tar -xvzf libqi-2.3.tar.gz
mkdir -p libqi-2.3/build
cd libqi-2.3/build
cmake .. -DQI_WITH_TESTS=OFF -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr   
make
make install
_check_errno $? "libqi"

# ROS deps
#--------------------------------

# m4 1.4.16
cd ${ROBOT_ROOT}/src
wget https://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.gz
tar -xvzf m4-1.4.16.tar.gz
cd m4-1.4.16
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "m4"

# autoconf 2.69
cd ${ROBOT_ROOT}/src
wget https://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
tar -xvzf autoconf-2.69.tar.gz 
cd autoconf-2.69
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "autoconf"

# automake 1.15
cd ${ROBOT_ROOT}/src
wget http://git.savannah.gnu.org/cgit/automake.git/snapshot/automake-1.15.tar.gz
tar -xvzf automake-1.15.tar.gz
cd automake-1.15
./bootstrap.sh
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "automake"

# libtool 2.4.6
cd ${ROBOT_ROOT}/src
wget https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
tar -xvzf libtool-2.4.6.tar.gz 
cd libtool-2.4.6
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "libtool"

# apr 1.5.2
cd ${ROBOT_ROOT}/src
wget http://www-eu.apache.org/dist/apr/apr-1.5.2.tar.gz
tar -xvzf apr-1.5.2.tar.gz
cd apr-1.5.2/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
ln -s ${ROBOT_ROOT}/usr/bin/apr-1-config ${ROBOT_ROOT}/usr/bin/apr-config 
_check_errno $? "apr"


# apr util 1.5.4
cd ${ROBOT_ROOT}/src
wget http://www-us.apache.org/dist/apr/apr-util-1.5.4.tar.gz
tar -xvzf apr-util-1.5.4.tar.gz
cd apr-util-1.5.4/
./configure --with-apr=${ROBOT_ROOT}/usr/bin/apr-config --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "apr-util"

# Apache log4cxx
# @TODO Test with realease, modification time issue
cd ${ROBOT_ROOT}/src
git clone https://github.com/uchile-robotics-forks/log4cxx
cd log4cxx
./autogen.sh
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "Apache log4cxx"

# yaml cpp
cd ${ROBOT_ROOT}/src
wget https://github.com/uchile-robotics-forks/yaml-cpp/archive/yaml-cpp-0.5.3.tar.gz
tar -xvzf yaml-cpp-0.5.3.tar.gz
mkdir -p yaml-cpp-yaml-cpp-0.5.3/build
cd yaml-cpp-yaml-cpp-0.5.3/build
cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/home/nao/ros/indigo 
make
make install
_check_errno $? "yaml cpp"

# tinyxml 2.6.2
cd ${ROBOT_ROOT}/src
wget https://github.com/uchile-robotics-forks/tinyxml/archive/v2.6.2.tar.gz -O tinyxml-2.6.2.tar.gz
tar -xvzf tinyxml-2.6.2.tar.gz
mkdir -p tinyxml-2.6.2/build
cd tinyxml-2.6.2/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "tinyxml"

# console bridge 0.2.5
cd ${ROBOT_ROOT}/src
wget https://github.com/uchile-robotics-forks/console_bridge/archive/0.2.5.tar.gz -O console_bridge-0.2.5.tar.gz
tar -xvzf console_bridge-0.2.5.tar.gz
mkdir -p console_bridge-0.2.5/build
cd console_bridge-0.2.5/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "console bridge"

# lz4 r131
cd ${ROBOT_ROOT}/src
wget https://github.com/lz4/lz4/archive/r131.tar.gz -O lz4-r131.tar.gz
tar -xvzf lz4-r131.tar.gz
cd lz4-r131/
make
make install PREFIX=${ROBOT_ROOT}/usr
_check_errno $? "lz4"

# poco 1.6.1
cd ${ROBOT_ROOT}/src
wget http://pocoproject.org/releases/poco-1.6.1/poco-1.6.1.tar.gz
tar -xvzf poco-1.6.1.tar.gz
cd poco-1.6.1/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "poco"

# gtest 1.7.0
cd ${ROBOT_ROOT}/src
wget https://github.com/google/googletest/archive/release-1.7.0.tar.gz
tar -xvzf release-1.7.0.tar.gz
cd googletest-release-1.7.0/
cmake . -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
cp -a include/gtest ${ROBOT_ROOT}/usr/include
cp -a libgtest_main.so libgtest.so ${ROBOT_ROOT}/usr/lib
_check_errno $? "gtest"

# eigen
cd ${ROBOT_ROOT}/src
wget http://bitbucket.org/eigen/eigen/get/3.3.1.tar.gz -O eigen-3.3.1.tar.gz
tar -xvzf eigen-3.3.1.tar.gz
mkdir -p eigen-eigen-f562a193118d/build
cd eigen-eigen-f562a193118d/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "eigen"

# collada dom
cd ${ROBOT_ROOT}/src
wget https://github.com/rdiankov/collada-dom/archive/v2.4.4.tar.gz -O collada-dom-2.4.4.tar.gz
tar -xvzf collada-dom-2.4.4.tar.gz
mkdir -p collada-dom-2.4.4/build
cd collada-dom-2.4.4/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "collada-dom"

# urdfdom_headers
cd ${ROBOT_ROOT}/src
wget https://github.com/ros/urdfdom_headers/archive/0.2.3.tar.gz -O urdfdom_headers-0.2.3.tar.gz
tar -xvzf urdfdom_headers-0.2.3.tar.gz
mkdir -p urdfdom_headers-0.2.3/build
cd urdfdom_headers-0.2.3/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "urdfdom_headers"

# urdf dom
cd ${ROBOT_ROOT}/src
wget https://github.com/ros/urdfdom/archive/0.2.10.tar.gz -O urdfdom-0.2.10.tar.gz
tar -xvzf urdfdom-0.2.10.tar.gz
mkdir -p urdfdom-0.2.10/build
cd urdfdom-0.2.10/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make install
_check_errno $? "urdfdom"

# ROS Python deps
#--------------------------------
# Python 2.7.3
cd ${ROBOT_ROOT}/src
wget wget https://github.com/python/cpython/archive/v2.7.3.tar.gz -O python-2.7.3.tar.gz
tar -xvzf python-2.7.3.tar.gz
cd cpython-2.7.3/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "python"

# pip
cd ${ROBOT_ROOT}/src
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py --prefix=${ROBOT_ROOT}/usr
_check_errno $? "pip"

# netifaces
cd ${ROBOT_ROOT}/src
wget https://bitbucket.org/uchile-robotics-die/netifaces/get/release_0_10_4.tar.gz -O netifaces-0.10.4.tar.gz
tar -xvzf netifaces-0.10.4.tar.gz
cd uchile-robotics-die-netifaces-1d6d179f8bce/
python setup.py install --prefix=${ROBOT_ROOT}/usr
_check_errno $? "netifaces"

# sip
cd ${ROBOT_ROOT}/src
wget https://sourceforge.net/projects/pyqt/files/sip/sip-4.19/sip-4.19.tar.gz
tar -xvzf sip-4.19.tar.gz
cd sip-4.19
python configure.py --sysroot=${ROBOT_ROOT}/usr
make
make install
_check_errno $? "sip"

# ROS deps
pip install -U catkin_pkg rosdep rosinstall_generator wstool rosinstall empy nose pillow mock coverage rospkg --install-option="--prefix=${ROBOT_ROOT}/usr"

# Add to bash profile
cat >> ~/.bash_profile <<"EOF"
export PYTHONPATH=${ROBOT_ROOT}/usr/lib/python2.7/site-packages:$PYTHONPATH
export PATH=${ROBOT_ROOT}/usr/bin:$PATH
export LD_LIBRARY_PATH=${ROBOT_ROOT}/usr/lib:$LD_LIBRARY_PATH
EOF
source ~/.bash_profile
