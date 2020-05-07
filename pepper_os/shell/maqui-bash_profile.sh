# Check if the link exists in /tmp/gentoo
if [ ! -L /tmp/gentoo ]; then
  echo "Softlink to this Gentoo Prefix in /tmp/gentoo does not exist, creating it..."
  cd /tmp
  ln -s /home/nao/gentoo gentoo
fi

export PATH=~/.local/bin:$PATH
export PYTHONPATH=/home/nao/.local/pynaoqi-python2.7-2.5.5.5-linux32/lib/python2.7/site-packages
source /tmp/gentoo/opt/ros/melodic/setup.bash
export CATKIN_PREFIX_PATH=/tmp/gentoo/opt/ros/melodic
export ROS_LANG_DISABLE=genlisp:geneus

source ${HOME}/uchile.sh

if [[ $(ps aux | grep /tmp/gentoo/opt/ros/melodic/bin/roscore | grep -v grep) ]]; then
    export ROS_MASTER_URI=`python -c "import rosgraph; print(rosgraph.Master('ip_checker').getUri())"`
    export ROS_IP=`python -c "import rosgraph; print(rosgraph.Master('ip_checker').getUri().replace('http://','').replace(':11311/',''))"`
    export ROS_NETWORK_INTERFACE=`ifconfig | grep $ROS_IP -1 | awk 'NR==1{print $1}' | sed 's/://g'`
else
    echo "No roscore found, setting ROS_MASTER_URI and ROS_IP to localhost defaults."
    # defaults are defined in uchile.sh! 

fi

echo "Using ROS_IP: $ROS_IP"
echo "Using ROS_MASTER: $ROS_MASTER_URI"
echo "Using ROS_NETWORK_INTERFACE: $ROS_NETWORK_INTERFACE"

case $- in
    *i*) ;;
      *) return;;
esac

if grep -q /tmp/gentoo/bin/bash /proc/$$/cmdline ; then
    :
else
    EPREFIX=/tmp/gentoo
    SHELL=/tmp/gentoo/bin/bash
    echo "Entering ROS Pepperfix ${EPREFIX}"
    RETAIN="HOME=$HOME TERM=$TERM USER=$USER SHELL=$SHELL XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
    [[ -n ${PROFILEREAD} ]] && RETAIN+=" PROFILEREAD=$PROFILEREAD"
    [[ -n ${SSH_AUTH_SOCK} ]] && RETAIN+=" SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
    [[ -n ${DISPLAY} ]] && RETAIN+=" DISPLAY=$DISPLAY"
    env -i $RETAIN $SHELL -l
fi
