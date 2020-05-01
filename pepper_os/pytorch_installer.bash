pip install --user numpy ninja pyyaml setuptools cmake cffi typing

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch; git checkout v1.4.0; git submodule sync; git submodule update
cd third_party
rm -rf sleef
git clone https://github.com/awesomebytes/sleef
cd ..
sed -i 's/FIND_PACKAGE(AVX)/#FIND_PACKAGE(AVX)/g' cmake/Dependencies.cmake
export USE_MKLDNN=0
export USE_FBGEMM=0
export BUILD_TEST=0
linux32 python setup.py install --user
pip install future --user

