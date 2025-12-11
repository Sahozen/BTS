@echo off
:: =========================================================
:: Script Multi-Processus (Anti-Timeout)
:: =========================================================

:: 1. Nettoyage (On le fait en direct pour être sûr de repartir propre)
net use * /delete /yes

:: Variable du serveur
SET SERVEUR=\\WIN-SRV2.rania.local\Partage

:: 2. Lecteur Z: (Commun)
:: Celui-ci, on le lance normalement car tout le monde l'a, c'est rapide.
net use Z: "%SERVEUR%\Commun"

:: =========================================================
:: Lancement PARALLÈLE des lecteurs (Non-Bloquant)
:: La commande 'start' lance un nouveau terminal pour chaque ligne.
:: Le script principal continue sans attendre la réponse.
:: =========================================================

:: Syntaxe : start "Titre" /min cmd /c "ta commande"
:: /min : Lance la fenêtre réduite (invisible ou presque)
:: cmd /c : Exécute la commande et ferme la fenêtre tout de suite après

:: --- Tentatives pour les SERVICES ---
start "" /min cmd /c "net use S: \"%SERVEUR%\Commercial\Commun\" >nul 2>&1"
start "" /min cmd /c "net use T: \"%SERVEUR%\Compta\Commun\" >nul 2>&1"
start "" /min cmd /c "net use L: \"%SERVEUR%\Direction\Commun\" >nul 2>&1"
start "" /min cmd /c "net use R: \"%SERVEUR%\R&D\Commun\" >nul 2>&1"
start "" /min cmd /c "net use M: \"%SERVEUR%\Support\Commun\" >nul 2>&1"

:: --- Tentatives pour le PERSONNEL (U:) ---
:: On lance 5 processus en même temps. Seul le bon restera, les autres se fermeront en erreur silencieuse.
start "" /min cmd /c "net use U: \"%SERVEUR%\Commercial\%USERNAME%\" >nul 2>&1"
start "" /min cmd /c "net use U: \"%SERVEUR%\Compta\%USERNAME%\" >nul 2>&1"
start "" /min cmd /c "net use U: \"%SERVEUR%\Direction\%USERNAME%\" >nul 2>&1"
start "" /min cmd /c "net use U: \"%SERVEUR%\R&D\%USERNAME%\" >nul 2>&1"
start "" /min cmd /c "net use U: \"%SERVEUR%\Support\%USERNAME%\" >nul 2>&1"

:: Le script principal s'arrête ici instantanément, les lecteurs apparaîtront
:: au fur et à mesure qu'ils réussissent en arrière-plan.
exit
