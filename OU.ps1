# Importer le module Active Directory
Import-Module ActiveDirectory

# Définir le domaine et l'OU principal
$domain = "alphatech.local"
$ouBase = "OU=Utilisateurs,DC=alphatech,DC=local"

# Créer l'OU principale si elle n'existe pas encore
if (-not (Get-ADOrganizationalUnit -Filter { Name -eq "Utilisateurs" } -SearchBase "DC=alphatech,DC=local" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Utilisateurs" -Path "DC=alphatech,DC=local"
    Write-Output "OU 'Utilisateurs' créée avec succès."
}

# Définir les groupes d'utilisateur à créer
$groupNames = @(
    "IT",
    "R&D",
    "Direction",
    "Commerciaux",
    "Production"
    "Gestion"
)

# Créer chaque groupe sous l'OU Utilisateurs
foreach ($groupName in $groupNames) {
    $groupPath = "CN=$groupName,$ouBase"
    
    # Vérifier si le groupe existe déjà
    if (-not (Get-ADGroup -Filter { Name -eq $groupName } -SearchBase $ouBase -ErrorAction SilentlyContinue)) {
        # Créer le groupe de sécurité
        New-ADGroup -Name $groupName -Path $ouBase -GroupScope Global -GroupCategory Security -Description "Groupe pour les utilisateurs de $groupName" -ManagedBy "CN=Admins du domaine,CN=Users,DC=alphatech,DC=local"
        Write-Output "Groupe $groupName créé avec succès."
    }
    else {
        Write-Output "Groupe $groupName existe déjà."
    }
}
