sudo apt-get update
sudo apt-get upgrade
sudo apt-get install certbot python3-certbot-apache

sudo certbot --apache --agree-tos --redirect --hsts -d glpi.alphatech.local --email email@alphatech.local

repondre : no 

Redirect permanent / https://glpi.alphatech.local

sudo nano /etc/apache2/sites-available/glpi.alphatech.local.conf
