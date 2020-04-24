
##################
#     BASE       #
##################


echo -e $sline "\n Downloading Base Packages ... \n" $iline

mkdir $PKGS/base
cd $PKGS/base

# uchile_common
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_common.git

# uchile_knowledge
git clone -b feat-pepper-kinetic https://github.com/uchile-robotics/uchile_knowledge.git

# Fix Cmake issues

# sed -i '/find_package(Boost*/i set(Boost_INCLUDE_DIR "/tmp/gentoo/usr/include")' $UCHSRC/uchile_common/uchile_tf/CMakeLists.txt

# Making Symbolic Links 

cd $ROS/base_ws/src
rm * # remove previous links
ln -s $PKGS/base/uchile_common uchile_common
ln -s $PKGS/base/uchile_knowledge uchile_knowledge

# Compile base
echo -e $sline "\n Compiling base_ws.... \n" $iline
cd $ROS/base_ws && catkin_make #&& source devel/setup.sh
