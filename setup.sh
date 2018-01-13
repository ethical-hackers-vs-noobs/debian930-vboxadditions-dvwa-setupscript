tput setaf 2; echo "-----------------------"
echo "VM addons Debian 9.3.0"
tput setaf 2; echo "-----------------------"
echo "Setup script example for EHVSN by Stephan"
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "1. Copy VM additions files from mounted ISO "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
mkdir /home/blueteam/vmadd
cp -r /media/cdrom/. /home/blueteam/vmadd/.
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "2. Setting up GC++ for compiling "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
apt-get -y install gcc
apt-get -y install build-essential
apt-get -y install linux-headers-amd64 linux-headers-4.9.0-4-amd64
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "3. Setting up VM additions "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
cd /home/blueteam/vmadd/
chmod +r ./VBoxLinuxAdditions.run
./VBoxLinuxAdditions.run
cd ..
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "4. apt-get apache, php and sql "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
apt-get -y install apache2 mysql-server php php-mysqli php-gd
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "5. downloading DVWA "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
wget https://github.com/ethicalhack3r/DVWA/archive/master.zip
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "6. Extracting DVWA "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
unzip master.zip -d /var/www/html
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "7. Configuring DVWA "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
cd /var/www/html/DVWA-master/config/
cat config.inc.php.dist > config.inc.php
cd ..
mv * /var/www/html/
cd ..
rm -r DVWA-master/
chmod 777 /var/www/html/hackable/uploads/
chmod 777 /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
chmod 777 /var/www/html/config
sed -i 's/allow_url_include = Off/allow_url_include = On/g' /etc/php/7.0/apache2/php.ini
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "8. Restarting Apache/PHP "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
/etc/init.d/apache2 restart
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "9. Setting up database "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
echo "create database dvwa"|mysql
echo "grant all on dvwa.* to dvwa@localhost identified by 'newp@ssw0rd'"|mysql
echo "flush privileges"|mysql
tput setaf 3; echo "------------------------------------------------"
tput setaf 3; echo "10. Changing some php settings ... "
tput setaf 3; echo "------------------------------------------------"
tput sgr0
sed -i 's/root/dvwa/g' /var/www/html/config/config.inc.php
sed -i 's/p@ssw0rd/newp@ssw0rd/g' /var/www/html/config/config.inc.php
tput setaf 2; echo "---------------------------------------------------------------------"
tput setaf 2; echo "Finished, all should be setup now. FireFox is opening, scroll down on"
tput setaf 2; echo "the upcoming page and click the button at the bottom to finish"
tput setaf 2; echo "---------------------------------------------------------------------"
tput sgr0
firefox http://127.0.0.1/setup.php
