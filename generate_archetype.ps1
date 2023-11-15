# Verifica se la cartella "general-archetype" esiste e cancellala se presente
if (Test-Path "general-archetype") {
    Write-Host "Rimozione della cartella 'general-archetype' esistente..."
    Remove-Item -Recurse -Force "general-archetype"
}

Write-Host "Clonazione del repository Git"
git clone https://github.com/vincenzo-ingenito/general-archetype.git

Write-Host "Cambio cartella a general-archetype"
Set-Location "general-archetype"

Write-Host "Generazione dell'archetipo"
mvn archetype:create-from-project

Write-Host "Cambio alla directory dell'archetipo generato"
Set-Location "target/generated-sources/archetype"

# Esegui 'clean install' per l'archetipo
Write-Host "Eseguo 'clean install' per l'archetipo..."
mvn clean install

# Installa l'archetipo nel repository locale
Write-Host "Installazione dell'archetipo nel repository locale..."
mvn install

Write-Host "Aggiornamento dell'indice catalogo locale"
mvn archetype:update-local-catalog

# Modifica il file pom.xml per cambiare il packaging
$filePath = "pom.xml"
$oldString = "<packaging>maven-archetype</packaging>"
$newString = "<packaging>pom</packaging>"
(Get-Content $filePath) -replace [regex]::Escape($oldString), $newString | Set-Content $filePath

Write-Host "Generazione del progetto dall'archetipo"
$groupId = Read-Host "Inserisci il groupId"
$artifactName = Read-Host "Inserisci il nome dell'artifact"
mvn archetype:generate -DarchetypeCatalog=local -DgroupId=$groupId -DartifactId=$artifactName

Set-Location $artifactName

Write-Host "Inizializzazione del repository Git"
git init
git add .
git commit -m "Inizializzo il nuovo progetto Spring Boot"

# Prompt per l'URL del repository remoto
$remoteUrl = Read-Host "Inserisci l'URL del repository remoto"

# Chiedi all'utente se vuole effettuare il push su GitHub
$pushChoice = Read-Host "Vuoi pushare il nuovo progetto su GitHub? (s/n)"

if ($pushChoice -eq "s") {
    git remote add origin $remoteUrl
    git push -u origin main

    # Se tutto va bene, stampa il messaggio di successo e attendi l'input dell'utente
    Write-Host "Progetto Spring Boot $artifactName creato e pushato con successo! Percorso attuale: $(Get-Location). Premi INVIO per continuare."
} else {
    # Se l'utente sceglie di non pushare, chiudi la shell
    Write-Host "Il progetto è stato creato ma non è stato pushato su GitHub. Chiudo la shell. Percorso attuale: $(Get-Location)."
    exit
}