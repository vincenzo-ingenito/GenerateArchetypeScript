#!/bin/bash

# Verifica se la cartella "general-archetype" esiste e cancellala se presente
if [ -d "general-archetype" ]; then
    echo "Rimozione della cartella 'general-archetype' esistente..."
    rm -rf "general-archetype"
fi

echo "Clonazione del repository Git"
git clone https://github.com/vincenzo-ingenito/general-archetype.git

echo "Cambio cartella a general-archetype"
cd "general-archetype" || exit

echo "Generazione dell'archetipo"
mvn archetype:create-from-project

echo "Cambio alla directory dell'archetipo generato"
cd "target/generated-sources/archetype" || exit

# Esegui 'clean install' per l'archetipo
echo "Eseguo 'clean install' per l'archetipo..."
mvn clean install

# Installa l'archetipo nel repository locale
echo "Installazione dell'archetipo nel repository locale..."
mvn install

echo "Aggiornamento dell'indice catalogo locale"
mvn archetype:update-local-catalog

# Modifica il file pom.xml per cambiare il packaging
file_path="pom.xml"
old_string="<packaging>maven-archetype</packaging>"
new_string="<packaging>pom</packaging>"
sed -i '' "s|${old_string}|${new_string}|" "${file_path}"

echo "Generazione del progetto dall'archetipo"
read -p "Inserisci il groupId: " group_id
read -p "Inserisci il nome dell'artifact: " artifact_name
mvn archetype:generate -DarchetypeCatalog=local -DgroupId="${group_id}" -DartifactId="${artifact_name}"

cd "${artifact_name}" || exit

# Chiedi all'utente se vuole effettuare il push su GitHub
read -p "Vuoi pushare il nuovo progetto su GitHub? (s/n): " push_choice

if [ "$push_choice" == "s" ]; then
    # Prompt per l'URL del repository remoto
    read -p "Inserisci l'URL del repository remoto: " remote_url
    git init
    git add .
    git commit -m "Inizializzo il nuovo progetto Spring Boot"
    git remote add origin "${remote_url}"
    git push -u origin main

    # Se tutto va bene, stampa il messaggio di successo e attendi l'input dell'utente
    echo "Progetto Spring Boot ${artifact_name} creato e pushato con successo! Premi INVIO per continuare."
else
    # Se l'utente sceglie di non pushare, chiudi la shell
    echo "Il progetto è stato creato al percorso $(pwd) ma non è stato pushato su GitHub. Chiudo la shell."
    exit
fi