import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/resources/bisac_codes.dart';
import 'package:books/utilities/utils.dart';

class FiltroUtil {
  LibroViewModel libroViewModel;
  LibreriaModel libreriaSel;

  FiltroUtil(this.libroViewModel, this.libreriaSel);

  bool filtroAvanzato() {
    bool filtro = true;
    bool filtroTitolo = true;
    bool filtroAutore = true;
    bool filtroEditore = true;
    bool filtroCategoria = true;
    bool filtroPrezzo = true;
    bool filtroDescrizione = true;

    if (ComArea.booksSearchParameters.isNotEmpty()) {
      filtroTitolo = _filtroTitolo(ComArea.booksSearchParameters.txtTitolo);
      filtroAutore = _filtroAutore(ComArea.booksSearchParameters.txtAutore);
      filtroEditore = _filtroEditore(ComArea.booksSearchParameters.txtEditore);
      filtroCategoria = _filtroCategoria(ComArea.booksSearchParameters.txtCategoria, true);
      filtroDescrizione = _filtroEditore(ComArea.booksSearchParameters.txtDescrizione);

      double przMin = Utils.getPositiveDouble(getTrimUppercaseParameter(ComArea.booksSearchParameters.txtPrezzoMin));
      double przMax = Utils.getPositiveDouble(getTrimUppercaseParameter(ComArea.booksSearchParameters.txtPrezzoMax));
      filtroPrezzo = (przMin < 0 && przMax < 0) || _filtroPrezzo(przMin, przMax);

      filtro = (
           filtroTitolo
        && filtroAutore
        && filtroEditore
        && filtroCategoria
        && filtroPrezzo
        && filtroDescrizione
      );
    }
      
    return (libroViewModel.siglaLibreria == libreriaSel.sigla) && filtro;
  }

  bool filtroSemplice() {
    bool filtro = true;
    bool filtroTitolo = true;
    bool filtroAutore = true;
    bool filtroEditore = true;
    bool filtroCategoria = true;
    bool filtroPrezzo = true;
    bool filtroDescrizione = true;

    if (ComArea.bookToSearch.isNotEmpty) {
      filtroTitolo = _filtroTitolo(ComArea.bookToSearch);
      filtroAutore = _filtroAutore(ComArea.bookToSearch);
      filtroEditore = _filtroEditore(ComArea.bookToSearch);
      filtroCategoria = _filtroCategoria(ComArea.bookToSearch, false);
      filtroDescrizione = _filtroDescrizione(ComArea.bookToSearch);

      double przMin = Utils.getPositiveDouble(getTrimUppercaseParameter(ComArea.bookToSearch));
      double przMax = Utils.getPositiveDouble(getTrimUppercaseParameter(ComArea.bookToSearch));
      filtroPrezzo = (przMin >= 0 && przMax >= 0) && _filtroPrezzo(przMin, przMax);

      filtro = (
           filtroTitolo
        || filtroAutore
        || filtroCategoria
        || filtroEditore
        || filtroPrezzo
        || filtroDescrizione
      );
    }
      
    return (libroViewModel.siglaLibreria == libreriaSel.sigla) && filtro;
  }

  bool _filtroTitolo(String? str) {
    return libroViewModel.titolo.trim().toUpperCase().contains(getTrimUppercaseParameter(str));
  }

  bool _filtroAutore(String? str) {
    bool filtroAutore = true;

    str = getTrimUppercaseParameter(str);
    filtroAutore = libroViewModel.lstAutori.toString().toUpperCase().contains(str);
    if (!filtroAutore && str.contains(' ')) {
      List<String> lstNomeCognome = str.split(' ');
      filtroAutore = libroViewModel.lstAutori.toString().toUpperCase().contains('${lstNomeCognome[0]} ${lstNomeCognome[1]}')
        || libroViewModel.lstAutori.toString().toUpperCase().contains('${lstNomeCognome[1]} ${lstNomeCognome[0]}');
    }

    return filtroAutore; 
  }

  bool _filtroEditore(String? str) {
    return libroViewModel.editore.trim().toUpperCase().contains(getTrimUppercaseParameter(str)); 
  }

  bool _filtroCategoria(String? str, bool isFiltroEqual) {
    String strCategoria = getTrimUppercaseParameter(str);
    return (strCategoria == BisacList.nonClassifiable) 
        || (isFiltroEqual && libroViewModel.lstCategoria[0].trim().toUpperCase() == strCategoria)
        || (!isFiltroEqual && libroViewModel.lstCategoria[0].trim().toUpperCase().contains(strCategoria)); 
  }

  bool _filtroDescrizione(String? str) {
    return libroViewModel.descrizione.trim().toUpperCase().contains(getTrimUppercaseParameter(str)); 
  }

  bool _filtroPrezzo(double przMin, double przMax) {
    double prezzoLibro = Utils.getPositiveDouble(getTrimUppercaseParameter(libroViewModel.prezzo));

    return (przMin < 0 && przMax < 0) 
      || ((prezzoLibro >= 0) 
        && ( (przMin >= 0 && przMax < 0 && przMin <= prezzoLibro)
          || (przMin < 0 && przMax >= 0 && przMax >= prezzoLibro)
          || (przMin >= 0 && przMax >= 0 && przMin <= prezzoLibro && prezzoLibro <= przMax))
      );
  }

  String getTrimUppercaseParameter(String? str) {
    return (str ?? '').trim().toUpperCase();
  }
}