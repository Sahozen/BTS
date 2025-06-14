#Linux agent 
cd /tmp
wget https://github.com/glpi-project/glpi-agent/releases/download/1.11/glpi-agent_1.11-1_all.deb
sudo apt update
sudo apt-get install -y wget curl perl libwww-perl libjson-perl libnet-ssleay-perl libnet-cups-perl libproc-daemon-perl
sudo apt-get install libnet-ip-perl libnet-ssh2-perl libparse-edid-perl libparallel-forkmanager-perl libuniversal-require-perl libfile-which-perl libxml-libxml-perl libyaml-perl libtext-template-perl libcpanel-json-xs-perl libyaml-tiny-perl libsocket-getaddrinfo-perl libdata-uuid-perl libdbi-perl libdbd-mysql-perl
sudo apt-get install libdata-uuid-perl
sudo dpkg -i glpi-agent_1.11-1_all.deb
sudo apt --fix-broken install
sudo apt-get update
sudo apt-get install \
  libxml-treepp-perl \
  libuniversal-require-perl \
  libswitch-perl \
  libhttp-daemon-perl \
  libfile-copy-recursive-perl \
  libproc-processtable-perl
glpi-agent --version
sudo chown -R www-data:www-data /var/www/glpi
sudo chmod -R 755 /var/www/glpi
sudo a2enmod rewrite
sudo systemctl restart apache2
sudo systemctl enable glpi-agent
sudo systemctl start glpi-agent
sudo systemctl status glpi-agent
curl -v http://glpi.alphatech.local/front/inventory.php
sudo glpi-agent --server http://glpi.alphatech.local/front/inventory.php --debug
rm -rf ~/Téléchargements/GLPI-Agent-1.11.tar.gz

sudo nano /etc/apache2/sites-available/glpi.conf

<Directory /var/www/glpi/public>
    Require all granted
</Directory>

sudo systemctl reload apache2
sudo a2enmod rewrite proxy_fcgi
sudo systemctl reload apache2

sudo systemctl unmask glpi-agent
sudo systemctl enable glpi-agent
sudo systemctl start glpi-agent


sudo glpi-agent --configure

sudo nano /etc/glpi-agent/agent.cfg
server = http://glpi.alphatech.local/front/inventory.php


sudo systemctl stop glpi-agent
sudo systemctl disable glpi-agent
sudo apt remove --purge glpi-agent -y
sudo rm -rf /etc/glpi-agent
sudo rm -rf /var/log/glpi-agent
sudo rm -rf /var/lib/glpi-agent
sudo find / -name "glpi-agent" 2>/dev/null



/quiet /i "\\alphatech.local\data\Partage\GPO\Application\GLPI-Agent-1.11-x64.msi" RUNNOW=1 ADD_FIREWALL_EXCEPTION=1 EXECMODE=1 SERVER="http://glpi.alphatech.local/front/inventory.php"

msiexec.exe /i "\\alphatech.local\data\Partage\GPO\Application\openvpn-connect-3.7.2.4253_signed.msi" /quiet RUNNOW=1 ADD_FIREWALL_EXCEPTION=1 EXECMODE=1 ALLUSERS=1 DESKTOP_SHORCUT=1"

msiexec.exe /i "\\alphatech.local\data\Partage\GPO\Application\OpenVPN-2.6.13-I001-amd64.msi" /quiet RUNNOW=1 ADD_FIREWALL_EXCEPTION=1 EXECMODE=1 ALLUSERS=1 DESKTOP_SHORCUT=1"

Pour la GPO
# Journalisation
$LogFile = "C:\GLPI_Agent_Install.log"
"Script exécuté à $(Get-Date)" | Out-File -FilePath $LogFile -Append

# Installation de l'agent
# Variables
$AgentPath = "\\alphatech.local\data\Partage\GPO\Application\GLPI-Agent-1.11-x64.msi"
$ServerURL = "http://glpi.alphatech.local/front/inventory.php"
$AgentOptions = "RUNNOW=1 ADDLOCAL=feat_NETINV,feat_DEPLOY,feat_COLLECT,feat_WOL SERVER=$ServerURL"

# Fonction pour vérifier si l'agent est déjà installé
Function Is-AgentInstalled {
    $AgentInstalled = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "GLPI Agent*" }
    return $AgentInstalled -ne $null
}

# Si l'agent n'est pas installé, procéder à l'installation
if (-not (Is-AgentInstalled)) {
    Write-Host "Installation de l'agent GLPI..."
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$AgentPath`" $AgentOptions /quiet /norestart" -Wait -NoNewWindow
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Agent GLPI installé avec succès."
    } else {
        Write-Host "Erreur lors de l'installation de l'agent GLPI."
    }
} else {
    Write-Host "Agent GLPI déjà installé."
}


