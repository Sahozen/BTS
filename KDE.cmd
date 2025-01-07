sudo apt install plasma-workspace plasma-discover -y
sudo apt install plasma-discover-backend-flatpak plasma-discover-backend-snap -y
sudo apt update
sudo apt upgrade -y
sudo apt install kde-cli-tools
kquitapp5 plasmashell && kstart5 plasmashell
mkdir -p ~/.local/share/plasma/desktoptheme
cp -r ~/Téléchargements/Sweet ~/.local/share/plasma/desktoptheme/
sudo cp -r ~/Téléchargements/Sweet /usr/share/plasma/desktoptheme/
ls ~/.local/share/plasma/desktoptheme/
ls /usr/share/plasma/desktoptheme/
