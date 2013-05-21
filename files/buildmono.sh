# http://wiki.centos.org/HowTos/SetupRpmBuildEnvironment
sudo yum -y install gcc mysql-devel ruby-devel rubygems rpm-build redhat-rpm-config
sudo gem install fpm
./configure --prefix=/opt/mono
make
make install DESTDIR=/tmp/mono-install
sudo fpm -s dir -t rpm -n mono -v 3.0.6 -C /tmp/mono-install .
