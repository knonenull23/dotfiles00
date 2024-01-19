sudo apt install make libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin uuid-dev libossp-uuid-dev libvncserver-dev autotools-dev libssh2-1-dev openssh-server -y

sudo apt install default-jdk tomcat9 tomcat9-admin tomcat9-common tomcat9-user -y

sudo apt install x11vnc tigervnc-standalone-server freerdp2-dev -y

sudo curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

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

mkdir -p /etc/guacamole

echo "guacd-hostname: localhost" | sudo tee /etc/guacamole/guacamole.properties
echo "guacd-port: 4822" | sudo tee -a /etc/guacamole/guacamole.properties
echo "user-mapping: /etc/guacamole/user-mapping.xml" | sudo tee -a /etc/guacamole/guacamole.properties
echo """
<user-mapping>

    <!-- Per-user authentication and config information -->
    <authorize username=\"admin\" password=\"admin\">
        <protocol>vnc</protocol>
        <param name=\"hostname\">localhost</param>
        <param name=\"port\">5900</param>
        <param name=\"password\">password</param>
        <param name=\"enable-sftp\">true</param>
        <param name=\"sftp-username\">ubuntu</param>
        <param name=\"sftp-password\">password</param>
        <param name=\"sftp-port\">22</param>
    </authorize>

</user-mapping>
""" | sudo tee /etc/guacamole/user-mapping.xml

sudo systemctl start tomcat9
sudo systemctl start guacd

x11vnc -bg -reopen -forever -display :0

# alias run="/usr/share/tomcat9/bin/startup.sh; sleep 3; guacd; vncserver :1"
# alias freerdp="DISPLAY=:1 freerdp-shadow-cli -auth"
