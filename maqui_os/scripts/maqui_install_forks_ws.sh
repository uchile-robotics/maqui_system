##################
#     FORKS      #
##################

# Dependencias 
# emerge ros-melodic/octomap	
echo -e $sline "\n Downloading Forks Packages ... \n" $iline

# create dir if it not 
mkdir -p $PKGS/forks
cd $PKGS/forks

# Download Forks Packages
mkdir srrg_depth2laser_ros
cd srrg_depth2laser_ros

if [ ! -d srrg_depth2laser ]; then

	wget https://gitlab.com/srrg-software/srrg_depth2laser/-/archive/master/srrg_depth2laser-master.tar.gz && \
		tar -xvf srrg_depth2laser-master.tar.gz &&\
		mv srrg_depth2laser-master srrg_depth2laser &&\
		rm srrg_depth2laser-master.tar.gz

fi
 
if [ ! -d srrg_depth2laser_ros ]; then
	wget https://gitlab.com/srrg-software/srrg_depth2laser_ros/-/archive/master/srrg_depth2laser_ros-master.tar.gz &&\
		tar -xvf srrg_depth2laser_ros-master.tar.gz && \
		mv srrg_depth2laser_ros-master srrg_depth2laser_ros &&\
		rm srrg_depth2laser_ros-master.tar.gz
fi

cd $PKGS/forks

# we may need an specific version of cv_bridge
# git clone -b kinetic https://github.com/ros-perception/vision_opencv.git  # problems with the cv_brdige version in gentoo_prefix
# mv vision_opencv/cv_bridge . && rm -rf vision_opencv

git clone https://github.com/ros-visualization/interactive_markers.git # is really necessary?

# fix some cmake issues
sed -i -e '34,+3 s/^/#/' -e '19 s/^/#/' -e '138 s/^/#/' srrg_depth2laser_ros/srrg_depth2laser/CMakeLists.txt # comment lines in MakeFile :s
# sed -i '/if(NOT ANDROID)*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' cv_bridge/CMakeLists.txt

##################
#     Pepper     #
##################

echo -e $sline "\n Downloading Pepper Packages ... \n" $iline

cd $PKGS/forks
mkdir pepper ; cd pepper

git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/naoqi_bridge.git #git clone https://github.com/ros-naoqi/naoqi_bridge.git

# naoqi_bridge_msg
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/naoqi_bridge_msgs.git # git clone https://github.com/ros-naoqi/naoqi_bridge_msgs.git

# naoqi_dcm_driver
git clone -b feat-pepper-kinetic  https://github.com/uchile-robotics-forks/naoqi_dcm_driver.git # git clone https://github.com/ros-naoqi/naoqi_dcm_driver.git

# naoqi driver
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/naoqi_driver.git # https://github.com/ros-naoqi/naoqi_driver.git 

# naoqi_libqi
if [ ! -f  2.5.0-3.tar.gz ] && [ ! -d naoqi_libqi ]; then
	wget https://github.com/ros-naoqi/libqi-release/archive/release/kinetic/naoqi_libqi/2.5.0-3.tar.gz
fi

if [ ! -d naoqi_libqi ]; then
	tar -xvf 2.5.0-3.tar.gz &&\
	mv libqi-release-release-kinetic-naoqi_libqi-2.5.0-3 naoqi_libqi &&\
	rm 2.5.0-3.tar.gz
else
	rm 2.5.0-3.tar.gz
fi

# naoqi_libqicore is already installed!

# nao_robot 
# git clone https://github.com/uchile-robotics-forks/nao_robot.git #(is really necesary inside pepper?)

git clone https://github.com/ros-naoqi/pepper_dcm_robot.git # pepper_dcm_robot
#https://github.com/uchile-robotics-forks/pepper_dcm_robot

# pepper_robot
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/pepper_robot.git # pepper_robot (is really necesary inside pepper?)

# pepper_virtual
git clone https://github.com/uchile-robotics-forks/pepper_virtual.git && rm -rf pepper_virtual/pepper_gazebo_plugin/ # pepper virtual (is really necesary inside pepper?)

# Fix Cmake issues in pepper 
# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' naoqi_bridge/naoqi_sensors_py/CMakeLists.txt
# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' naoqi_dcm_driver/CMakeLists.txt
# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' pepper_dcm_robot/pepper_dcm_bringup/CMakeLists.txt

# Making Symbolic Links to ros_ws
cd $ROS/forks_ws/src
rm * # remove previous links
ln -s $PKGS/forks/srrg_depth2laser_ros ./srrg_depth2laser_ros
ln -s $PKGS/forks/interactive_markers ./interactive_markers
# ln -s $PKGS/forks/cv_bridge ./cv_bridge
ln -s $PKGS/forks/pepper ./pepper

# Compile Forks
echo -e $sline "\n Compiling forks_ws ... \n" $iline
cd $ROS/forks_ws && catkin_make -DCATKIN_ENABLE_TESTING=0