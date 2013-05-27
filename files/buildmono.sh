# http://wiki.centos.org/HowTos/SetupRpmBuildEnvironment
set -e
VERSION=${1:-3.0.10}
sudo yum -y install gcc mysql-devel ruby-devel rubygems rpm-build redhat-rpm-config gettext
sudo gem install fpm --no-rdoc --no-ri
curl -O --silent http://download.mono-project.com/sources/mono/mono-$VERSION.tar.bz2
# for current HEAD: curl -O -k -L https://github.com/mono/mono/tarball/master
tar jxf mono-$VERSION.tar.bz2
pushd mono-$VERSION
./configure --prefix=/opt/mono
make
make install DESTDIR=/tmp/mono-$VERSION
popd
sudo fpm -s dir -t rpm -n mono -v $VERSION -C /tmp/mono-$VERSION .
