sudo apt-get update
sudo apt-get upgrade
sudo apt-get install certbot python3-certbot-apache

sudo certbot --apache --agree-tos --redirect --hsts -d glpi.alphatech.local --email email@alphatech.local

repondre : no 

Redirect permanent / https://glpi.alphatech.local

sudo nano /etc/apache2/sites-available/glpi.alphatech.local.conf

#entre les balise filesmatch et changer le port 80 en port 443 

SSLCertificateFile /etc/letsencrypt/live/glpi.alphatech.local/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/glpi.alphatech.local/privkey.pem
Include /etc/letsencrypt/options-ssl-apache.conf
Header always set Strict-Transport-Security "max-age=31536000"

sudo systemctl restart apache2

#puis tester le site et lancer une analyse

sudo certbot renew --dry-run

sudo crontab -e

0 5 * * * /usr/bin/certbot renew --quiet




