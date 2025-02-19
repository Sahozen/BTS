# Activer WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Activer la Plateforme de machine virtuelle (pour WSL 2)
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# (Facultatif) Activer Hyper-V si besoin
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all /norestart

# Redémarrer
Restart-Computer

wsl --set-default-version 2

# 1) Télécharger le package .appx
Invoke-WebRequest -Uri https://aka.ms/wsl-debian-latest -OutFile .\Debian.appx -UseBasicParsing

# 2) Renommer en .zip
Rename-Item .\Debian.appx Debian.zip

# 3) Extraire
Expand-Archive .\Debian.zip .\Debian


# (ou) Pour WSL 2 :
wsl --import "Debian" "C:\WSL\Debian" ".\Debian\install.tar" --version 2

wsl -l -v

wsl -d Debian


# Activer Windows Subsystem for Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Activer la Virtual Machine Platform (nécessaire pour WSL 2)
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# (Optionnel) Activer Hyper-V
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all /norestart

# Redémarrer le serveur pour appliquer les modifications
Restart-Computer
