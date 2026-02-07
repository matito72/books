# books

Progetto Flutter per il censimento libri.


## Basato su

- Google Book API  [Google Book API](https://developers.google.com/books/docs/v1/using?hl=it)
  - Che permette di ricavare dati (JSON) su un libro anche solo tramite il suo ISBN

- Isar Community  [Isar Community](https://pub.dev/packages/isar_community)
  >- Crazy fast NoSQL database that is a joy to use.

## Link con i compilati:
- Compilati per Android e Linux:  
- <a href="https://drive.google.com/drive/folders/1bMw7v48eIVR-BovkOfYxKA2ClekME_tE" target="_blank">qui</a>


## Installazione:
La libreria ISAR non è aggiornatissima e mal sopporta le ultime versioni di Android, comunque funziona

<img src="imagesReadMe/compatibilita_android.png" style="width:300px; height:500px;">

## Pagina iniziale da cui creare e selezionare le Librerie:
<img src="imagesReadMe/es_librerie.png" style="width:300px; height:500px;">

## Lista libri inseriti
Qui ci sono tutti i libri inseriti relativi alle librerie precedentemente selezionate
<img src="imagesReadMe/lista_libri_inseriti.png" style="width:300px; height:500px;">

## Inserimento tramite scansione del codice a barre (ISBN)
- Nei migliori dei casi dal codice a barre si ricavano quasi tutti i dati.  

<img src="imagesReadMe/es_libro_inserito.png" style="width:300px; height:500px;">

- Se la ricerca automatica, tramite codice a barre, non riesce, appare la ricerca manuale, che interroga sempre le API di Google

<img src="imagesReadMe/ricerca_libri_in_google.png" style="width:300px; height:500px;">

- e risponde con una lista di libri da cui scegliere 

<img src="imagesReadMe/es_ricerca_libri_in_google.png" style="width:300px; height:500px;">

## Inserimento manuale
Se il libro non è presente nel catalogo Google, c'è l'inserimento manuale 
<img src="imagesReadMe/inserimento_nuovo_libro.png" style="width:300px; height:500px;">

# Modifiche varie...
## Modifica dell'immagine del libro
Di default le API di Google restituiscono puntamenti ad immagini a bassa risoluzione.<br>

<img src="imagesReadMe/es_foto_libro_bassa_risoluzione.png" style="width:300px; height:500px;">

Sempre con un po' di fortuna, o con l'aiuto della fotocamera, è comunque possibile modificare l'immagine;<br>

<img src="imagesReadMe/es_foto_libro_alta_risoluzione.png" style="width:300px; height:500px;">

### Note Estese

<img src="imagesReadMe/es_note_estese.png" style="width:300px; height:500px;">

### Scansioni:
Tramite fotocamera, o foto in galleria, è possibile creare PDF da associare al libro.
Di seguito una fota gà associata, il suo PDF e il relativo testo, il quale è oggetto di ricerca qualora si cerchi un libro all'interno tra quelli inseriti.
 
<img src="imagesReadMe/es_creazione_pdf_da_smartphone.png" style="width:300px; height:500px;">

<img src="imagesReadMe/es_PDF.png" style="width:300px; height:500px;">

<img src="imagesReadMe/es_testo_estratto.png" style="width:300px; height:500px;">

### Link
E' possibile associare link al libro.<br>
Se il libro era presente nel catalogo Google, gli viene associato un link in automatico.
Tutti i link poi si apriranno nel browser 

Qui un esempio di un link che punta al 'www.google.it/books' :<br>

<img src="imagesReadMe/pippo_books.google.it.png" style="width:300px; height:500px;">

# Lista libri (delle librerie selezionate)...
## menù operazioni

<img src="imagesReadMe/menu_libri.png" style="width:300px; height:500px;">

### Filtro veloce

<img src="imagesReadMe/filtro_attivo.png" style="width:300px; height:500px;">

## Spostamento libri da una libreria ad un'altra

<img src="imagesReadMe/spostamento_libro_in_librerie.png" style="width:300px; height:500px;">

### Ricerca 

<img src="imagesReadMe/ricerca_libri.png" style="width:300px; height:500px;">

Es. di libri estratti, dove con il "reset" si resetta il filtro di ricerca 

<img src="imagesReadMe/lista_libri_ricerca_attiva.png" style="width:300px; height:500px;">

### Ordinamento
Tramite spunta vengono decisi i campi da ordinare, mentre l'ordinamento vero e proprio avviene tramite spostamento in alto o in basso delle voci stesse. 

<img src="imagesReadMe/ordinamento.png" style="width:300px; height:500px;">

### Raggruppamento

<img src="imagesReadMe/raggruppamento.png" style="width:300px; height:500px;">

Esempio di lista libri raggruppata Autore e Titolo

<img src="imagesReadMe/raggruppamento_autore_titolo_attivo.png" style="width:300px; height:500px;">


# Backup ed estrazione dati
### Excel con N pagine, tante le librerie coinvolte.<br>

<img src="imagesReadMe/es_excel.png" style="width:800px; height:400px;">

E JSON file per il backup/restore dei soli libri presenti nella singola libreria

<img src="imagesReadMe/es_file_backup.png" style="width:300px; height:500px;">

## Struttura cartelle
Tutti i file prodotti dall'app (json, immagini, excel, ...), sono salvati in cartelle specifiche.<br>
Questo agevolare il caso in cui si voglia portare tutto sul PC ed usare la stessa app versione Desktop

<img src="imagesReadMe/struttura_cartelle.png" style="width:400px; height:500px;">
