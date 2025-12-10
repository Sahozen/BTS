@echo off
:: 1. On supprime tous les anciens lecteurs pour partir propre
:: (L'option /YES valide automatiquement sans poser de question)
net use * /delete /yes

:: 2. On mappe le lecteur Commun (Z:) accessible à tous
net use Z: "\\WIN-SRV2\Partage\Commun"

:: 3. On tente de mapper les lecteurs de SERVICE
:: Si l'utilisateur n'est pas du service, la commande échouera (Access Denied) et c'est normal.
:: Pour éviter de voir les messages d'erreurs rouges, on ajoute >nul 2>&1 à la fin.

net use S: "\\WIN-SRV2\Partage\Commercial\Commun" >nul 2>&1
net use T: "\\WIN-SRV2\Partage\Compta\Commun" >nul 2>&1
net use L: "\\WIN-SRV2\Partage\Direction\Commun" >nul 2>&1
net use R: "\\WIN-SRV2\Partage\R&D\Commun" >nul 2>&1
net use M: "\\WIN-SRV2\Partage\Support\Commun" >nul 2>&1

:: 4. On tente de mapper le lecteur PERSONNEL (U:)
:: Comme tes utilisateurs sont rangés dans des dossiers différents, on tente toutes les possibilités.
:: Seule la bonne fonctionnera (car l'utilisateur n'a pas accès aux dossiers des autres).

net use U: "\\WIN-SRV2\Partage\Commercial\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2\Partage\Compta\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2\Partage\Direction\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2\Partage\R&D\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2\Partage\Support\%USERNAME%" >nul 2>&1
