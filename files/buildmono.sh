# http://wiki.centos.org/HowTos/SetupRpmBuildEnvironment
VERSION=${0:-3.0.10}
sudo yum -y install gcc mysql-devel ruby-devel rubygems rpm-build redhat-rpm-config gettext
sudo gem install fpm --no-rdoc --no-ri
curl -O --silent http://download.mono-project.com/sources/mono/mono-$VERSION.tar.bz2
tar jxf mono-$VERSION.tar.bz2
pushd mono-$VERSION
./configure --prefix=/opt/mono
make
make install DESTDIR=/tmp/mono-install
sudo fpm -s dir -t rpm -n mono -v $VERSION -C /tmp/mono-install .
