#/bin/bash!


# python -c "import wheel.pep425tags; print(wheel.pep425tags.get_supported())"



wget https://github.com/w568w/tensorflow-32-bit-for-linux/raw/master/tensorflow-1.9.0rc0-cp27-cp27mu-linux_i686.whl

pip install --user --upgrade tensorflow-1.9.0rc0-cp27-cp27mu-linux_i686.whl

# cp -r .local/ out/