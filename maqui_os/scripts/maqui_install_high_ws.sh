##################
#      HIGH      #
##################

echo -e $sline "\n Downloading High Packages ... \n" $iline

# Download Packages
mkdir -p $PKGS/high
cd $PKGS/high

# maqui_bringup
git clone https://github.com/uchile-robotics/maqui_bringup.git
cd maqui_bringup && git checkout f87ba71 && cd .. # move to specific commit where everything is fine

# uchile_high
if [ -z "$DOCKER_FLAG" ]
then
    git clone https://github.com/uchile-robotics/uchile_high.git
else
    cp -r ${HOME}/repos/uchile_high .
fi

rm -rf uchile_high/bender_skills/ # bender skills doesnt apply to pepper

# Fixing Cmake issues
sed -i '/bender_skills/d' uchile_high/uchile_demos/CMakeLists.txt

# Making Symbolic Links 
cd $ROS/high_ws/src
rm * # remove previous links
ln -s $PKGS/high/maqui_bringup maqui_bringup
ln -s $PKGS/high/uchile_high uchile_high

# Compiling	
echo -e $sline "\n Compiling high_ws.... \n" $iline
cd $ROS/high_ws && catkin_make 



