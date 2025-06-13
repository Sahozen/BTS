@echo off
msiexec /i "‪\\alphatech.local\data\Partage\GPO\Application\zabbix_agent2_plugins-7.2.6-windows-amd64.msi" /quiet /norestart ^
SERVER=172.16.1.3 ^
SERVERACTIVE=172.16.1.3 ^
HOSTNAME=%COMPUTERNAME% ^
LOGTYPE=file ^
LOGFILE="C:\zabbix_agent2.log"
