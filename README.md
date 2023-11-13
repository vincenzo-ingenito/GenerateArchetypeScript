# Script di Inizializzazione del Progetto

Questo script Bash automatizza il processo di creazione di un nuovo progetto Spring Boot da un archetipo Maven, apportando modifiche al progetto generato e spingendolo su un repository Git remoto.

## Prerequisiti

Assicurati di avere installati i seguenti prerequisiti sul tuo sistema:

- Git
- Maven

## Uso

1. Clona il repository "general-archetype":

    ```bash
    ./your-script-name.sh
    ```

2. Segui le istruzioni per personalizzare il tuo nuovo progetto Spring Boot:
    - Inserisci il `groupId` desiderato.
    - Inserisci il `artifactId` desiderato.
    - Inserisci l'URL del repository Git remoto.

3. Lo script eseguirà le seguenti azioni:
    - Clona il repository "general-archetype".
    - Genera un archetipo Maven dal progetto.
    - Modifica il file "pom.xml" per cambiare il packaging in "pom".
    - Esegui 'clean install' per l'archetipo.
    - Aggiorna il catalogo archetipo locale.
    - Genera un nuovo progetto Spring Boot dall'archetipo.
    - Inizializza un repository Git locale, aggiunge file, effettua commit delle modifiche.
    - Aggiunge un repository Git remoto e spinge il progetto.

4. Una volta completato, verrà visualizzato un messaggio di successo.

## Pulizia

Lo script rimuoverà automaticamente la cartella clonata "general-archetype" dopo aver completato la configurazione del progetto.

## Nota

Assicurati che il tuo sistema abbia le autorizzazioni necessarie per eseguire operazioni Git e scrivere nelle directory di destinazione.

**Importante:** Rivedi e personalizza lo script secondo necessità prima di eseguirlo nel tuo ambiente.

