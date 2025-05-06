# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Installation d'Apache
sudo apt install apache2 -y
sudo chown -R www-data:www-data /var/www/html/

# Installation de MariaDB
sudo apt install mariadb-server mariadb-client -y
sudo mysql_secure_installation
sudo systemctl status mariadb

# Installation de PHP et des modules requis
sudo apt install php php-mbstring php-zip php-gd php-json php-curl php-cli -y

# Installation de phpMyAdmin
sudo apt install phpmyadmin -y

# Redémarrer Apache pour appliquer les changements
sudo systemctl restart apache2
sudo systemctl restart mariadb

# (Facultatif) Créer un utilisateur pour MariaDB
sudo mysql -u root -p


CREATE DATABASE glpi CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'Azerty123!';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
CREATE USER 'glpiuser'@'localhost' IDENTIFIED BY 'Azerty123!';
GRANT ALL PRIVILEGES ON glpi.* TO 'glpiuser'@'localhost';
FLUSH PRIVILEGES;
QUIT;


# Accéder à phpMyAdmin
http://<adresse-ip-du-serveur>/phpmyadmin

sudo systemctl restart apache2

sudo tail -f /var/log/apache2/error.log
