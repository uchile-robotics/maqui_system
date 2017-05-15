ROS_INSTALL_PREFIX=~/ros
echo "export ROS_INSTALL_PREFIX=${ROS_INSTALL_PREFIX}" >> ~/.bash_profile
mkdir -p ${ROS_INSTALL_PREFIX}/ros_catkin_ws/src
cd ${ROS_INSTALL_PREFIX}/ros_catkin_ws
wget https://raw.githubusercontent.com/uchile-robotics/maqui_system/feat-sm/pepper_indigo.rosinstall
wstool init src pepper_indigo.rosinstall
./src/catkin/bin/catkin_make_isolated --install --install-space ${ROS_INSTALL_PREFIX}/indigo -DCMAKE_BUILD_TYPE=Release -DSETUPTOOLS_ARG_EXTRA="" -DSETUPTOOLS_DEB_LAYOUT=OFF

# Add to bash profile
cat >> ~/.bash_profile <<"EOF"
export ROS_MASTER_URI=http://localhost:11311
export ROS_HOSTNAME=localhost
source ${ROS_INSTALL_PREFIX}/indigo/setup.bash
EOF
# Update ROS paths
source ~/.bash_profile







./../ros/ros_catkin_ws/src/catkin/bin/catkin_make_isolated -DCMAKE_BUILD_TYPE=Release -DSETUPTOOLS_ARG_EXTRA="" -DSETUPTOOLS_DEB_LAYOUT=OFF


remover maqui_sim y pepper_gazebo_plugin

./devel_isolated/pepper_meshes/tmp/installer.run --prefix ~/maqui_ws/src/pepper_meshes --mode unattended

agregar joint state publisher a rosinstall
