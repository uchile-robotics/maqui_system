#/bin/bash!


LBLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m' # No Color
sline="${LBLUE}#####################################"
iline="#####################################${NC} "

UCH=0
MAQUI=0
LAST=0


if [[ $# -eq 0 ]]; then
	UCH=1
	MAQUI=1
	LAST=1

elif [[ $1 = "uchile_ws" ]]; then
	UCH=1

elif [[ $1 = "maqui_ws" ]]; then
	MAQUI=1

elif [[ $1 = "uchile_last_ws" ]]; then
	LAST=1
fi


UCHSRC=${HOME}/uchile_ws/src
MAQUISRC=${HOME}/maqui_ws/src
LASTSRC=${HOME}/uchile_last_ws/src


############################
#		uchile _ ws        #
############################

if [[ UCH -eq 1 ]]; then

	echo -e $sline "\n Installing uchile_ws .... \n" $iline

	mkdir -p $UCHSRC ; cd $UCHSRC

	# uchile_common
	git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_common.git
	# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $UCHSRC/uchile_common/uchile_tf/CMakeLists.txt

	# uchile_knowledge
	git clone  https://github.com/uchile-robotics/uchile_knowledge.git

	# uchile_navigation
	git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_navigation.git
	
	# maqui_bringup
	git clone https://github.com/uchile-robotics/maqui_bringup.git
	cd maqui_bringup && git checkout f87ba71 && cd ..
	
	# uchile_tools (solo por uchile safety)
	# git clone  https://github.com/uchile-robotics/uchile_tools.git # solo por uchile_safety

	cd .. && catkin_make 


	if [[ $? -ne 0 ]];then
	   echo -e $RED "Error de compilación en uchile_ws" $NC >&2
	   exit 2
	fi

	echo -e $sline "\n uchile_ws READY.... \n" $iline
	
fi



source $HOME/uchile_ws/devel/setup.bash

if [[ $? -ne 0 ]];then
   echo -e $RED "No se encuentra uchile_ws compilado" $NC >&2
   exit 2
fi


############################
#		maqui _ ws         #
############################

if [[ MAQUI -eq 1 ]]; then

	echo -e $sline "\n Installing maqui_ws .... \n" $iline
	
	mkdir -p $MAQUISRC ; cd $MAQUISRC

	# naoqi_bridge
	
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

	# nao_robot (is really necesary inside pepper?)
	# git clone https://github.com/uchile-robotics-forks/nao_robot.git

	# pepper_dcm_robot
	git clone https://github.com/ros-naoqi/pepper_dcm_robot.git
	#https://github.com/uchile-robotics-forks/pepper_dcm_robot

	# pepper_robot (is really necesary inside pepper)
	git clone -b feat-pepper-kinetic https://github.com/uchile-robotics-forks/pepper_robot.git

	# pepper virtual (is really necesary inside pepper)
	git clone https://github.com/uchile-robotics-forks/pepper_virtual.git && rm -rf ${MAQUISRC}/pepper_virtual/pepper_gazebo_plugin/


	sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $MAQUISRC/naoqi_bridge/naoqi_sensors_py/CMakeLists.txt
	sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $MAQUISRC/naoqi_dcm_driver/CMakeLists.txt
	sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $MAQUISRC/pepper_dcm_robot/pepper_dcm_bringup/CMakeLists.txt

	cd $MAQUISRC/.. && catkin_make 

	if [[ $? -ne 0 ]];then
	   echo -e $RED "Error de compilación en maqui_ws" $NC >&2
	   exit 2
	fi
	
	echo -e $sline "\n maqui_ws READY.... \n" $iline
fi




source $MAQUISRC/../devel/setup.bash

if [[ $? -ne 0 ]];then
	echo -e $RED "No se encuentra maqui_ws compilado" $NC >&2   exit 2
fi
############################
#	    uchile_last _ ws   #
############################


if [[ LAST -eq 1 ]]; then	
	echo -e $sline "\n uchile_last_ws ... \n" $iline

	mkdir -p $LASTSRC ; cd $LASTSRC

	git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_perception.git

	# keep uchile_perception_utils, uchile_libs, uchile_object, uchile_furnitures
	rm -rf uchile_perception/uchile_deep/ \
			uchile_perception/uchile_face_person/ \
			uchile_perception/uchile_person/ \
			uchile_perception/uchile_scene/ \
			uchile_perception/uchile_tracking/ \
			uchile_perception/uchile_object/training \
			uchile_perception/uchile_libs/plane_detector 


	git clone https://github.com/uchile-robotics/uchile_high.git
	rm -rf uchile_high/bender_skills/
	sed -i '/bender_skills/d' $LASTSRC/uchile_high/uchile_demos/CMakeLists.txt


	grep -v "rviz_visual_tools" uchile_perception/uchile_object/CMakeLists.txt > uchile_perception/uchile_object/CMakeLists.tmp && \
				mv uchile_perception/uchile_object/CMakeLists.tmp uchile_perception/uchile_object/CMakeLists.txt



	git clone https://github.com/ristofer/visual_localization.git

	# is really necessary??????
	git clone https://github.com/ros-visualization/interactive_markers.git

	git clone https://github.com/uchile-robotics/uchile_hri.git
	rm -rf uchile_hri/display_interface/ \
		   uchile_hri/uchile_speech_pocketsphinx/ \
		   uchile_hri/uchile_speech_web/


	sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $LASTSRC/uchile_hri/uchile_speech_web_pepper/CMakeLists.txt
	#sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $LASTSRC/uchile_perception/uchile_libs/CMakeLists.txt
	sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $LASTSRC/visual_localization/CMakeLists.txt


	# uchile _ last _ws compilation |  
	# problematic packages: uchile_perception_utils
	sed -i 's/set(_GL_INCDIRS "\/tmp\/gentoo\/usr\/include\/libdrm")/set(_GL_INCDIRS "\/tmp\/gentoo\/usr\/include\/")/1' /tmp/gentoo/usr/lib/cmake/Qt5Gui/Qt5GuiConfigExtras.cmake
	sed -i 's/#include_next <stdlib.h>/#include <stdlib.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/cstdlib
	sed -i 's/#include_next <stdlib.h>/#include <stdlib.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/bits/std_abs.h
	sed -i 's/#include_next <math.h>/#include <math.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/cmath


	wget https://gitlab.com/srrg-software/srrg_depth2laser/-/archive/master/srrg_depth2laser-master.tar.gz && \
			tar -xvf srrg_depth2laser-master.tar.gz && \
			mv srrg_depth2laser-master srrg_depth2laser &&\
			rm srrg_depth2laser-master.tar.gz

	wget https://gitlab.com/srrg-software/srrg_depth2laser_ros/-/archive/master/srrg_depth2laser_ros-master.tar.gz &&\
			tar -xvf srrg_depth2laser_ros-master.tar.gz && \
			mv srrg_depth2laser_ros-master srrg_depth2laser_ros &&\
			rm srrg_depth2laser_ros-master.tar.gz

	sed -i -e '34,+3 s/^/#/' -e '19 s/^/#/' -e '138 s/^/#/' $LASTSRC/srrg_depth2laser/CMakeLists.txt # comment lines in MakeFile :s



	cd $LASTSRC/.. && catkin_make 


	if [[ $? -ne 0 ]];then
	   echo -e $RED "Error de compilación en uchile_last_ws" $NC >&2
	   exit 2
	fi
	
fi
