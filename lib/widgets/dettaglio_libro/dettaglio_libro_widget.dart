import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/services/db_libro.service.dart';
import 'package:books/injection_container.dart';
import 'package:books/pages/immagine_copertina.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/bisac_dropdown_menu.dart';
import 'package:books/widgets/dettaglio_libro/five_stars.dart';
import 'package:flutter/material.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:intl/intl.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:expandable_text/expandable_text.dart';


class DettaglioLibroWidget extends StatefulWidget {
  final LibroViewModel _libroViewModel;
  final bool _isNewDettaglio;
  
  const DettaglioLibroWidget(this._libroViewModel, this._isNewDettaglio, {super.key});

  @override
  State<DettaglioLibroWidget> createState() => _DettaglioLibroWidget();
}

class _DettaglioLibroWidget extends State<DettaglioLibroWidget> {
  final DbLibroService dbLibroService = sl<DbLibroService>();

  void goToImageview(context, LibroViewModel libroViewModel) async {
    String? immagineCopertinaPre = libroViewModel.immagineCopertina;

    await Navigator.pushNamed(context, ImmagineCopertina.pagePath, arguments: {
      'libroViewModel': libroViewModel,
      'askBeforeDelete': true
    });
    String? immagineCopertinaPost = libroViewModel.immagineCopertina;

    if (!widget._isNewDettaglio && (immagineCopertinaPre != immagineCopertinaPost)) {
      // UPDATE:
      // await dbLibroService.saveLibroToDb(libroViewModel, false);

      setState(() {
        widget._libroViewModel.immagineCopertina = immagineCopertinaPost;
      });
    }
  }

  void getYear(context, LibroViewModel libroViewModel) async {
    DateTime selectedDate = DateTime.now();
    if (libroViewModel.dataPubblicazione.length == 4) {
      selectedDate = DateFormat("yyyy").parse(libroViewModel.dataPubblicazione);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Anno di pubblicazione:"),
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.blue.shade200
          ),
          contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            backgroundColor: Colors.blueAccent,
          ),
          shadowColor: Colors.blueAccent,
          content: SizedBox( 
            width: 300,
            height: 250,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              // initialDate: DateTime.now(),
              selectedDate: selectedDate,
              onChanged: (DateTime dateTime) {
                setState(() {
                  libroViewModel.dataPubblicazione = dateTime.year.toString();
                });
                // submit();
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')
            ),
          ],
        );
      },
    );
  }

  Widget headerBook() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width * 35 / 100),
          height: (MediaQuery.of(context).size.height * 25 / 100),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder<Widget>(
              future: getImageNetwork(context, widget._libroViewModel),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return snapshot.data as Widget;
                }
              }
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width * 62 / 100),
              height: (MediaQuery.of(context).size.height * 20 / 100),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onDoubleTap: () async {
                                String? strDesc = await DialogUtils.getDescrizione(context, 'Titolo:', widget._libroViewModel.titolo, maxLines: 3);
                                if (strDesc != null) {
                                  setState(() {
                                    widget._libroViewModel.titolo = strDesc;
                                  });
                                }
                              },
                              child: ExpandableText(
                                widget._libroViewModel.titolo,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                                expandText: '',
                                collapseText: '<<',
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            child: InkWell(
                              splashColor: Colors.red,
                              onDoubleTap: () async {
                                String? strDesc = await DialogUtils.getDescrizione(context, 'Autore:', widget._libroViewModel.lstAutori[0], maxLines: 3);
                                if (strDesc != null) {
                                  setState(() {
                                    widget._libroViewModel.lstAutori = [];
                                    widget._libroViewModel.lstAutori.add(strDesc);
                                  });
                                }
                              },
                              child: ExpandableText(
                                widget._libroViewModel.lstAutori.join(', '),
                                maxLines: 2,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white70
                                ),
                                expandText: '',
                                collapseText: '<<',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            child: InkWell(
                              splashColor: Colors.red,
                              onDoubleTap: () async {
                                String? strDesc = await DialogUtils.getDescrizione(context, 'Editore:', widget._libroViewModel.editore, maxLines: 2);
                                if (strDesc != null) {
                                  setState(() {
                                    widget._libroViewModel.editore = strDesc;
                                  });
                                }
                              },
                              child: ReadMoreText.selectable(
                                widget._libroViewModel.editore,
                                numLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                readMoreTextStyle: TextStyle(color: Colors.amber.shade200),
                                readMoreText: '', 
                                readLessText: '', 
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: FiveStars(
                    value: widget._libroViewModel.stars,
                    onPressed: (value) {
                      setState(() {
                        widget._libroViewModel.stars = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget dataHeaderBook() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SelectableText(
                  widget._libroViewModel.isbn,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'ISBN',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.lightBlue.shade100,
                  ),                                          
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  LibroUtils.getDataFormattata(widget._libroViewModel.dataPubblicazione),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  splashColor: Colors.red,
                  onDoubleTap: () {
                    getYear(context, widget._libroViewModel);
                  },
                  child: Text(
                    'Data',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.lightBlue.shade100,
                      decoration: TextDecoration.underline,
                    ), 
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget._libroViewModel.nrPagine.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  splashColor: Colors.red,
                  onDoubleTap: () async {
                    String? strNr = await DialogUtils.getNumero(context, 'Inserisci il numero pagine', widget._libroViewModel.nrPagine.toString(), true);
                    if (strNr != null) {
                      setState(() {                                                
                        int? nr = int.tryParse(strNr);
                        widget._libroViewModel.nrPagine = (nr != null) ? nr : 0;
                      });
                    }
                  },
                  child: Text(
                    'Pagine',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.lightBlue.shade100,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget._libroViewModel.prezzo.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  splashColor: Colors.red,
                  onDoubleTap: () async {
                    String? strNr = await DialogUtils.getNumero(context, 'Inserisci il prezzo', widget._libroViewModel.prezzo.toString(), false);
                    if (strNr != null) {
                      setState(() {                                                
                        double? nr = double.tryParse(strNr);
                        widget._libroViewModel.prezzo = (nr != null) ? nr.toString() : '';
                      });
                    }
                  },
                  child: Text(
                    'Prezzo',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.lightBlue.shade100,
                      decoration: TextDecoration.underline,
                    ),                                          
                  ),
                ),
              ],
            ),
          ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            headerBook(),
            dataHeaderBook(),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height * 50 / 100),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categoria',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue.shade100,
                          ),                                          
                        ),
                        BisacDropdownMenu(
                          widget._libroViewModel.lstCategoria[0].toUpperCase(),
                          onPressed: (value) {
                            setState(() {
                              widget._libroViewModel.lstCategoria = [value];
                              // ComArea.itemComparatorField = OrdinamentoLibri.byName(value);
                              // widget._libroBloc.add(LoadLibroEvent(ComArea.libreriaInUso!));
                            });
                          },
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.red,
                          onDoubleTap: () async {
                            String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget._libroViewModel.descrizione);
                            if (strDesc != null) {
                              setState(() {
                                widget._libroViewModel.descrizione = strDesc;
                              });
                            }
                          },
                          child: Text(
                            'Descrizione',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.lightBlue.shade100,
                              decoration: TextDecoration.underline,
                            ),                                          
                          ),
                        ),
                        ExpandableText(
                          widget._libroViewModel.descrizione,
                          maxLines: 10,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          expandText: '',
                          collapseText: '<<',
                        )
                        // ReadMoreText.selectable(
                        //   widget._libroViewModel.descrizione,
                        //   numLines: 10,
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.white,
                        //   ),
                        //   readMoreTextStyle: TextStyle(color: Colors.blue.shade200,),
                        //   readMoreIcon: Icon(Icons.more_horiz, color: Colors.blue.shade200),
                        //   readLessIcon: Icon(Icons.keyboard_arrow_up, color: Colors.blue.shade200),
                        //   readMoreText: '',
                        //   readLessText: '',
                        //   cursorColor: Colors.blue.shade200,
                        //   cursorRadius: const Radius.circular(1),
                        //   readMoreAlign: AlignmentDirectional.topEnd,
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          ),
      ),
    );
  }
  
  Future<InkWell> getImageNetwork(BuildContext context, LibroViewModel libroViewModel) async {
    if (widget._isNewDettaglio) {
      await Utils.integrazioneDatiIncompleti(libroViewModel);
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return InkWell(
      splashColor: Colors.red,
      onDoubleTap: () {
        goToImageview(context, widget._libroViewModel);
      },
      child: (widget._libroViewModel.immagineCopertina != '')
        ? await Utils.getImageFromUrlFile(widget._libroViewModel)
        : Image.asset(Constant.assetImageDefault, fit: BoxFit.cover,),
    );
  }

}
