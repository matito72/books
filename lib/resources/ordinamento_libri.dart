class OrdinamentoLibri { 
  String label;
  bool isSelected;

  OrdinamentoLibri(this.label, {this.isSelected = true} );

  factory OrdinamentoLibri.titolo() => OrdinamentoLibri('Titolo');
  factory OrdinamentoLibri.autore() => OrdinamentoLibri('Autore');
  factory OrdinamentoLibri.editore() => OrdinamentoLibri('Editore', isSelected: false);
  factory OrdinamentoLibri.dtPubblicazione() => OrdinamentoLibri('Data Pubblicazione', isSelected: false);
  factory OrdinamentoLibri.prezzo() => OrdinamentoLibri('Prezzo', isSelected: false);

  static List<OrdinamentoLibri> values() {
    return [
      OrdinamentoLibri.titolo(),
      OrdinamentoLibri.autore(),
      OrdinamentoLibri.editore(),
      OrdinamentoLibri.dtPubblicazione(),
      OrdinamentoLibri.prezzo(),
    ];
  } 

  factory OrdinamentoLibri.byName(String name) {
    OrdinamentoLibri ret = OrdinamentoLibri.titolo();

    for (OrdinamentoLibri ordinamentoLibri in values()) {
      if (name == ordinamentoLibri.label) {
        ret = ordinamentoLibri;
        break;
      }
    }
    
    return ret;
  }
}
