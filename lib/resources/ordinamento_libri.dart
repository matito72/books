enum OrdinamentoLibri { 
  titolo("Titolo"), 
  autore("Autore"),
  editore("Editore"), 
  dtPubblicazione("Data Pubblicazione"), 
  prezzo("Prezzo")
  ;

  final String label;
  const OrdinamentoLibri(this.label);
}