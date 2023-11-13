# Script di Inizializzazione del Progetto

Questo script Bash automatizza il processo di creazione di un nuovo progetto Spring Boot da un archetipo Maven, apportando modifiche al progetto generato e spingendolo su un repository Git remoto.

## Prerequisiti

Prima di eseguire lo script, assicurati di avere installati i seguenti software:

- **Git:** 
- **Maven:** 

## Passaggi dello Script

1. **Clonazione del Repository:**
   - Il repository ["general-archetype"](https://github.com/vincenzo-ingenito/general-archetype.git) viene clonato utilizzando il comando `git clone`.

2. **Generazione dell'Archetipo:**
   - Un archetipo Maven viene generato dal progetto utilizzando il comando `mvn archetype:create-from-project`.

3. **Modifica del File "pom.xml":**
   - Il file "pom.xml" viene modificato per cambiare il packaging da "maven-archetype" a "pom" utilizzando il comando `sed`.

4. **Build dell'Archetipo:**
   - Viene eseguito 'clean install' per l'archetipo utilizzando il comando `mvn clean install`.

5. **Aggiornamento dell'Indice Catalogo Locale:**
   - L'indice del catalogo locale viene aggiornato utilizzando il comando `mvn archetype:crawl`.

6. **Generazione del Progetto da Archetipo:**
   - L'utente inserisce il `groupId` e il `artifactId`, quindi il nuovo progetto Spring Boot viene generato utilizzando il comando `mvn archetype:generate`.

7. **Inizializzazione di Git e Push del Progetto:**
   - Viene inizializzato un repository Git locale, i file vengono aggiunti e committati. Successivamente, viene richiesto l'URL del repository Git remoto, e il progetto viene spinto al repository remoto utilizzando comandi Git.

## Nota

Assicurati che il tuo sistema abbia le autorizzazioni necessarie per eseguire operazioni Git e scrivere nelle directory di destinazione.

**Importante:** Rivedi e personalizza lo script secondo necessità prima di eseguirlo nel tuo ambiente.
