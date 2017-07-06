cd ~
ROBOT_ROOT=~/maqui_root
echo "export ROBOT_ROOT=${ROBOT_ROOT}" >> .bash_profile

# wget 1.15
# ---------------------------------------------------------
# notes:
# - You might need to restart the machine for this changes to work
# prerequisites:
# - none
cd ${ROBOT_ROOT}/src
curl -O https://ftp.gnu.org/gnu/wget/wget-1.16.tar.gz
tar -zxvf wget-1.16.tar.gz
cd wget-1.16/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# hdf5 1.8.12
# ---------------------------------------------------------
# notes:
# - We used 1.8.12 instead of 1.8.11 because of some source install errors
# - It requires wget 1.15 to avoid this problem:
#       Resolving support.hdfgroup.org... 50.28.50.143
#       Connecting to support.hdfgroup.org|50.28.50.143|:443... connected.
#       OpenSSL: error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
#       Unable to establish SSL connection.
# prerequisites:
# - wget 1.15
cd ${ROBOT_ROOT}/src
wget http://pkgs.fedoraproject.org/repo/pkgs/hdf5/hdf5-1.8.12.tar.bz2/03ad766d225f5e872eb3e5ce95524a08/hdf5-1.8.12.tar.bz2
tar -xjvf hdf5-1.8.12.tar.gz
mkdir -p hdf5-1.8.12/build
cd hdf5-1.8.12/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install


# flann 1.8.5
# ---------------------------------------------------------
# notes:
# - compilation REQUIRES AT LEAST 1.6 GB in RAM or it won't work, i always use 4 GB just in case
# - it might seem frozen from time to time, but it takes a while
# prerequisites:
# - hdf5
cd ${ROBOT_ROOT}/src
wget https://github.com/uchile-robotics-forks/flann/archive/1.8.5.tar.gz -O flann-1.8.5.tar.gz
tar -xvzf flann-1.8.5.tar.gz
mkdir -p flann-1.8.5/build
cd flann-1.8.5/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install


# ---------------------------------------------------------
# MESA DEPENDENCIES
# ---------------------------------------------------------
# 

# pkgconf 0.9.12
# ---------------------------------------------------------
# notes:
# prerequisites:
cd ${ROBOT_ROOT}/src
wget https://github.com/pkgconf/pkgconf/archive/pkgconf-0.9.12.tar.gz -O pkgconf-0.9.12.tar.gz
tar -xvzf pkgconf-0.9.12.tar.gz
cd pkgconf-pkgconf-0.9.12/
./autogen.sh
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# Set the PKG_CONFIG_PATH environment variable
#export PKG_CONFIG_PATH=${ROBOT_ROOT}/usr/lib/pkgconfig:/usr/local/share/pkgconfig:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH=${ROBOT_ROOT}/usr/lib/pkgconfig:${ROBOT_ROOT}/usr/share/pkgconfig:${ROBOT_ROOT}/usr/bin/pkgconfig

# libxml2 2.9.4
# ---------------------------------------------------------
# notes:
# prerequisites:
# - pkgconf
cd ${ROBOT_ROOT}/src
wget https://github.com/GNOME/libxml2/archive/v2.9.4.tar.gz -O libxml2-v2.9.4.tar.gz
tar -xvzf libxml2-v2.9.4.tar.gz
cd libxml2-2.9.4/
./autogen.sh  --prefix=${ROBOT_ROOT}/usr
make
make install

# libxml2 2.9.4
# ---------------------------------------------------------
# notes:
# prerequisites:
# - pkgconf
cd ${ROBOT_ROOT}/src
#wget http://xmlsoft.org/sources/python/libxml2-python-2.9.1.tar.gz -O libxml2-python-2.5.11.tar.gz
#tar -xvzf libxml2-python-2.5.11.tar.gz
#cd libxml2-python-2.5.11/
wget http://github.com/retspen/retspen.github.io/raw/master/libxml2-python-2.9.1.tar.gz
mkdir libxml2-python-2.9.1
tar -xvzf libxml2-python-2.9.1.tar.gz -C libxml2-python-2.9.1
cd libxml2-python-2.9.1
python setup.py install --prefix=${ROBOT_ROOT}/usr
#make
#make install

# util-macros 1.7.0
# ---------------------------------------------------------
# notes:
# - contains the required xorg-macros
# - requires adding  to PKG_CONFIG_PATH
# prerequisites:
# - xorg-macros
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/util/util-macros-1.7.0.tar.gz -O util-macros-1.7.0.tar.gz --no-check-certificate
tar -xvzf util-macros-1.7.0.tar.gz
cd util-macros-1.7.0/
./configure --prefix=${ROBOT_ROOT}/usr
make install

# glproto-1.4.17
# ---------------------------------------------------------
# notes:
# - it is the latest version
# prerequisites:
# - xorg-macros
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/glproto-1.4.17.tar.gz -O glproto-1.4.17.tar.gz --no-check-certificate
tar -xvzf glproto-1.4.17.tar.gz 
cd glproto-1.4.17/
./configure --prefix=${ROBOT_ROOT}/usr
#make
make install

# pciaccess 0.13.5
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/lib/libpciaccess-0.13.5.tar.gz -O libpciaccess-0.13.5.tar.gz --no-check-certificate
tar -xvzf libpciaccess-0.13.5.tar.gz
cd libpciaccess-0.13.5
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# pthread-stubs 0.4
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.gz -O libpthread-stubs-0.4.tar.gz --no-check-certificate
tar -xvzf libpthread-stubs-0.4.tar.gz
cd libpthread-stubs-0.4/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# libdrm 7.0.31
# ---------------------------------------------------------
# notes:
# - This is the SPECIFIC minimum version required, the latest versions throws errors on Mesa gmake process
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://dri.freedesktop.org/libdrm/libdrm-2.4.52.tar.gz -O libdrm-2.4.52.tar.gz --no-check-certificate
tar -xvzf libdrm-2.4.52.tar.gz
cd libdrm-2.4.52
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# dri2proto 7.0.31
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz -O dri2proto-2.8.tar.gz --no-check-certificate
tar -xvzf dri2proto-2.8.tar.gz
cd dri2proto-2.8/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# dri3proto 1.0
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.gz -O dri3proto-1.0.tar.gz --no-check-certificate
tar -xvzf dri3proto-1.0.tar.gz
cd dri3proto-1.0/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# presentproto 1.1
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/presentproto-1.1.tar.gz -O presentproto-1.1.tar.gz --no-check-certificate
tar -xvzf presentproto-1.1.tar.gz
cd presentproto-1.1/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xproto 7.0.31
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/xproto-7.0.31.tar.gz -O xproto-7.0.31.tar.gz --no-check-certificate
tar -xvzf xproto-7.0.31.tar.gz
cd xproto-7.0.31/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xextproto 7.3.0
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/xextproto-7.3.0.tar.gz -O xextproto-7.3.0.tar.gz --no-check-certificate
tar -xvzf xextproto-7.3.0.tar.gz
cd xextproto-7.3.0/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xtrans 1.3.5
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/lib/xtrans-1.3.5.tar.gz -O xtrans-1.3.5.tar.gz --no-check-certificate
tar -xvzf xtrans-1.3.5.tar.gz
cd xtrans-1.3.5/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xcb-proto 1.12
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://xcb.freedesktop.org/dist/xcb-proto-1.12.tar.gz -O xcb-proto-1.12.tar.gz --no-check-certificate
tar -xvzf xcb-proto-1.12.tar.gz
cd xcb-proto-1.12/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install



# xau 1.0.8
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - xorg macros
# - xproto
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/lib/libXau-1.0.8.tar.gz -O libXau-1.0.8.tar.gz --no-check-certificate
tar -xvzf libXau-1.0.8.tar.gz
cd libXau-1.0.8/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xcb 1.12
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - xcb-proto
# - xau
# - pthread-stubs
cd ${ROBOT_ROOT}/src
wget https://xcb.freedesktop.org/dist/libxcb-1.12.tar.gz -O libxcb-1.12.tar.gz --no-check-certificate
tar -xvzf libxcb-1.12.tar.gz
cd libxcb-1.12/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# kbproto 1.0.7
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/kbproto-1.0.7.tar.gz -O kbproto-1.0.7.tar.gz --no-check-certificate
tar -xvzf kbproto-1.0.7.tar.gz
cd kbproto-1.0.7/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# inputproto 2.3
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/inputproto-2.3.tar.gz -O inputproto-2.3.tar.gz --no-check-certificate
tar -xvzf inputproto-2.3.tar.gz
cd inputproto-2.3/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# X11 1.
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - xtrans
# - xcb
# - kbproto
# - inputproto
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/lib/libX11-1.6.5.tar.gz -O libX11-1.6.5.tar.gz --no-check-certificate
tar -xvzf libX11-1.6.5.tar.gz
cd libX11-1.6.5/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - xproto
# - xextproto
# - x11
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/lib/libXext-1.3.3.tar.gz -O libXext-1.3.3.tar.gz --no-check-certificate
tar -xvzf libXext-1.3.3.tar.gz
cd libXext-1.3.3/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# damageproto 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/damageproto-1.2.1.tar.gz -O damageproto-1.2.1.tar.gz --no-check-certificate
tar -xvzf damageproto-1.2.1.tar.gz
cd damageproto-1.2.1/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# fixesproto 5.0
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive/individual/proto/fixesproto-5.0.tar.gz -O fixesproto-5.0.tar.gz --no-check-certificate
tar -xvzf fixesproto-5.0.tar.gz
cd fixesproto-5.0/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xfixes 5.0
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - fixesproto
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/lib/libXfixes-5.0.tar.gz -O libXfixes-5.0.tar.gz --no-check-certificate
tar -xvzf libXfixes-5.0.tar.gz
cd libXfixes-5.0/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - damageproto
# - xfixes
# - fixesproto
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/lib/libXdamage-1.1.tar.gz -O libXdamage-1.1.tar.gz --no-check-certificate
tar -xvzf libXdamage-1.1.tar.gz
cd libXdamage-1.1/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
wget https://www.x.org/archive//individual/lib/libxshmfence-1.2.tar.gz -O libxshmfence-1.2.tar.gz --no-check-certificate
tar -xvzf libxshmfence-1.2.tar.gz
cd libxshmfence-1.2/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

# libtool 2.4
# ---------------------------------------------------------
# notes:
# - This is the required version to properly configure Mesa (needs to be confirmed)
# prerequisites:
# - None
#cd ${ROBOT_ROOT}/src
#wget http://gnu.c3sl.ufpr.br/ftp/libtool/libtool-2.4.tar.gz -O libtool-2.4.tar.gz
#tar -xvzf libtool-2.4.tar.gz
#cd libtool-2.4/
#./configure --prefix=${ROBOT_ROOT}/usr

# mesa 10.1.3
# ---------------------------------------------------------
# notes:
# - This is the required version because ... UNCLEAR
# prerequisites:
# - libxml2 for python2
# - glproto >= 1.4.14
# - many libx libraries
cd ${ROBOT_ROOT}/src
wget https://mesa.freedesktop.org/archive/older-versions/10.x/10.1.3/MesaLib-10.1.3.tar.gz -O MesaLib-10.1.3.tar.gz --no-check-certificate
tar -xvzf MesaLib-10.1.3.tar.gz
cd Mesa-10.1.3/
autoreconf --force --install
./configure --prefix=${ROBOT_ROOT}/usr --with-gallium-drivers=
make
make install

# qhull
# ---------------------------------------------------------
cd ${ROBOT_ROOT}/src
wget http://www.qhull.org/download/qhull-2015-src-7.2.0.tgz
tar -xvzf qhull-2015-src-7.2.0.tgz
cd qhull-2015.2
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make
make install

# pcl 1.7.2
# ---------------------------------------------------------
# notes:
# - This is the required version because ... UNCLEAR
# prerequisites:
# - flann>=1.7.0
# - fzapi: only required if you use Fotonic time of flight cameras
# - pxcapi: It's Intel Perceptual Computing SDK PXCAPI... 
# - metslib
# - Qhull
# - VTK
# - PCAP
# - OpenGL (mesa)
cd ${ROBOT_ROOT}/src
wget https://github.com/PointCloudLibrary/pcl/archive/pcl-1.7.2.tar.gz -O pcl-1.7.2.tar.gz
tar -xvzf pcl-1.7.2.tar.gz
mkdir -p pcl-pcl-1.7.2/build
cd pcl-pcl-1.7.2/build
cmake .. -DCMAKE_INSTALL_PREFIX=${ROBOT_ROOT}/usr
make install

# SDL
# ---------------------------------------------------------
# notes:
# - This is the latest version
# - Required for move_base ros install
# prerequisites:
# - None
cd ${ROBOT_ROOT}/src
hg clone -u SDL-1.2 https://hg.libsdl.org/SDL SDL-1.2
cd SDL-1.2
./autogen.sh
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

cd ${ROBOT_ROOT}/src
wget http://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.12.tar.gz -O SDL_image-1.2.12.tar.gz --no-check-certificate
tar -xvzf SDL_image-1.2.12.tar.gz
cd SDL_image-1.2.12/
./configure --prefix=${ROBOT_ROOT}/usr
make
make install

rm -f *.tar.gz *.tgz

### Ultimo error:
##### NO HAY!!!! =D

#Correr : rosinstall_generator navigation --rosdistro indigo --deps --tar --exclude RPP rviz > navigation.rosinstall

