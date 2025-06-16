#Securistaiton mdp 

sudo apt update
sudo apt install libpam-pwquality

sudo nano /etc/security/pwquality.conf

minlen = 8
dcredit = -1
ucredit = -1
ocredit = -1
lcredit = -1
retry = 3

sudo nano /etc/pam.d/common-password


sudo adduser testuser

rejet
azerty

accepté 

Azerty123!

#mise a jour automatique critique de GLPI

sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

cat /etc/apt/apt.conf.d/50unattended-upgrades

systemctl status apt-daily-upgrade.timer


#mise en place firejail et test firefox 
sudo apt update
sudo apt install firejail
sudo firejail --net=none --private /usr/sbin/apache2

sudo apt install firefox-esr -y


sudo apt update
sudo apt install firejail firefox-esr

firejail firefox

Reading profile /etc/firejail/firefox.profile
Parent pid 1234, child pid 1235
...

sudo apt install chromium -y

firejail chromium

firejail --private chromium



ps aux | grep firejail

firejail --list

#glpi inventory 

sudo find / -type d -name glpi 2>/dev/null


cd /var/www/glpi/plugins/

ls
sudo https://github.com/glpi-project/glpi-inventory-plugin/releases/download/1.5.3/glpi-glpiinventory-1.5.3.tar.bz2
tar -xvjf glpi-glpiinventory-1.5.3.tar.bz2
sudo mv glpi-inventory /var/www/glpi/plugins/
chown -R www-data:www-data /var/www/glpi/plugins/glpi-inventory




