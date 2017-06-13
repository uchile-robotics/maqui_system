
# wget 1.15
# ---------------------------------------------------------
# notes:
# - You NEED TO RESTART the machine for this changes to work
# prerequisites:
# - none
cd ~/pepper_dep
curl -O http://ftp.gnu.org/gnu/wget/wget-1.15.tar.gz
tar -zxvf wget-1.15.tar.gz
cd wget-1.15/
./configure
make
sudo make install




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
# - hdf5
# - wget 1.15
cd ~/pepper_dep
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.12/src/hdf5-1.8.12.tar.gz -O hdf5-1.8.12.tar.gz
tar -xvzf hdf5-1.8.12.tar.gz
mkdir -p hdf5-1.8.12/build
cd hdf5-1.8.12/build
cmake ..
make
sudo make install


# flann 1.8.5
# ---------------------------------------------------------
# notes:
# - compilation REQUIRES AT LEAST 1.6 GB in RAM or it won't work, i always use 4 GB just in case
# prerequisites:
# - hdf5
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/flann/archive/1.8.5.tar.gz -O flann-1.8.5.tar.gz
tar -xvzf flann-1.8.5.tar.gz
mkdir -p flann-1.8.5/build
cd flann-1.8.5/build
cmake ..
make
sudo make install


# ---------------------------------------------------------
# MESA DEPENDENCIES
# ---------------------------------------------------------
# 

# pkgconf 0.9.12
# ---------------------------------------------------------
# notes:
# prerequisites:
cd ~/pepper_dep
wget https://github.com/pkgconf/pkgconf/archive/pkgconf-0.9.12.tar.gz -O pkgconf-0.9.12.tar.gz
tar -xvzf pkgconf-0.9.12.tar.gz
cd pkgconf-pkgconf-0.9.12/
./autogen.sh
./configure
make
sudo make install


# libxml2 2.9.4
# ---------------------------------------------------------
# notes:
# prerequisites:
# - pkgconf
cd ~/pepper_dep
wget https://github.com/GNOME/libxml2/archive/v2.9.4.tar.gz -O libxml2-v2.9.4.tar.gz
tar -xvzf libxml2-v2.9.4.tar.gz
cd libxml2-2.9.4/
./autogen.sh
make
sudo make install



# util-macros 1.7.0
# ---------------------------------------------------------
# notes:
# - contains the required xorg-macros
# - requires adding  to PKG_CONFIG_PATH
# prerequisites:
# - xorg-macros
cd ~/pepper_dep
wget https://www.x.org/archive//individual/util/util-macros-1.7.0.tar.gz -O util-macros-1.7.0.tar.gz --no-check-certificate
tar -xvzf util-macros-1.7.0.tar.gz
cd util-macros-1.7.0/
./configure
sudo make install


# glproto-1.4.17
# ---------------------------------------------------------
# notes:
# - it is the latest version
# prerequisites:
# - xorg-macros
cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/glproto-1.4.17.tar.gz -O glproto-1.4.17.tar.gz --no-check-certificate
tar -xvzf glproto-1.4.17.tar.gz 
cd glproto-1.4.17/
./configure
make
sudo make install

cd ~/pepper_dep
wget https://www.x.org/archive/individual/lib/libpciaccess-0.13.5.tar.gz -O libpciaccess-0.13.5.tar.gz --no-check-certificate
tar -xvzf libpciaccess-0.13.5.tar.gz
cd libpciaccess-0.13.5
./configure
make
sudo make install

cd ~/pepper_dep
wget https://dri.freedesktop.org/libdrm/libdrm-2.4.81.tar.gz -O libdrm-2.4.81.tar.gz --no-check-certificate
tar -xvzf libdrm-2.4.81.tar.gz
cd libdrm-2.4.81
./configure
make
sudo make install


cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz -O dri2proto-2.8.tar.gz --no-check-certificate
tar -xvzf dri2proto-2.8.tar.gz
cd dri2proto-2.8/
./configure
make
sudo make install

cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.gz -O dri3proto-1.0.tar.gz --no-check-certificate
tar -xvzf dri3proto-1.0.tar.gz
cd dri3proto-1.0/
./configure
make
sudo make install

cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/presentproto-1.1.tar.gz -O presentproto-1.1.tar.gz --no-check-certificate
tar -xvzf presentproto-1.1.tar.gz
cd presentproto-1.1/
./configure
make
sudo make install

################################# TODO OK HASTA ACA ##################################

# xproto 7.0.31
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/xproto-7.0.31.tar.gz -O xproto-7.0.31.tar.gz --no-check-certificate
tar -xvzf xproto-7.0.31.tar.gz
cd xproto-7.0.31/
./configure
make
sudo make install

# xextproto 7.3.0
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/xextproto-7.3.0.tar.gz -O xextproto-7.3.0.tar.gz --no-check-certificate
tar -xvzf xextproto-7.3.0.tar.gz
cd xextproto-7.3.0/
./configure
make
sudo make install

# xtrans 1.3.5
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/xtrans-1.3.5.tar.gz -O xtrans-1.3.5.tar.gz --no-check-certificate
tar -xvzf xtrans-1.3.5.tar.gz
cd xtrans-1.3.5/
./configure
make
sudo make install

# xcb-proto 1.12
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://xcb.freedesktop.org/dist/xcb-proto-1.12.tar.gz -O xcb-proto-1.12.tar.gz --no-check-certificate
tar -xvzf xcb-proto-1.12.tar.gz
cd xcb-proto-1.12/
./configure
make
sudo make install

# pthread-stubs 0.4
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.gz -O libpthread-stubs-0.4.tar.gz --no-check-certificate
tar -xvzf libpthread-stubs-0.4.tar.gz
cd libpthread-stubs-0.4/
./configure
make
sudo make install

# xau 1.0.8
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/libXau-1.0.8.tar.gz -O libXau-1.0.8.tar.gz --no-check-certificate
tar -xvzf libXau-1.0.8.tar.gz
cd libXau-1.0.8/
./configure
make
sudo make install

# xcb 1.12
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - xcb-proto
# - xau
# - pthread-stubs
cd ~/pepper_dep
wget https://xcb.freedesktop.org/dist/libxcb-1.12.tar.gz -O libxcb-1.12.tar.gz --no-check-certificate
tar -xvzf libxcb-1.12.tar.gz
cd libxcb-1.12/
./configure
make
sudo make install

# kbproto 1.0.7
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/kbproto-1.0.7.tar.gz -O kbproto-1.0.7.tar.gz --no-check-certificate
tar -xvzf kbproto-1.0.7.tar.gz
cd kbproto-1.0.7/
./configure
make
sudo make install

# inputproto 2.3
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/inputproto-2.3.tar.gz -O inputproto-2.3.tar.gz --no-check-certificate
tar -xvzf inputproto-2.3.tar.gz
cd inputproto-2.3/
./configure
make
sudo make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - xtrans
# - xcb
# - kbproto
# - inputproto
cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/libX11-1.6.5.tar.gz -O libX11-1.6.5.tar.gz --no-check-certificate
tar -xvzf libX11-1.6.5.tar.gz
cd libX11-1.6.5/
./configure
make
sudo make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - xproto
# - xextproto
# - x11
cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/libXext-1.3.3.tar.gz -O libXext-1.3.3.tar.gz --no-check-certificate
tar -xvzf libXext-1.3.3.tar.gz
cd libXext-1.3.3/
./configure
make
sudo make install

# damageproto 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/damageproto-1.2.1.tar.gz -O damageproto-1.2.1.tar.gz --no-check-certificate
tar -xvzf damageproto-1.2.1.tar.gz
cd damageproto-1.2.1/
./configure
make
sudo make install

# fixesproto 5.0
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive/individual/proto/fixesproto-5.0.tar.gz -O fixesproto-5.0.tar.gz --no-check-certificate
tar -xvzf fixesproto-5.0.tar.gz
cd fixesproto-5.0/
./configure
make
sudo make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - fixesproto
cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/libXfixes-5.0.tar.gz -O libXfixes-5.0.tar.gz --no-check-certificate
tar -xvzf libXfixes-5.0.tar.gz
cd libXfixes-5.0/
./configure
make
sudo make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - damageproto
# - xfixes
# - fixesproto
cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/libXdamage-1.1.tar.gz -O libXdamage-1.1.tar.gz --no-check-certificate
tar -xvzf libXdamage-1.1.tar.gz
cd libXdamage-1.1/
./configure
make
sudo make install

# xsmhfence 1.2
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - None
cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/libxshmfence-1.2.tar.gz -O libxshmfence-1.2.tar.gz --no-check-certificate
tar -xvzf libxshmfence-1.2.tar.gz
cd libxshmfence-1.2/
./configure
make
sudo make install

######################### TODO OK HASTA ACA? #########################

# gcc 4.8.5
# ---------------------------------------------------------
# notes:
# - This is the latest of the supported versions for LLVM
# - This takes a loooooooong time to compile (and a little time to download)
# - IT IS NECESSARY TO RESTART FOR CHANGES TO TAKE PLACE
# prerequisites:
# - None
cd ~/pepper_dep
wget https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz -O cmake-3.8.2.tar.gz --no-check-certificate
tar -xvzf cmake-3.8.2.tar.gz
cd cmake-3.8.2/
./configure
gmake
make
sudo make install

# gcc 4.8.5
# ---------------------------------------------------------
# notes:
# - This is the latest of the supported versions for LLVM
# - This takes a loooooooong time to compile (and a little time to download)
# - IT IS NECESSARY TO RESTART FOR CHANGES TO TAKE PLACE
# prerequisites:
# - None
cd ~/pepper_dep
wget ftp://ftp.gnu.org/gnu/gcc/gcc-4.8.5/gcc-4.8.5.tar.gz -O gcc-4.8.5.tar.gz --no-check-certificate
tar -xvzf gcc-4.8.5.tar.gz
cd gcc-4.8.5/
./configure
gmake
make
sudo make install

# llvm 4.0.0
# ---------------------------------------------------------
# notes:
# - This is the latest version
# prerequisites:
# - gcc >= 4.8
cd ~/pepper_dep
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang
cd ../..
mkdir build-llvm
cd build-llvm
cmake -G -DCMAKE_C_COMPILER=$(which gcc) "Unix Makefiles" ../llvm
make

# mesa 10.1.3
# ---------------------------------------------------------
# notes:
# - This is the required version because ... UNCLEAR
# prerequisites:
# - libxml2 for python2
# - glproto >= 1.4.14
# - many libx libraries
cd ~/pepper_dep
wget https://mesa.freedesktop.org/archive/older-versions/10.x/10.1.3/MesaLib-10.1.3.tar.gz -O MesaLib-10.1.3.tar.gz --no-check-certificate
tar -xvzf MesaLib-10.1.3.tar.gz
cd Mesa-10.1.3/
./configure
make
sudo make install


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
cd ~/pepper_dep
wget https://github.com/PointCloudLibrary/pcl/archive/pcl-1.7.2.tar.gz -O pcl-1.7.2.tar.gz
tar -xvzf pcl-1.7.2.tar.gz
mkdir -p pcl-pcl-1.7.2/build
cd pcl-pcl-1.7.2/build
cmake ..
sudo make install
