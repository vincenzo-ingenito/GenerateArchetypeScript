#!/bin/bash

# Check if the "general-archetype" folder exists and delete it if it does
if [ -d "general-archetype" ]; then
    echo "Removing existing 'general-archetype' folder..."
    rm -rf "general-archetype"
fi

echo "Git clone"
git clone https://github.com/vincenzo-ingenito/general-archetype.git

echo "Change folder general-archetype"
cd "general-archetype" || exit

echo "Generazione archetipo"
mvn archetype:create-from-project

echo "Change to generated archetype directory"
cd "target/generated-sources/archetype" || exit

# Esegui 'clean install' per l'archetipo
echo "Running 'clean install' for the archetype..."
mvn clean install

# Installa l'archetipo nel repository locale
echo "Installing archetype in the local repository..."
mvn install

echo "aggiorno indice catalogo locale"
mvn archetype:update-local-catalog

# Modifica il file pom.xml per cambiare il packaging
file_path="pom.xml"
old_string="<packaging>maven-archetype</packaging>"
new_string="<packaging>pom</packaging>"
sed -i '' "s|${old_string}|${new_string}|" "${file_path}"

echo "Genero progetto da archetipo"
read -p "Inserisci il groupId: " group_id
read -p "Inserisci il nome dell'artifact: " artifact_name
mvn archetype:generate -DarchetypeCatalog=local -DgroupId="${group_id}" -DartifactId="${artifact_name}"

cd "${artifact_name}" || exit

git init
git add .
git commit -m "Inizializzo il nuovo progetto Spring Boot"

# Prompt for the remote repository URL
read -p "Inserisci l'URL del repository remoto: " remote_url
git remote add origin "${remote_url}"
git push -u origin main

# Se tutto va bene, stampa il messaggio di successo e attendi l'input dell'utente
read -p "Progetto Spring Boot ${artifact_name} creato e pushato con successo! Premi INVIO per continuare."