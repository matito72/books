# books

Progetto Flutter per il censimento libri.


## Basato su

- Google Book API  [Google Book API](https://developers.google.com/books/docs/v1/using?hl=it)
  - Che permette di ricavare dati (JSON) su un libro anche solo tramite il suo ISBN

- Isar Community  [Isar Community](https://pub.dev/packages/isar_community)
  >- Crazy fast NoSQL database that is a joy to use.

## Link con i compilati:
Compilati per smastphon e Linux:  [https://drive.google.com/drive/folders/1bMw7v48eIVR-BovkOfYxKA2ClekME_tE]

## Installazione:
La libreria ISAR non è aggiornatissima e mal sopporta le ultime versioni di Android, comunque funziona

<img src="imagesReadMe/compatibilita_android.png" style="width:300px; height:500px;">

## Pagina iniziale da cui creare e selezionare le Librerie:
<img src="imagesReadMe/es_librerie.png" style="width:300px; height:500px;">

## Inserimento tramite scansione del codice a barre (ISBN)
- Se non riesce, appare la ricerca manuale

<img src="imagesReadMe/ricerca_libri_in_google.png" style="width:300px; height:500px;">

- esempio

<img src="imagesReadMe/es_ricerca_libri_in_google.png" style="width:300px; height:500px;">

## Inserimento manuale
<img src="imagesReadMe/inserimento_nuovo_libro.png" style="width:300px; height:500px;">

## Modifica dell'immagine del libro
Di default le API di Google restituiscono puntamenti ad immagini a bassa risoluzione.<br>

<img src="imagesReadMe/es_foto_libro_bassa_risoluzione.png" style="width:300px; height:500px;">

E' comunque possibile modificare l'immagine;<br>

<img src="imagesReadMe/menu_immagine_libro.png" style="width:300px; height:500px;">

<img src="imagesReadMe/es_foto_libro_alta_risoluzione.png" style="width:300px; height:500px;">

### Note Estese

<img src="imagesReadMe/es_note_estese.png" style="width:300px; height:500px;">

### Scansioni:
Creazione PDF da associare al libro a partire dalla fotocamera e/o immagini in memoria

<img src="imagesReadMe/es_creazione_pdf_da_smartphone.png" style="width:300px; height:500px;">

### Links
E' possibile associare link al libro.<br>
Inoltre, se il libro è stato creato tramite scansione
del codice a barre e quindi interrogando le API di Google, viene associato un link in automatico
a cui si può accedere tramite browser

Es.:<br>

<img src="imagesReadMe/pippo_books.google.it.png" style="width:300px; height:500px;">


## Lista libri e menù operazioni
Dalla lista dei libri inseriti, apparternenti ad una o più librerie, sono disponibili una serie di operazioni:

<img src="imagesReadMe/menu_libri.png" style="width:300px; height:500px;">

### Filtro veloce

<img src="imagesReadMe/filtro_attivo.png" style="width:300px; height:500px;">

## Spostamento libri da una libreria ad un'altra

<img src="imagesReadMe/spostamento_libro_in_librerie.png" style="width:300px; height:500px;">

### Ricerca

<img src="imagesReadMe/ricerca_libri.png" style="width:300px; height:500px;">

<img src="imagesReadMe/lista_libri_ricerca_attiva.png" style="width:300px; height:500px;">

### Ordinamento

<img src="imagesReadMe/ordinamento.png" style="width:300px; height:500px;">

### Raggruppamento

<img src="imagesReadMe/raggruppamento.png" style="width:300px; height:500px;">

Esempio di lista libri raggruppata Autore e Titolo

<img src="imagesReadMe/raggruppamento_autore_titolo_attivo.png" style="width:300px; height:500px;">


## Backup ed estrazione dati
Excel con N pagine, tante le librerie coinvolte.<br>

<img src="imagesReadMe/es_excel.png" style="width:800px; height:400px;">

E JSON file per il backup/restore dei libri presenti nella singola libreria

<img src="imagesReadMe/es_file_backup.png" style="width:300px; height:500px;">

## Struttura cartelle
Tutti i file (json, immagini, excel, ...) prodotti dall'app, sono salvati in cartelle specifiche.<br>
Questo rende più facile portare tutto sul PC ed usare la stessa app versione Desktop

<img src="imagesReadMe/struttura_cartelle.png" style="width:400px; height:500px;">
