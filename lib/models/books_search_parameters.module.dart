class BooksSearchParameters {
    String? txtTitolo;
    String? txtAutore;
    String? txtEditore;
    String? txtCategoria;
    String? txtAnnoPubblicazioneDa;
    String? txtAnnoPubblicazioneA;
    String? txtPrezzoMin;
    String? txtPrezzoMax;
    String? txtDescrizione;

    BooksSearchParameters({this.txtTitolo, this.txtAutore, this.txtEditore, this.txtCategoria, this.txtAnnoPubblicazioneDa, this.txtAnnoPubblicazioneA, 
        this.txtPrezzoMin, this.txtPrezzoMax, this.txtDescrizione});

    bool isEmpty() {
      return (txtTitolo == null || txtTitolo!.trim().isEmpty)
          && (txtAutore == null || txtAutore!.trim().isEmpty)
          && (txtEditore == null || txtEditore!.trim().isEmpty)
          && (txtCategoria == null || txtCategoria!.trim().isEmpty)
          && (txtAnnoPubblicazioneDa == null || txtAnnoPubblicazioneDa!.trim().isEmpty)
          && (txtAnnoPubblicazioneA == null || txtAnnoPubblicazioneA!.trim().isEmpty)
          && (txtPrezzoMin == null || txtPrezzoMin!.trim().isEmpty)
          && (txtPrezzoMax == null || txtPrezzoMax!.trim().isEmpty)
          && (txtDescrizione == null || txtDescrizione!.trim().isEmpty);
    }

    bool isNotEmpty() {
      return !isEmpty();
    }
}