import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/services/db_libro.service.dart';
import 'package:books/injection_container.dart';
import 'package:books/pages/immagine_copertina.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/bisac_dropdown_menu.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/descrizione_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/dt_pubblicazione_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/editore_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/isbn_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/lst_autori_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/num_pagine_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/prezzo_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/titolo_field.dart';
import 'package:books/widgets/dettaglio_libro/five_stars.dart';
import 'package:books/widgets/libreria_sel_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:intl/intl.dart';


class DettaglioLibroWidget extends StatefulWidget {
  final LibroViewModel libroViewModel;
  final bool _isNewDettaglio;
  
  const DettaglioLibroWidget(this.libroViewModel, this._isNewDettaglio, {super.key});

  @override
  State<DettaglioLibroWidget> createState() => _DettaglioLibroWidget();
}

class _DettaglioLibroWidget extends State<DettaglioLibroWidget> {
  final DbLibroService dbLibroService = sl<DbLibroService>();

  void _goToImageview(BuildContext context, LibroViewModel libroViewModel) async {
    String? immagineCopertinaPre = libroViewModel.immagineCopertina;

    await Navigator.pushNamed(context, ImmagineCopertina.pagePath, arguments: {
      'libroViewModel': libroViewModel,
      'askBeforeDelete': true
    });
    String? immagineCopertinaPost = libroViewModel.immagineCopertina;

    if (!widget._isNewDettaglio && (immagineCopertinaPre != immagineCopertinaPost)) {
      setState(() {
        widget.libroViewModel.immagineCopertina = immagineCopertinaPost;
      });
    }
  }

  void _getYear(BuildContext context, LibroViewModel libroViewModel) async {
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

  Widget _headerBook(BuildContext context) {
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
              future: _getImageNetwork(context, widget.libroViewModel),
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
                          getTitoloField(context, widget, (strDesc) => {
                            setState(() {
                              widget.libroViewModel.titolo = strDesc;
                            })
                          }),
                          getLstAutoriField(context, widget, (strDesc) => {
                            setState(() {
                              widget.libroViewModel.lstAutori = [];
                              widget.libroViewModel.lstAutori.add(strDesc);
                            })
                          }),
                          getEditoreField(context, widget, (strDesc) => {
                            setState(() {
                              widget.libroViewModel.editore = strDesc;
                            })
                          })
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
                    value: widget.libroViewModel.stars,
                    onPressed: (value) {
                      setState(() {
                        if (value == widget.libroViewModel.stars) {
                          widget.libroViewModel.stars = 0;
                        } else {
                          widget.libroViewModel.stars = value;
                        }
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

  Widget _dataHeaderBook(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          getIsbnField(context, widget, (strDesc) => {
            if (strDesc.isNotEmpty) {
              widget.libroViewModel.isbn = strDesc              
            },
          }),
            getDtPubblicazioneField(context, widget, () => {
               _getYear(context, widget.libroViewModel)
            }),
            getNrPaginaField(context, widget, (strNr) => {
              setState(() {                                                
                int? nr = int.tryParse(strNr);
                widget.libroViewModel.nrPagine = (nr != null) ? nr : 0;
              })
            }),
            getPrezzoField(context, widget, (strNr) => {
              setState(() {                                                
                double? nr = double.tryParse(strNr);
                widget.libroViewModel.prezzo = (nr != null) ? nr.toString() : '';
              })
            }),
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
            _headerBook(context),
            _dataHeaderBook(context),
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
                          'Libreria',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue.shade100,
                            fontWeight: FontWeight.bold
                          ),                                          
                        ),
                        LibreriaSelDropdown(
                          widget.libroViewModel.siglaLibreria.isNotEmpty
                            ? widget.libroViewModel.siglaLibreria
                            : ComArea.libreriaInUso!.sigla,
                          onPressed: (value) {
                            setState(() {
                              widget.libroViewModel.siglaLibreria = value;
                            });
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          'Categoria',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue.shade100,
                            fontWeight: FontWeight.bold
                          ),                                          
                        ),
                        BisacDropdownMenu(
                          widget.libroViewModel.lstCategoria[0].toUpperCase(),
                          onPressed: (value) {
                            setState(() {
                              widget.libroViewModel.lstCategoria = [value];
                            });
                          },
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    getDescrizioneField(context, widget, (strDesc) => {
                      setState(() {
                        widget.libroViewModel.descrizione = strDesc;
                      })
                    }),
                  ],
                ),
              ),
            ),
          ],
          ),
      ),
    );
  }
  
  Future<InkWell> _getImageNetwork(BuildContext context, LibroViewModel libroViewModel) async {
    if (widget._isNewDettaglio) {
      await Utils.integrazioneDatiIncompleti(libroViewModel);
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return InkWell(
      splashColor: Colors.red,
      onDoubleTap: () {
        _goToImageview(context, widget.libroViewModel);
      },
      child: (widget.libroViewModel.immagineCopertina != '')
        ? await Utils.getImageFromUrlFile(widget.libroViewModel)
        : getImmagineDaDefinire()
    );
  }

  Widget getImmagineDaDefinire() {
    return Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width * 85 / 100),
          height: (MediaQuery.of(context).size.height * 50 / 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: Theme.of(context).colorScheme.background)
            border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
            // border: Border.all(color: Colors.transparent)
          ),
          child: Image.asset(Constant.assetImageDefault, fit: BoxFit.cover,),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            iconSize: 25,
            padding: const EdgeInsets.all(0),
            icon: Icon(
              Icons.edit,
              color: Colors.yellowAccent[700]
            ),
            alignment: Alignment.topRight,
            onPressed: () async {
              _goToImageview(context, widget.libroViewModel);
            },
          ),
        )
      ],
    );
  }
}
