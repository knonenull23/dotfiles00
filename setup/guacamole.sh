sudo apt install libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin uuid-dev libossp-uuid-dev libvncserver-dev autotools-dev -y

sudo apt install default-jdk tomcat9 tomcat9-admin tomcat9-common tomcat9-user -y

sudo apt install x11vnc -y

cd /tmp
git clone https://www.github.com/apache/guacamole-server.git
cd guacamole-server
autoreconf -fi

./configure --with-init-dir=/etc/init.d
make
sudo make install
sudo ldconfig

sudo systemctl enable tomcat9
sudo systemctl enable guacd

VER=1.5.3
wget https://archive.apache.org/dist/guacamole/$VER/binary/guacamole-$VER.war
sudo mv guacamole-$VER.war /var/lib/tomcat9/webapps/guacamole.war

echo "guacd-hostname: localhost" | sudo tee /etc/guacamole/guacamole.properties
echo "guacd-port: 4822" | sudo tee -a /etc/guacamole/guacamole.properties
echo "user-mapping: /etc/guacamole/user-mapping.xml" | sudo tee -a /etc/guacamole/guacamole.properties
echo """
<user-mapping>

    <!-- Per-user authentication and config information -->
    <authorize username="admin" password="admin">
        <protocol>vnc</protocol>
        <param name="hostname">localhost</param>
        <param name="port">5900</param>
        <param name="password">password</param>
    </authorize>

</user-mapping>
""" | sudo tee /etc/guacamole/user-mapping.xml

sudo systemctl start tomcat9
sudo systemctl start guacd
