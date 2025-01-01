# Script PowerShell pour la création des dossiers partagés avec permissions personnalisées

# Variables globales
$baseSharePath = "C:\Partage" # Emplacement de base des dossiers partagés
$ouPath = "OU=Utilisateurs,DC=alphatech,DC=local" # Chemin LDAP de l'OU contenant les groupes d'utilisateurs

# Création du dossier de base si non présent
if (-not (Test-Path -Path $baseSharePath)) {
    New-Item -Path $baseSharePath -ItemType Directory -Force
    Write-Host "Dossier de base Partage créé."
} else {
    Write-Host "Dossier de base Partage existe déjà."
}

# Partager le dossier de base pour tout le domaine
$shareName = "Partage"
net share $shareName="$baseSharePath" /grant:"ALPHATECH\Domain Users",READ /grant:"ALPHATECH\Admins du domaine",FULL /grant:"ALPHATECH\Administrateurs",FULL

# Récupérer les groupes d'utilisateurs de l'OU "Utilisateurs"
Import-Module ActiveDirectory
$groups = Get-ADGroup -Filter * -SearchBase $ouPath

# Créer des dossiers pour chaque groupe utilisateur
foreach ($group in $groups) {
    $groupName = $group.Name
    $groupPath = Join-Path -Path $baseSharePath -ChildPath $groupName

    # Créer le dossier du groupe s'il n'existe pas
    if (-not (Test-Path -Path $groupPath)) {
        New-Item -Path $groupPath -ItemType Directory -Force
        Write-Host "Dossier pour le groupe $groupName créé."
    } else {
        Write-Host "Dossier pour le groupe $groupName existe déjà."
    }

    # Désactiver l'héritage et supprimer les autorisations héritées
    if (Test-Path -Path $groupPath) {
        $acl = Get-Acl -Path $groupPath
        $acl.SetAccessRuleProtection($true, $false) # Désactiver l'héritage et supprimer les permissions héritées
        Set-Acl -Path $groupPath -AclObject $acl
    }

    # Configuration des permissions d'accès pour chaque dossier de groupe
    # Les administrateurs du domaine ont accès à tous les dossiers
    $domainAdmins = [System.Security.Principal.NTAccount]::new("ALPHATECH\Admins du domaine")
    $acl = Get-Acl -Path $groupPath
    $domainAdminsRule = New-Object System.Security.AccessControl.FileSystemAccessRule($domainAdmins, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
    $acl.SetAccessRule($domainAdminsRule)

    # Donner les permissions au groupe spécifique
    try {
        $groupAccount = [System.Security.Principal.NTAccount]::new("ALPHATECH\$groupName")
        $groupRule = New-Object System.Security.AccessControl.FileSystemAccessRule($groupAccount, "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.SetAccessRule($groupRule)
    } catch {
        Write-Error "Erreur lors de la création des permissions pour le groupe $groupName : $_"
    }

    # Appliquer les modifications de permissions
    try {
        Set-Acl -Path $groupPath -AclObject $acl
        Write-Host "Permissions configurées pour le dossier $groupName."
    } catch {
        Write-Error "Erreur lors de la configuration des permissions pour le dossier $groupName : $_"
    }

    # Créer des sous-répertoires spécifiques pour chaque groupe
    switch ($groupName) {
        "Commerciaux" {
            $subfolders = @("Clients")
        }
        "Direction" {
            $subfolders = @("Stratégie", "Rapports")
        }
        "IT" {
            $subfolders = @("Infrastructure", "Support", "GPO", "Scripts")
        }
        "Production" {
            $subfolders = @("Chaine de Production", "Qualite")
        }
        "Administratifs" {
            $subfolders = @("RH", "Comptabilite")
        }
        "Gestion" {
            $subfolders = @("Finances", "Audit")
        }
        "RechercheEtDeveloppement" {
            $subfolders = @("Projets", "Innovations")
        }
        default {
            $subfolders = @("Documents", "Projets", "Archives")
        }
    }

    foreach ($subfolder in $subfolders) {
        $subfolderPath = Join-Path -Path $groupPath -ChildPath $subfolder
        if (-not (Test-Path -Path $subfolderPath)) {
            New-Item -Path $subfolderPath -ItemType Directory -Force
            Write-Host "Sous-dossier $subfolder créé pour le groupe $groupName."
        } else {
            Write-Host "Sous-dossier $subfolder existe déjà pour le groupe $groupName."
        }
    }
}

# Créer un dossier GPO avec accès en lecture pour tous les utilisateurs sauf les administrateurs de domaine
$gpoPath = Join-Path -Path $baseSharePath -ChildPath "GPO"
if (-not (Test-Path -Path $gpoPath)) {
    New-Item -Path $gpoPath -ItemType Directory -Force
    Write-Host "Dossier GPO créé."
} else {
    Write-Host "Dossier GPO existe déjà."
}

# Configurer les permissions pour le dossier GPO
$acl = Get-Acl -Path $gpoPath

# Les administrateurs du domaine ont un contrôle total
$domainAdmins = [System.Security.Principal.NTAccount]::new("ALPHATECH\Admins du domaine")
$domainAdminsRule = New-Object System.Security.AccessControl.FileSystemAccessRule($domainAdmins, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($domainAdminsRule)

# Tous les utilisateurs du domaine ont accès en lecture
$domainUsers = [System.Security.Principal.NTAccount]::new("ALPHATECH\Domain Users")
$domainUsersRule = New-Object System.Security.AccessControl.FileSystemAccessRule($domainUsers, "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($domainUsersRule)

# Appliquer les modifications de permissions
try {
    Set-Acl -Path $gpoPath -AclObject $acl
    Write-Host "Permissions configurées pour le dossier GPO."
} catch {
    Write-Error "Erreur lors de la configuration des permissions pour le dossier GPO : $_"
}

Write-Host "Création des dossiers partagés terminée."
