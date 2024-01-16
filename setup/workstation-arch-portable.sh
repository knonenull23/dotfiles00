sudo pacman -Sy cairo libpng tomcat9 tomcat-native libvncserver tigervnc unzip freerdp libssh2

sudo curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

cd /tmp
git clone https://aur.archlinux.org/uuid.git
cd uuid
makepkg -si

cd /tmp
git clone https://www.github.com/apache/guacamole-server.git
cd guacamole-server
autoreconf -fi

./configure --with-init-dir=/etc/init.d
make
sudo make install
sudo ldconfig

VER=1.5.3
wget https://archive.apache.org/dist/guacamole/$VER/binary/guacamole-$VER.war
sudo mv guacamole-$VER.war /usr/share/tomcat9/webapps/guacamole.war

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
        <param name=\"port\">5901</param>
        <param name=\"password\">password</param>
        <param name=\"enable-sftp\">true</param>
        <param name=\"sftp-username\">arch</param>
        <param name=\"sftp-password\">arch</param>
        <param name=\"sftp-port\">8022</param>
        <param name=\"sftp-directory\">/data/data/com.termux/files/home</param>
    </authorize>

</user-mapping>
""" | sudo tee /etc/guacamole/user-mapping.xml

echo """
session=xfce
geometry=1920x1080
localhost
alwaysshared
""" > $HOME/.vnc/config

vncpasswd
vncserver :1
guacd
/usr/share/tomcat9/bin/startup.sh

# alias run="/usr/share/tomcat9/bin/startup.sh; sleep 3; guacd; vncserver :1"
# alias freerdp="DISPLAY=:1 freerdp-shadow-cli -auth"
