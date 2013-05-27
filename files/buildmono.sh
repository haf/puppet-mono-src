# http://wiki.centos.org/HowTos/SetupRpmBuildEnvironment
set -e

VERSION=${1:-3.0.7}

# build rpm
sudo yum -y install gcc mysql-devel ruby-devel rubygems rpm-build redhat-rpm-config gettext libtool
curl -O --silent http://download.mono-project.com/sources/mono/mono-$VERSION.tar.bz2

tar jxf mono-$VERSION.tar.bz2

# for current HEAD: curl -O -L https://github.com/mono/mono/tarball/master
# $ pushd mono-mono-SOMEHASH
# $ ./autogen.sh --prefix=/opt/mono #--with-sgen=yes --with-gc=sgen

pushd mono-$VERSION
curl -O https://raw.github.com/EventStore/EventStore/master/src/EventStore/Scripts/mono/0001-ES-patch.patch
patch -p1 < 0001-ES-patch.patch
./configure --prefix=/opt/mono #--with-sgen=yes --with-gc=sgen
make
make install DESTDIR=/tmp/mono-$VERSION
popd

sudo gem install fpm --no-rdoc --no-ri
sudo fpm -s dir -t rpm -n mono -v $VERSION -C /tmp/mono-$VERSION .
