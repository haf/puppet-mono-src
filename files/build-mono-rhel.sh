#!/bin/sh

MONO_VERSION=$1
: ${MONO_VERSION:="3.0.6"}

# amusing hack to [fix the mono make file][1]
export echo=echo

# build libgdiplus
curl -O http://download.mono-project.com/sources/libgdiplus/libgdiplus-2.10.9.tar.bz2 || exit 1
if [ ! -f libgdiplus-2.10.9.tar ];
then
	bunzip2 libgdiplus-2.10.9.tar.bz2 || exit 2
fi
if [ ! -d libgdiplus-2.10.9 ];
then
	tar xvf libgdiplus-2.10.9.tar || exit 3
fi
cd libgdiplus-2.10.9
./configure --prefix=/usr/local || exit 4
make || exit 5
make install || exit 6

# build mono
curl -O http://download.mono-project.com/sources/mono/mono-$MONO_VERSION.tar.bz2 || exit 7
bunzip2 mono-$MONO_VERSION.tar.bz2 || exit 8
tar xvf mono-$MONO_VERSION.tar || exit 9
cd mono-$MONO_VERSION
./configure --prefix=/usr/local  || exit 10
make || exit 11
make install || exit 12

# tell binfmt how to launch CLR executables
echo ':CLR:M::MZ::/usr/local/bin/mono:' > /proc/sys/fs/binfmt_misc/register