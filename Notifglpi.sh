sudo chown -R www-data:www-data /etc/glpi/


sudo chmod 640 /etc/glpi/config_db.php
sudo chmod 640 /etc/glpi/glpicrypt.key


sudo chown www-data:www-data /etc/glpi/local_define.php
sudo chmod 640 /etc/glpi/local_define.php


ls -l /etc/glpi/



sudo crontab -e 

*/1 * * * * /usr/bin/php /var/www/glpi/front/cron.php
