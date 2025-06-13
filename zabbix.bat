@echo off
msiexec /i "‪\\alphatech.local\data\Partage\GPO\Application\zabbix_agent2_plugins-7.2.6-windows-amd64.msi" /quiet /norestart ^
SERVER=172.16.1.3 ^
SERVERACTIVE=172.16.1.3 ^
HOSTNAME=%COMPUTERNAME% ^
LOGTYPE=file ^
LOGFILE="C:\zabbix_agent2.log"


Ou

msiexec.exe /i "\\alphatech.local\data\Partage\GPO\Application\zabbix_agent2_plugins-7.2.6-windows-amd64.msi" /quiet /norestart RUNNOW=1 ADD_FIREWALL_EXCEPTION=1 EXECMODE=1 SERVER=172.16.1.3 SERVERACTIVE=172.16.1.3

msiexec.exe /i "\\alphatech.local\data\Partage\GPO\Application\OpenVPN-2.6.13-I001-amd64.msi" /quiet RUNNOW=1 ADD_FIREWALL_EXCEPTION=1 EXECMODE=1 ALLUSERS=1 DESKTOP_SHORCUT=1"


sudo wget https://repo.zabbix.com/zabbix/7.0/debian-arm64/pool/main/z/zabbix-release/zabbix-release_latest_7.0+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.0+debian12_all.deb
sudo apt update

sudo apt install zabbix-agent2

sudo nano /etc/zabbix/zabbix_agent2.conf
