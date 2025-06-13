@echo off
msiexec /i "\\%~dp0zabbix_agent2-6.4.3-windows-amd64-openssl.msi" /quiet /norestart ^
SERVER=172.16.1.3 ^
SERVERACTIVE=172.16.1.3 ^
HOSTNAME=%COMPUTERNAME% ^
LOGTYPE=file ^
LOGFILE="C:\zabbix_agent2.log"
