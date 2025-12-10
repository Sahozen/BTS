@echo off
:: 1. Suppression des anciens lecteurs
net use * /delete /yes

:: 2. Lecteur COMMUN (Z:) - Accessible à tous
net use Z: "\\WIN-SRV2.rania.local\Partage\Commun"

:: 3. Tentative de mappage des lecteurs de SERVICE (S, T, L, R, M)
:: Les >nul 2>&1 servent à cacher l'erreur si l'utilisateur n'a pas le droit
net use S: "\\WIN-SRV2.rania.local\Partage\Commercial\Commun" >nul 2>&1
net use T: "\\WIN-SRV2.rania.local\Partage\Compta\Commun" >nul 2>&1
net use L: "\\WIN-SRV2.rania.local\Partage\Direction\Commun" >nul 2>&1
net use R: "\\WIN-SRV2.rania.local\Partage\R&D\Commun" >nul 2>&1
net use M: "\\WIN-SRV2.rania.local\Partage\Support\Commun" >nul 2>&1

:: 4. Tentative de mappage du lecteur PERSONNEL (U:)
:: On essaie tous les chemins possibles, seul le bon fonctionnera
net use U: "\\WIN-SRV2.rania.local\Partage\Commercial\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2.rania.local\Partage\Compta\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2.rania.local\Partage\Direction\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2.rania.local\Partage\R&D\%USERNAME%" >nul 2>&1
net use U: "\\WIN-SRV2.rania.local\Partage\Support\%USERNAME%" >nul 2>&1
