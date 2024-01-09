sudo apt install libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin uuid-dev libossp-uuid-dev libvncserver-dev autotools-dev -y

cd /tmp
git clone https://www.github.com/apache/guacamole-server.git
cd guacamole-server
autoreconf -fi

./configure --with-init-dir=/etc/init.d
make
sudo make install
sudo ldconfig
