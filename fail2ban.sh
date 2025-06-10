# Mise à jour des paquets
sudo apt update && sudo apt upgrade -y
sudo apt install cockpit -y

sudo systemctl start cockpit
sudo systemctl enable cockpit

# Installation de fail2ban
sudo apt install fail2ban -y


sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local


sudo nano /etc/fail2ban/jail.local



sudo systemctl status rsyslog
sudo apt install rsyslog -y
sudo systemctl enable rsyslog
sudo systemctl start rsyslog

ls -l /var/log/auth.log

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 600


sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

sudo mkdir -p /usr/share/cockpit/fail2ban
cd /usr/share/cockpit/fail2ban
sudo git clone https://github.com/mmguero-dev/cockpit-fail2ban.git /usr/share/cockpit/fail2ban
sudo chown -R root:root /usr/share/cockpit/fail2ban

sudo systemctl restart cockpit

sudo apt install cockpit-fail2ban -y


sudo systemctl restart cockpit

# Voir les jails actives
sudo fail2ban-client status

# Voir les IP bannies pour sshd
sudo fail2ban-client status sshd

sudo fail2ban-client status

#pour deban
sudo fail2ban-client set sshd unbanip <IP>
