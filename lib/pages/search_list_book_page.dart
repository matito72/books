import 'package:books/features/libreria/data/models/libreria_model.dart';
import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_search_model.dart';
import 'package:books/models/parameter_google_search_model.dart';
import 'package:books/services/goole_apis_books_service.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/widgets/app_bar/app_bar_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


// class SearchListBookPage extends StatefulWidget {
//   static const String pagePath = '/HomeLibriLibreria/searchListBook';

//   final LibreriaModel libreriaSel;
//   final ParameterGoogleSearchModel googleSearchModel;
//   // final List<LibroSearchModel> libri;
//   // final num totalFindedBooks;
//   final String title;

//   const SearchListBookPage({
//     Key? key, required this.title, required this.libreriaSel, required this.googleSearchModel, /*required this.libri, required this.totalFindedBooks */
//   }) : super(key: key);


//   @override
//   State<SearchListBookPage> createState() => _SearchListBookPage();
// }

// class _SearchListBookPage extends State<SearchListBookPage> {

class SearchListBookPage extends StatelessWidget {
  static const String pagePath = '/HomeLibriLibreria/searchListBook';

  final LibreriaModel libreriaSel;
  final ParameterGoogleSearchModel googleSearchModel;
  final String title;

  const SearchListBookPage({
    Key? key, required this.title, required this.libreriaSel, required this.googleSearchModel, /*required this.libri, required this.totalFindedBooks */
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBarDefault(
          context: context,
          txtLabel: 'Ricerca : $title'
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 5),
          child: PagewiseListViewExample(googleSearchModel, libreriaSel, title: title)
        )
      )
    );
  }
}

class PagewiseListViewExample extends StatelessWidget  {
  static const String pagePath = 'searchListBook'; 
  
  final String title;
  final ParameterGoogleSearchModel googleSearchModel;
  final LibreriaModel libreriaSel;

  const PagewiseListViewExample(this.googleSearchModel, this.libreriaSel, {Key? key, required this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return PagewiseListView<LibroSearchModel>(
        pageSize: 10,
        itemBuilder: _itemBuilder,
        pageFuture: (pageIndex) => GooleApisBooksService.getLibri(googleSearchModel, pageIndex! * 10, 10),
        loadingBuilder: (context) {
          return const Text('Loading...');
        },
        noItemsFoundBuilder: (context) {
          return const Text('Nessun libro trovato');
        },
    );
  }

  Widget _itemBuilder(context, LibroSearchModel entry, index) {

    viewDettaglioLibro() async {
      LibroDettaglioResult? ret = await LibroUtils.viewDettaglioLibro(context, libreriaSel, entry, false);

      if (ret != null) {
        Navigator.pop(context, ret);
      }
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Dismissible(
                key: Key(entry.googleBookId),
                // key: UniqueKey(),
                onDismissed: (direction) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rimosso:\n\t${entry.titolo}\n\t${entry.lstAutori.join(", ")}\n\t[${entry.editore}]')));
                },
                confirmDismiss: (DismissDirection dismissDirection) async {
                  switch (dismissDirection) {
                    case DismissDirection.endToStart:
                      viewDettaglioLibro();
                      // LibroViewModel? libroDettaglioResult = await LibroUtils.viewDettaglioLibroFromSearch(context, libreriaSel, entry, false);
                      // // execActionOnLibroDettaglioResult(libroDettaglioResult, entry);
                      // if (libroDettaglioResult != null) {
                      //   print(libroDettaglioResult.titolo);
                      // }
                      return false;
                    case DismissDirection.startToEnd:
                      // bool isRemoveBook = await LibroUtils.showConfirmationDialog(context, 'rimuovere', entry, false) == true;
                      bool? isRemoveBook = await DialogUtils.showConfirmationSiNo(context, 'Vuoi rimuovere questo libro dalla lista ?');
                      if (isRemoveBook == null || isRemoveBook) {
                        return true;
                      } 
                      return false;
                    case DismissDirection.horizontal:
                      break;
                    case DismissDirection.vertical:
                      break;
                    case DismissDirection.up:
                      break;
                    case DismissDirection.down:
                      assert(false);
                      break;
                    case DismissDirection.none:
                      break;
                  }
                  return false;
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(MdiIcons.deleteForever)),
                        TextSpan(text: ' Elimina'),
                      ],
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  color: Colors.green,
                  alignment: Alignment.centerRight,
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Dettaglio '),
                        WidgetSpan(child: Icon(MdiIcons.book)),
                      ],
                    ),
                  ),
                ),
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: ListTile(
                    onTap: () async {
                      viewDettaglioLibro();
                      // Valore restituito via POP al widget padre
                      // LibroDettaglioResult? libroDettaglioResult = await LibroUtils.viewDettaglioLibroFromSearch(context, dbLibreriaService.libreriaInUso, entry, false);
                      // execActionOnLibroDettaglioResult(libroDettaglioResult, entry);
                    },
                    leading: (entry.immagineCopertina != '')
                        ? Image.network(entry.immagineCopertina, height: 200, width: 40, fit: BoxFit.cover)
                        : const Text(''),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: Text(
                            entry.titolo,
                            overflow: TextOverflow.fade,
                            style: entry.titolo.length <= 50 
                              ? Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white) 
                              : entry.titolo.length <= 100
                                ? Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)
                                : Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                            //'${index+1}/${nrTot}',
                            '${index+1}',
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.right,
                        )
                      ]
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            // entry.lstAutori.join(', '),
                            LibroUtils.getStrLstAutoriRidotta(entry, 250),
                            overflow: TextOverflow.fade,
                            style: entry.lstAutori.join(', ').length <= 90
                              ? Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontStyle: FontStyle.italic, 
                                color: Colors.white70
                              )
                              : Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontStyle: FontStyle.italic, 
                                color: Colors.white70
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]
        ),
        // const Divider(
        //   endIndent: 0,
        //   height: 5,
        //   thickness: 0,
        //   color: Color.fromARGB(255, 62, 63, 112),
        // )
        const Padding(
          padding: EdgeInsets.only(top: 5),
        )
      ],
    );
  }
}
