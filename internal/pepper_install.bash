#/bin/bash!


LBLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m' # No Color
sline="${LBLUE}#####################################"
iline="#####################################${NC} "

UCH_WS=${HOME}/uchile_ws
PKGS=${UCH_WS}/pkgs
ROS=${UCH_WS}/ros

mkdir -p $ROS
mkdir -p $PKGS


echo -e $sline "\n Downloading Packages .... \n" $iline

cd $PKGS

##################
#     FORKS      #
##################

mkdir srrg_depth2laser_ros; cd srrg_depth2laser_ros

wget https://gitlab.com/srrg-software/srrg_depth2laser/-/archive/master/srrg_depth2laser-master.tar.gz && \
		tar -xvf srrg_depth2laser-master.tar.gz && \
		mv srrg_depth2laser-master srrg_depth2laser &&\
		rm srrg_depth2laser-master.tar.gz


wget https://gitlab.com/srrg-software/srrg_depth2laser_ros/-/archive/master/srrg_depth2laser_ros-master.tar.gz &&\
		tar -xvf srrg_depth2laser_ros-master.tar.gz && \
		mv srrg_depth2laser_ros-master srrg_depth2laser_ros &&\
		rm srrg_depth2laser_ros-master.tar.gz

sed -i -e '34,+3 s/^/#/' -e '19 s/^/#/' -e '138 s/^/#/' srrg_depth2laser/CMakeLists.txt # comment lines in MakeFile :s


cd $PKGS

# is really necessary??????
git clone https://github.com/ros-visualization/interactive_markers.git


##################
#     BASE       #
##################

# uchile_common
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_common.git
# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $UCHSRC/uchile_common/uchile_tf/CMakeLists.txt

# uchile_knowledge
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_knowledge.git


##################
#     MAQUI      #
##################

mkdir pepper ; cd pepper

#git clone https://github.com/ros-naoqi/naoqi_bridge.git
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/naoqi_bridge.git

# naoqi_bridge_msg
# git clone https://github.com/ros-naoqi/naoqi_bridge_msgs.git
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/naoqi_bridge_msgs.git 

# naoqi_dcm_driver
# git clone https://github.com/ros-naoqi/naoqi_dcm_driver.git
git clone -b feat-pepper-kinetic  https://github.com/uchile-robotics-forks/naoqi_dcm_driver.git 

# naoqi driver
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/naoqi_driver.git
# https://github.com/ros-naoqi/naoqi_driver.git 

# naoqi_libqi
wget https://github.com/ros-naoqi/libqi-release/archive/release/kinetic/naoqi_libqi/2.5.0-3.tar.gz &&\
	tar cvf 2.5.0-3.tar.gz &&\
	mv libqi-release-release-kinetic-naoqi_libqi-2.5.0-3 naoqi_libqi &&\
	rm 2.5.0-3.tar.gz


# naoqi_libqicore is already installed!

# nao_robot (is really necesary inside pepper?)
# git clone https://github.com/uchile-robotics-forks/nao_robot.git

# pepper_dcm_robot
git clone https://github.com/ros-naoqi/pepper_dcm_robot.git
#https://github.com/uchile-robotics-forks/pepper_dcm_robot

# pepper_robot (is really necesary inside pepper?)
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/pepper_robot.git

# pepper virtual (is really necesary inside pepper?)
git clone https://github.com/uchile-robotics-forks/pepper_virtual.git && rm -rf pepper_virtual/pepper_gazebo_plugin/

sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' naoqi_bridge/naoqi_sensors_py/CMakeLists.txt
sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' naoqi_dcm_driver/CMakeLists.txt
sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' pepper_dcm_robot/pepper_dcm_bringup/CMakeLists.txt

cd $PKGS

##################
#     SOFT       #
##################

# uchile_navigation
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_navigation.git

git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_perception.git

# keep uchile_perception_utils, uchile_libs, uchile_object, uchile_furnitures
rm -rf uchile_perception/uchile_deep/ \
		uchile_perception/uchile_face_person/ \
		uchile_perception/uchile_person/ \
		uchile_perception/uchile_scene/ \
		uchile_perception/uchile_tracking/ \
		uchile_perception/uchile_object/training \
		uchile_perception/uchile_libs/plane_detector 

git clone https://github.com/ristofer/visual_localization.git

git clone https://github.com/uchile-robotics/uchile_hri.git
rm -rf uchile_hri/display_interface/ \
	   uchile_hri/uchile_speech_pocketsphinx/ \
	   uchile_hri/uchile_speech_web/


sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' uchile_hri/uchile_speech_web_pepper/CMakeLists.txt
sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' uchile_perception/uchile_libs/CMakeLists.txt
sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' visual_localization/CMakeLists.txt

# problematic packages: uchile_perception_utils
sed -i 's/set(_GL_INCDIRS "\/tmp\/gentoo\/usr\/include\/libdrm")/set(_GL_INCDIRS "\/tmp\/gentoo\/usr\/include\/")/1' /tmp/gentoo/usr/lib/cmake/Qt5Gui/Qt5GuiConfigExtras.cmake
sed -i 's/#include_next <stdlib.h>/#include <stdlib.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/cstdlib
sed -i 's/#include_next <stdlib.h>/#include <stdlib.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/bits/std_abs.h
sed -i 's/#include_next <math.h>/#include <math.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/cmath


##################
#      HIGH      #
##################

# maqui_bringup
git clone https://github.com/uchile-robotics/maqui_bringup.git
cd maqui_bringup && git checkout f87ba71 && cd ..


git clone https://github.com/uchile-robotics/uchile_high.git
rm -rf uchile_high/bender_skills/
sed -i '/bender_skills/d' uchile_high/uchile_demos/CMakeLists.txt


grep -v "rviz_visual_tools" uchile_perception/uchile_object/CMakeLists.txt > uchile_perception/uchile_object/CMakeLists.tmp && \
			mv uchile_perception/uchile_object/CMakeLists.tmp uchile_perception/uchile_object/CMakeLists.txt



echo -e $sline "\n Creating Symbolic links .... \n" $iline

cd $ROS 
mkdir -p forks_ws/src base_ws/src soft_ws/src high_ws/src

cd $ROS/forks_ws/src
ln -s $PKGS/srrg_depth2laser_ros srrg_depth2laser_ros
ln -s $PKGS/interactive_markers interactive_markers
ln -s $PKGS/pepper pepper

cd $ROS/base_ws/src
ln -s $PKGS/uchile_common uchile_common
ln -s $PKGS/uchile_knowledge uchile_knowledge

cd $ROS/soft_ws/src
ln -s $PKGS/uchile_perception uchile_perception
ln -s $PKGS/uchile_navigation uchile_navigation
ln -s $PKGS/visual_localization visual_localization
ln -s $PKGS/uchile_hri uchile_hri

cd $ROS/high_ws/src
ln -s $PKGS/maqui_bringup maqui_bringup
ln -s $PKGS/uchile_high uchile_high

echo -e $sline "\n Compiling .... \n" $iline

echo -e $sline "\n Compiling forks_ws.... \n" $iline
cd $ROS/forks_ws && catkin_make && source devel/setup.sh

echo -e $sline "\n Compiling base_ws.... \n" $iline
cd $ROS/base_ws && catkin_make && source devel/setup.sh

echo -e $sline "\n Compiling soft_ws.... \n" $iline
cd $ROS/soft_ws && catkin_make && source devel/setup.sh

echo -e $sline "\n Compiling high_ws.... \n" $iline
cd $ROS/high_ws && catkin_make && source devel/setup.sh
