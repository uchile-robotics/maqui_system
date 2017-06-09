# Upgrade wget to version 1.15
cd ~
curl -O http://ftp.gnu.org/gnu/wget/wget-1.15.tar.gz
tar -zxvf wget-1.15.tar.gz
cd wget-1.15/
./configure
make
sudo make install
cd ~
rm -r wget-1.15 wget-1.15.tar.gz
##### You need to restart the machine for this changes to work ####

# We used 1.8.12 instead of 1.8.11 because of some source install errors
cd ~/pepper_dep
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.12/src/hdf5-1.8.12.tar.gz -O hdf5-1.8.12.tar.gz
tar -xvzf hdf5-1.8.12.tar.gz
mkdir -p hdf5-1.8.12/build
cd hdf5-1.8.12/build
cmake ..
sudo make install

# This needs more than 1 Gb in RAM or it won't work, i always use 4 just in case
cd ~/pepper_dep
wget https://github.com/uchile-robotics-forks/flann/archive/1.8.5.tar.gz -O flann-1.8.5.tar.gz
tar -xvzf flann-1.8.5.tar.gz
mkdir -p flann-1.8.5/build
cd flann-1.8.5/build
cmake ..
sudo make install

cd ~/pepper_dep
wget https://github.com/pkgconf/pkgconf/archive/pkgconf-0.9.12.tar.gz -O pkgconf-0.9.12.tar.gz
tar -xvzf pkgconf-0.9.12.tar.gz
cd pkgconf-pkgconf-0.9.12/
./autogen.sh
./configure
make
sudo make install

cd ~/pepper_dep
wget https://github.com/GNOME/libxml2/archive/v2.9.4.tar.gz -O libxml2-v2.9.4.tar.gz
tar -xvzf libxml2-v2.9.4.tar.gz
cd libxml2-2.9.4/
./autogen.sh
make
sudo make install

cd ~/pepper_dep
wget https://www.x.org/archive//individual/util/util-macros-1.7.0.tar.gz -O util-macros-1.7.0.tar.gz --no-check-certificate
tar -xvzf util-macros-1.7.0.tar.gz
cd util-macros-1.7.0/
./configure
make
sudo make install

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


# TODO OK HASTA ACÁ
###########################################################################


cd ~/pepper_dep
wget https://www.x.org/archive//individual/lib/libX11-1.5.0.tar.gz -O libX11-1.5.0.tar.gz --no-check-certificate
tar -xvzf libX11-1.5.0.tar.gz
cd libX11-1.5.0/
./configure
make
sudo make install


cd ~/pepper_dep
wget https://mesa.freedesktop.org/archive/older-versions/10.x/10.1.3/MesaLib-10.1.3.tar.gz -O MesaLib-10.1.3.tar.gz --no-check-certificate
tar -xvzf MesaLib-10.1.3.tar.gz
cd Mesa-10.1.3/
./configure
make
sudo make install


# esa version sirve
cd ~/pepper_dep
wget https://github.com/PointCloudLibrary/pcl/archive/pcl-1.7.2.tar.gz -O pcl-1.7.2.tar.gz
tar -xvzf pcl-1.7.2.tar.gz
mkdir -p pcl-pcl-1.7.2/build
cd pcl-pcl-1.7.2/build
cmake ..
sudo make install
