# === Étape 1 : Vérifie que le service Fail2Ban est bien actif ===
sudo systemctl status fail2ban

# === Étape 2 : Affiche les jails actives (ici on vérifie que 'sshd' est bien chargé) ===
sudo fail2ban-client status

# === Étape 3 : Affiche l'état de la jail SSH ===
sudo fail2ban-client status sshd

# === Étape 4 : Depuis une autre machine (ou un terminal séparé), simule plusieurs connexions SSH échouées ===
# (remplacer <ip_de_ton_serveur> par l'adresse réelle du serveur)
# Répéter cette commande 3 à 5 fois pour déclencher le bannissement
ssh fakeuser@<ip_de_ton_serveur>

# === Étape 5 : Sur le serveur, vérifie les logs des échecs de connexion SSH ===
# Cela montre que les tentatives ont bien été enregistrées par le système
sudo grep 'sshd' /var/log/auth.log | grep 'Failed'

# === Étape 6 : Vérifie que l'adresse IP a bien été bannie ===
# Cette commande te montre combien d'IP sont bannies et lesquelles
sudo fail2ban-client status sshd

# === Étape 7 : Vérifie le bannissement au niveau du pare-feu (iptables ou nftables) ===

# Pour les systèmes utilisant iptables
sudo iptables -L -n | grep <ip_client>

# Pour les systèmes utilisant nftables (Debian 11+, Ubuntu 22+)
sudo nft list ruleset | grep <ip_client>

# === Étape 8 : Débannir l'adresse IP manuellement si besoin ===
# (remplace <ip_client> par l'adresse IP bannie)
sudo fail2ban-client set sshd unbanip <ip_client>
