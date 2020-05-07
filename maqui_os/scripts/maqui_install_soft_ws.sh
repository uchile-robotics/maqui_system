##################
#     SOFT       #
##################

echo -e $sline "\n Downloading Soft Packages ... \n" $iline

mkdir $PKGS/soft
cd $PKGS/soft

# uchile_navigation
git clone -b feat-melodic-twist-recovery https://github.com/uchile-robotics/uchile_navigation.git
cd uchile_navigation && rm -rf base_local_planner && cd .. # we dont need that in pepper

# uchile_perception (private repo)
if [ -z "$DOCKER_FLAG" ]
then
	git clone -b feat-melodic https://github.com/uchile-robotics/uchile_perception.git
else
    cp -r ${HOME}/repos/uchile_perception .
fi

# keep uchile_perception_utils, uchile_libs, uchile_object, uchile_furnitures, rm everything else
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

# Fixing Cmake issues
cp uchile_hri/uchile_speech_web_pepper/CMakeLists.txt uchile_hri/uchile_speech_web_pepper/CMakeLists.txt.bp
cp visual_localization/CMakeLists.txt visual_localization/CMakeLists.txt.bp

sed -i 's/find_package(Boost REQUIRED COMPONENTS system signals thread)/find_package(Boost REQUIRED COMPONENTS system thread)/1' uchile_hri/uchile_speech_web_pepper/CMakeLists.txt
sed -i '/${catkin_INCLUDE_DIRS}/i ${Boost_INCLUDE_DIR}/1' uchile_hri/uchile_speech_web_pepper/CMakeLists.txt
sed -i 's/find_package(Boost REQUIRED COMPONENTS signals)/find_package(Boost)/1' visual_localization/CMakeLists.txt

# ya no son necesarios !!
# sed -i '/find_package(PCL 1.7*/i /set(pcl_INCLUDE_DIRS "/home/nao/gentoo/usr/include/pcl-1.8/")' 	uchile_navigation_utils/CMakeLists.txt 
# sed -i '/find_package(PCL 1.7*/i /set(pcl_INCLUDE_DIRS "/home/nao/gentoo/usr/include/pcl-1.8/")' 	uchile_nav/CMakeLists.txt 
# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' uchile_hri/uchile_speech_web_pepper/CMakeLists.txt
# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' uchile_perception/uchile_libs/CMakeLists.txt
# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' visual_localization/CMakeLists.txt
# problematic packages: uchile_perception_utils
# sed -i 's/set(_GL_INCDIRS "\/tmp\/gentoo\/usr\/include\/libdrm")/set(_GL_INCDIRS "\/tmp\/gentoo\/usr\/include\/")/1' /tmp/gentoo/usr/lib/cmake/Qt5Gui/Qt5GuiConfigExtras.cmake
# sed -i 's/#include_next <stdlib.h>/#include <stdlib.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/cstdlib
# sed -i 's/#include_next <stdlib.h>/#include <stdlib.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/bits/std_abs.h
# sed -i 's/#include_next <math.h>/#include <math.h>/1' /tmp/gentoo/usr/lib/gcc/i686-pc-linux-gnu/8.2.0/include/g++-v8/cmath

# visual tools problem
grep -v "rviz_visual_tools" uchile_perception/uchile_object/CMakeLists.txt > uchile_perception/uchile_object/CMakeLists.tmp && \
			mv uchile_perception/uchile_object/CMakeLists.tmp uchile_perception/uchile_object/CMakeLists.txt

# Making Symbolic Links 
cd $ROS/soft_ws/src
rm * # remove previous links
ln -s $PKGS/soft/uchile_perception uchile_perception
ln -s $PKGS/soft/uchile_navigation uchile_navigation
ln -s $PKGS/soft/visual_localization visual_localization
ln -s $PKGS/soft/uchile_hri uchile_hri

# Compile Soft
echo -e $sline "\n Compiling soft_ws.... \n" $iline
cd $ROS/soft_ws && catkin_make 
