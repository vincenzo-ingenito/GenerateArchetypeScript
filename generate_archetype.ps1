# Check if the "general-archetype" folder exists and delete it if it does
if (Test-Path -Path "general-archetype" -PathType Container) {
    Write-Host "Removing existing 'general-archetype' folder..."
    Remove-Item -Path "general-archetype" -Recurse -Force
}

Write-Host "Git clone"
git clone https://github.com/vincenzo-ingenito/general-archetype.git

Write-Host "Change folder general-archetype"
Set-Location -Path "general-archetype" -ErrorAction Stop

Write-Host "Generazione archetipo"
mvn archetype:create-from-project

Write-Host "Change to generated archetype directory"
Set-Location -Path "target/generated-sources/archetype" -ErrorAction Stop

# Esegui 'clean install' per l'archetipo
Write-Host "Running 'clean install' for the archetype..."
mvn clean install

# Installa l'archetipo nel repository locale
Write-Host "Installing archetype in the local repository..."
mvn install

Write-Host "aggiorno indice catalogo locale"
mvn archetype:update-local-catalog

# Modifica il file pom.xml per cambiare il packaging
$file_path = "pom.xml"
$old_string = "<packaging>maven-archetype</packaging>"
$new_string = "<packaging>pom</packaging>"
(Get-Content -Path $file_path) | ForEach-Object { $_ -replace $old_string, $new_string } | Set-Content -Path $file_path

Write-Host "Genero progetto da archetipo"
$group_id = Read-Host "Inserisci il groupId"
$artifact_name = Read-Host "Inserisci il nome dell'artifact"
mvn archetype:generate -DarchetypeCatalog=local -DgroupId="$group_id" -DartifactId="$artifact_name"

Set-Location -Path $artifact_name -ErrorAction Stop

git init
git add .
git commit -m "Inizializzo il nuovo progetto Spring Boot"

# Prompt for the remote repository URL
$remote_url = Read-Host "Inserisci l'URL del repository remoto"
git remote add origin $remote_url
git push -u origin main

# Se tutto va bene, stampa il messaggio di successo e attendi l'input dell'utente
Read-Host "Progetto Spring Boot $artifact_name creato e pushato con successo! Premi INVIO per continuare."
