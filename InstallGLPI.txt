# Créer une base de données pour GLPI
sudo mysql -u root -p
CREATE DATABASE glpi CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'glpiuser'@'localhost' IDENTIFIED BY 'Azerty123!';
GRANT ALL PRIVILEGES ON glpi.* TO 'Admin'@'localhost';
FLUSH PRIVILEGES;
QUIT;

# mise en place dns 
sudo nano /etc/hosts
172.16.1.4    glpi.alphatech.local

# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Installation des extensions PHP nécessaires
sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip php-intl php-bz2 php-json php-cli php-apcu php-intl php-ldap -y

# Redémarrer Apache
sudo systemctl restart apache2

# Télécharger et installer GLPI
cd /tmp
sudo wget https://github.com/glpi-project/glpi/releases/download/10.0.17/glpi-10.0.17.tgz
sudo tar -xzvf glpi-10.0.17.tgz -C /var/www/
sudo chown www-data /var/www/glpi/ -R

sudo mkdir /etc/glpi
sudo chown www-data /etc/glpi/

sudo mv /var/www/glpi/config /etc/glpi
sudo mkdir /var/lib/glpi
sudo chown www-data /var/lib/glpi/


sudo mv /var/www/glpi/files /var/lib/glpi

sudo mkdir /var/log/glpi
sudo chown www-data /var/log/glpi

sudo nano /var/www/glpi/inc/downstream.php

<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
    require_once GLPI_CONFIG_DIR . '/local_define.php';
}



sudo nano /etc/glpi/local_define.php

<?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files');
define('GLPI_LOG_DIR', '/var/log/glpi');


Initialiser sur le serveur web avant de supprimer le installphp



#Sécuriser le dossier racine du serveur web
sudo nano /etc/apache2/sites-available/glpi.alphatech.local.conf

<VirtualHost *:80>
    ServerName glpi.alphatech.local
    DocumentRoot /var/www/glpi/public

    <Directory /var/www/glpi/public>
        Require all granted
        RewriteEngine On
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ index.php [QSA,L]
    </Directory>

    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/"
    </FilesMatch>

</VirtualHost>

sudo a2ensite glpi.alphatech.local
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

sudo apt-get install php8.2-fpm
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php8.2-fpm
sudo systemctl reload apache2


#pour php
sudo nano /etc/php/8.2/apache2/php.ini

chercher : session.cookie_httponly = On

il doit être sur ON

sudo systemctl restart php8.2-fpm.service

sudo systemctl restart apache2


# Supprimer le fichier d'installation pour sécuriser GLPI
sudo rm /var/www/html/glpi/install/install.php



#pour securiser l'installation 
cd /var/www/html/glpi/install
sudo rm install.php

sudo systemctl restart apache2



/////////////////Depanage///////////////////
cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/10.0.10/glpi-10.0.10.tgz
tar -xvzf glpi-10.0.10.tgz
sudo cp /tmp/glpi/install/install.php /var/www/html/glpi/install/
sudo chown -R www-data:www-data /var/www/html/glpi/install
sudo chmod -R 755 /var/www/html/glpi/install

sudo rm /var/lib/glpi/config/config_db.php
sudo rm -rf /var/www/html/glpi
sudo rm -rf /var/lib/glpi



sudo ls /etc/apache2/sites-available/
sudo ls /etc/apache2/sites-enabled/

sudo systemctl status php8.2-fpm

sudo a2ensite glpi.alphatech.local
sudo systemctl reload apache2
sudo systemctl restart apache2
sudo systemctl restart php8.2-fpm

http://172.16.1.4
http://glpi.alphatech.local

sudo a2ensite glpi.alphatech.local
sudo systemctl reload apache2


ls /etc/apache2/sites-available/



