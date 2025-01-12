sudo a2enmod ssl

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install certbot python3-certbot-apache


sudo certbot --apache --agree-tos --redirect --hsts -d glpi.alphatech.local  --email thomas.kireche@alphatech.local
