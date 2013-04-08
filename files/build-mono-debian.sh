#!/bin/sh

sudo apt-get install -y mono-gmcs || exit 1

git clone git://github.com/mono/mono.git || exit 2
cd mono
git checkout 20e40c448cedb603f8c1bdf2b29ffc4d43b721b6 || exit 3
./autogen.sh || exit 4
make || exit 5
sudo make install || exit 6

cd ..
rm -fr mono || exit 7

sudo apt-get remove -y mono-gmcs || exit 8

exit 0
