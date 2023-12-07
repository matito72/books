import 'package:books/features/libro/data/repository/db_libro_service.dart';
import 'package:books/injection_container.dart';
import 'package:books/pages/immagine_copertina.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/dettaglio_libro/five_stars.dart';
import 'package:flutter/material.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:intl/intl.dart';
import 'package:read_more_text/read_more_text.dart';


class DettaglioLibroWidget extends StatefulWidget {
  final LibroViewModel libroViewModel;
  final bool isNewDettaglio;
  
  const DettaglioLibroWidget(this.libroViewModel, this.isNewDettaglio, {Key? key}) : super(key: key);


  @override
  State<DettaglioLibroWidget> createState() => _DettaglioLibroWidget();
}

class _DettaglioLibroWidget extends State<DettaglioLibroWidget> {

  void goToImageview(context, LibroViewModel libroViewModel) async {
    String? immagineCopertinaPre = libroViewModel.immagineCopertina;

    await Navigator.pushNamed(context, ImmagineCopertina.pagePath, arguments: {
      // 'libroViewModel': LibroUtils.createLibroViewFromSearchModel(Constant.libreriaInUso!, libroViewModel),
      'libroViewModel': libroViewModel,
      'askBeforeDelete': true
    });
    String? immagineCopertinaPost = libroViewModel.immagineCopertina;

    if (immagineCopertinaPre != immagineCopertinaPost) {
      // UPDATE:
      final DbLibroService dbLibroService = sl<DbLibroService>();
      await dbLibroService.saveLibroToDb(libroViewModel, false);

      setState(() {
        widget.libroViewModel.immagineCopertina = immagineCopertinaPost;
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
              initialDate: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: ListView(
        children: <Widget> [
          Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 125,
                        height: 200,
                        child: FutureBuilder<Widget>(
                          future: getImageNetwork(context, widget.libroViewModel),
                          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return snapshot.data as Widget;
                            }
                          }
                        )
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              splashColor: Colors.red,
                              onDoubleTap: () async {
                                String? strDesc = await DialogUtils.getDescrizione(context, 'Titolo:', widget.libroViewModel.titolo, maxLines: 3);
                                if (strDesc != null) {
                                  setState(() {
                                    widget.libroViewModel.titolo = strDesc;
                                  });
                                }
                              },
                              child: ReadMoreText.selectable(
                                widget.libroViewModel.titolo,
                                numLines: 4,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                                // readMoreTextStyle: TextStyle(Colors.amber.shade200),
                                readMoreTextStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.amber.shade200),
                                // trimMode: TrimMode.Line,
                                readMoreText: '', // '...espandi',
                                readLessText: '', //' comprimi',
                              )
                            ),
                            // const SizedBox(
                            //   height: 1,
                            // ),
                            InkWell(
                              splashColor: Colors.red,
                              onDoubleTap: () async {
                                String? strDesc = await DialogUtils.getDescrizione(context, 'Autore:', widget.libroViewModel.lstAutori[0], maxLines: 3);
                                if (strDesc != null) {
                                  setState(() {
                                    widget.libroViewModel.lstAutori.clear();
                                    widget.libroViewModel.lstAutori.add(strDesc);
                                    // widget.libroViewModel.lstAutori[0] = strDesc;
                                  });
                                }
                              },
                              child: ReadMoreText.selectable(
                                widget.libroViewModel.lstAutori.join(', '),
                                numLines: 2,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white70
                                ),
                                readMoreTextStyle: TextStyle(color: Colors.amber.shade200),
                                readMoreText: '', 
                                readLessText: '',
                              ),
                            ),
                              const SizedBox(
                                height: 1,
                              ),
                              InkWell(
                                splashColor: Colors.red,
                                onDoubleTap: () async {
                                  String? strDesc = await DialogUtils.getDescrizione(context, 'Editore:', widget.libroViewModel.editore, maxLines: 2);
                                  if (strDesc != null) {
                                    setState(() {
                                      widget.libroViewModel.editore = strDesc;
                                    });
                                  }
                                },
                                child: ReadMoreText.selectable(
                                  widget.libroViewModel.editore,
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
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FiveStars(
                          value: widget.libroViewModel.stars,
                          onPressed: (value) {
                            setState(() {
                              widget.libroViewModel.stars = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    LibroUtils.getDataFormattata(widget.libroViewModel.dataPubblicazione),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.red,
                                    onDoubleTap: () {
                                      getYear(context, widget.libroViewModel);
                                    },
                                    child: Text(
                                      'Data',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightBlue.shade100,
                                      ), 
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.libroViewModel.nrPagine.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.red,
                                    onDoubleTap: () async {
                                      String? strNr = await DialogUtils.getNumero(context, 'Inserisci il numero pagine', widget.libroViewModel.nrPagine.toString(), true);
                                      if (strNr != null) {
                                        setState(() {                                                
                                          int? nr = int.tryParse(strNr);
                                          widget.libroViewModel.nrPagine = (nr != null) ? nr : 0;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Pagine',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightBlue.shade100,
                                      ),                                          
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.libroViewModel.prezzo.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.red,
                                    onDoubleTap: () async {
                                      String? strNr = await DialogUtils.getNumero(context, 'Inserisci il prezzo', widget.libroViewModel.prezzo.toString(), false);
                                      if (strNr != null) {
                                        setState(() {                                                
                                          double? nr = double.tryParse(strNr);
                                          widget.libroViewModel.prezzo = (nr != null) ? nr.toString() : '';
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Prezzo',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightBlue.shade100,
                                      ),                                          
                                    ),
                                  ),
                                ],
                              ),
                            ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 8,),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                ),
                Text("ISBN: ", 
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.lightBlue.shade100),
                ),
                SelectableText(
                  widget.libroViewModel.isbn
                )
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text('Descrizione', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.lightBlue.shade100),),
                            InkWell(
                              splashColor: Colors.red,
                              onDoubleTap: () async {
                                String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione);
                                if (strDesc != null) {
                                  setState(() {
                                    widget.libroViewModel.descrizione = strDesc;
                                  });
                                }
                              },
                              child: Text(
                                'Descrizione',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.lightBlue.shade100,
                                ),                                          
                              ),
                            ),
                            ReadMoreText.selectable(
                              widget.libroViewModel.descrizione,
                              numLines: 10,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              readMoreTextStyle: TextStyle(color: Colors.blue.shade200,),
                              // trimMode: TrimMode.Line,
                              readMoreText: '', // '...espandi',
                              readLessText: '', //' comprimi',
                              cursorColor: Colors.blue.shade200,
                              cursorRadius: const Radius.circular(1),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        ]
      ),
    );
  }
  
  Future<InkWell> getImageNetwork(BuildContext context, LibroViewModel libroViewModel) async {
    if (widget.isNewDettaglio) {
      await Utils.integrazioneDatiIncompleti(libroViewModel);
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return InkWell(
      splashColor: Colors.red,
      onDoubleTap: () {
        goToImageview(context, widget.libroViewModel);
      },
      child: (widget.libroViewModel.immagineCopertina != '')
        ? await Utils.getImageFromUrlFile(widget.libroViewModel)
        : Image.asset('assets/images/waiting.png', fit: BoxFit.cover,),
    );
  }

}
