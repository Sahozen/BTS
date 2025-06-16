#mise a jour automatique critique de GLPI

sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades




sudo apt update
sudo apt install firejail
sudo firejail --net=none --private /usr/sbin/apache2



cd /tmp
wget https://github.com/glpi-project/glpi-inventory/releases/download/1.6.0/glpi-inventory-1.6.0.tar.gz
tar -xvzf glpi-inventory-1.6.0.tar.gz
sudo mv glpi-inventory /var/www/html/glpi/plugins/
sudo chown -R www-data:www-data /var/www/html/glpi/plugins/glpi-inventory
