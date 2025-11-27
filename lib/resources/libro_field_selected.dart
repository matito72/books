class LibroFieldSelected { 
  String label;
  bool isSelected;

  LibroFieldSelected(this.label, {this.isSelected = true} );

  /// ** DEFAULT
  ///  
  factory LibroFieldSelected.titolo() => LibroFieldSelected('Titolo', isSelected: false);
  factory LibroFieldSelected.autore() => LibroFieldSelected('Autore', isSelected: false);
  factory LibroFieldSelected.editore() => LibroFieldSelected('Editore', isSelected: false);
  factory LibroFieldSelected.categoria() => LibroFieldSelected('Categoria', isSelected: false);
  factory LibroFieldSelected.dtPubblicazione() => LibroFieldSelected('Data Pubblicazione', isSelected: false);
  factory LibroFieldSelected.isbn() => LibroFieldSelected('ISBN', isSelected: false);
  factory LibroFieldSelected.nrPagine() => LibroFieldSelected('Nr. Pagine', isSelected: false);
  factory LibroFieldSelected.prezzo() => LibroFieldSelected('Prezzo', isSelected: false);
  factory LibroFieldSelected.dtInserimento() => LibroFieldSelected('Dt. Inserimento', isSelected: false);
  factory LibroFieldSelected.dtUltimaModifica() => LibroFieldSelected('Dt. Modifica');
  factory LibroFieldSelected.libreria() => LibroFieldSelected('Libreria', isSelected: false);

  static List<LibroFieldSelected> values() {
    return [
      LibroFieldSelected.dtUltimaModifica(),
      LibroFieldSelected.dtInserimento(),
      LibroFieldSelected.titolo(),
      LibroFieldSelected.autore(),
      LibroFieldSelected.editore(),
      LibroFieldSelected.categoria(),
      LibroFieldSelected.dtPubblicazione(),
      LibroFieldSelected.prezzo(),
      LibroFieldSelected.libreria()
    ];
  } 

  factory LibroFieldSelected.byName(String name) {
    LibroFieldSelected ret = LibroFieldSelected.titolo();

    for (LibroFieldSelected ordinamentoLibri in values()) {
      if (name == ordinamentoLibri.label) {
        ret = ordinamentoLibri;
        break;
      }
    }
    
    return ret;
  }
}
