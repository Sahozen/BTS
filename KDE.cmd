sudo apt install plasma-workspace plasma-discover -y
sudo apt install plasma-discover-backend-flatpak plasma-discover-backend-snap -y
sudo apt update
sudo apt upgrade -y
sudo apt install kde-cli-tools
kquitapp5 plasmashell && kstart5 plasmashell
mkdir -p ~/.local/share/plasma/desktoptheme
cp -r ~/Téléchargements/Sweet ~/.local/share/plasma/desktoptheme/
sudo cp -r ~/Téléchargements/Sweet /usr/share/plasma/desktoptheme/
ls -l /usr/share/plasma/desktoptheme/
cd ~/.local/share/plasma/desktoptheme/Sweet
X-KDE-PluginInfo-Category=Plasma/LookAndFeel

sudo chmod -R 755 /usr/share/plasma/desktoptheme/Sweet
kquitapp5 plasmashell && kstart5 plasmashell
sudo reboot

mkdir -p ~/.local/share/icons
cp -r ~/Téléchargements/candy-icons ~/.local/share/icons/
cp -r ~/Téléchargements/Sweet ~/.local/share/plasma/desktoptheme/
mkdir -p ~/.local/share/color-schemes
cp ~/Téléchargements/*.colorscheme ~/.local/share/color-schemes/
mkdir -p ~/.local/share/aurorae/themes
cp -r ~/Téléchargements/Vivid-Blur-Dark-Aurorae-6 ~/.local/share/aurorae/themes/


