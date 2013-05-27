# http://wiki.centos.org/HowTos/SetupRpmBuildEnvironment
set -e

VERSION=${1:-3.0.10}

# build rpm
sudo yum -y install gcc mysql-devel ruby-devel rubygems rpm-build redhat-rpm-config gettext 
curl -O --silent http://download.mono-project.com/sources/mono/mono-$VERSION.tar.bz2

# for current HEAD: curl -O -k -L https://github.com/mono/mono/tarball/master
tar jxf mono-$VERSION.tar.bz2

pushd mono-$VERSION

# compile mono
# $ sudo yum -y install libtool
# $ pushd mono-mono-SOMEHASH
# $ ./autogen.sh --prefix=/opt/mono --with-sgen=yes --with-gc=sgen

./configure --prefix=/opt/mono --with-sgen=yes --with-gc=sgen
make
make install DESTDIR=/tmp/mono-$VERSION
popd

sudo gem install fpm --no-rdoc --no-ri
sudo fpm -s dir -t rpm -n mono -v $VERSION -C /tmp/mono-$VERSION .
