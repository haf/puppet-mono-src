./configure --prefix=/opt/mono
make
make install DESTDIR=/tmp/mono-install
sudo fpm -s dir -t rpm -n mono -v 3.0.6 -C /tmp/mono-install .
