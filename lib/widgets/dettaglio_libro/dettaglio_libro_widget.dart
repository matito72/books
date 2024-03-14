import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_isar.module.util.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/models/widget_desc.module.dart';
import 'package:books/pages/immagine_copertina.dart';
import 'package:books/resources/libro_field_selected.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/bisac_dropdown_menu.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/descrizione_field.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/field_dett_libro.dart';
import 'package:books/widgets/dettaglio_libro/five_stars.dart';
import 'package:books/widgets/libreria_sel_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DettaglioLibroWidget extends StatefulWidget {
  final LibroIsarModel libroViewModel;
  final bool _isNewDettaglio;
  final bool isInsertByUserInterface;
  final List<LinkIsarModule> lstLinkIsarModule;
  
  const DettaglioLibroWidget(
    this.libroViewModel, 
    this._isNewDettaglio, 
    this.lstLinkIsarModule,
    {super.key, this.isInsertByUserInterface = false}
  );

  @override
  State<DettaglioLibroWidget> createState() => _DettaglioLibroWidget();
}

class _DettaglioLibroWidget extends State<DettaglioLibroWidget> {

  void _goToImageview(BuildContext context, LibroIsarModel libroViewModel) async {
    String? immagineCopertinaPre = libroViewModel.immagineCopertina;

    await Navigator.pushNamed(context, ImmagineCopertina.pagePath, arguments: {
      'libroViewModel': libroViewModel,
      'askBeforeDelete': true
    });
    String? immagineCopertinaPost = libroViewModel.immagineCopertina;

    // if (!widget._isNewDettaglio && (immagineCopertinaPre != immagineCopertinaPost)) {
    if (immagineCopertinaPre != immagineCopertinaPost) {
      setState(() {
        widget.libroViewModel.immagineCopertina = immagineCopertinaPost;
      });
    }
  }

  void _getYear(BuildContext context, LibroIsarModel libroViewModel) async {
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
    FieldDettLibro fieldDettLibro = FieldDettLibro(context, widget.libroViewModel);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width * 35 / 100),
          height: (MediaQuery.of(context).size.height * 25 / 100),
          child: InkWell(
            splashColor: Colors.transparent,
            onDoubleTap: () {
              _goToImageview(context, widget.libroViewModel);
            },
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
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width * 62 / 100),
          height: (MediaQuery.of(context).size.height * 25 / 100),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        fieldDettLibro.getField(
                          Colors.limeAccent[100],
                          LibroFieldSelected.titolo().label, 5, true, 
                          fnString: (strDesc) => {
                            setState(() {
                              widget.libroViewModel.titolo = strDesc;
                            })
                          }
                        ),
                        fieldDettLibro.getField(
                          Colors.lightBlue[50],
                          LibroFieldSelected.autore().label, 2, true,
                          fnString: (strDesc) => {
                            setState(() {
                              widget.libroViewModel.lstAutori = [];
                              widget.libroViewModel.lstAutori.add(strDesc);
                            })
                          }
                        ),  
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerBook_1(BuildContext context) {
    FieldDettLibro fieldDettLibro = FieldDettLibro(context, widget.libroViewModel);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width * 35 / 100),
          // height: (MediaQuery.of(context).size.height * 25 / 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
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
              ),
            ],
          ),
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width * 62 / 100),
          // height: (MediaQuery.of(context).size.height * 25 / 100),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
                  child: fieldDettLibro.getField(
                    Colors.lime[100],
                    LibroFieldSelected.editore().label, 1, true,
                    fnString: (strDesc) => {
                      setState(() {
                        widget.libroViewModel.editore = strDesc;
                      })
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dataHeaderBook(BuildContext context) {
    FieldDettLibro fieldDettLibro = FieldDettLibro(context, widget.libroViewModel);

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          fieldDettLibro.getField(
            Colors.lime[100],
            LibroFieldSelected.isbn().label, 1, false,
            fnString: (strDesc) => {
              setState(() {
                widget.libroViewModel.isbn = strDesc;
              })
            }
          ),
          // getIsbnField(context, widget, (strDesc) => {
          //   if (strDesc.isNotEmpty) {
          //     widget.libroViewModel.isbn = strDesc
          //   },
          // }),
          fieldDettLibro.getField(
            Colors.lime[100],
            LibroFieldSelected.dtPubblicazione().label, 1, false,
            fn: () => {
              _getYear(context, widget.libroViewModel)
            }
          ),
          // getDtPubblicazioneField(context, widget, () => {
          //     _getYear(context, widget.libroViewModel)
          // }),
          fieldDettLibro.getField(
            Colors.lime[100],
            LibroFieldSelected.nrPagine().label, 1, false,
            fnString: (strNr) => {
              setState(() {
                int? nr = int.tryParse(strNr);
                widget.libroViewModel.nrPagine = (nr != null) ? nr : 0;
              })
            }
          ),
          // getNrPaginaField(context, widget, (strNr) => {
          //   setState(() {                                                
              // int? nr = int.tryParse(strNr);
              // widget.libroViewModel.nrPagine = (nr != null) ? nr : 0;
          //   })
          // }),
          fieldDettLibro.getField(
            Colors.lime[100],
            LibroFieldSelected.prezzo().label, 1, false,
            fnString: (strNr) => {
              setState(() {
                double? nr = double.tryParse(strNr);
                widget.libroViewModel.prezzo = (nr != null) ? nr : 0;
              })
            }
          ),
          // getPrezzoField(context, widget, (strNr) => {
          //   setState(() {                                                
              // double? nr = double.tryParse(strNr);
              // widget.libroViewModel.prezzo = (nr != null) ? nr.toString() : '';
          //   })
          // }),
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
            _headerBook_1(context),
            _dataHeaderBook(context),
            // const Padding(
            //   padding: EdgeInsets.only(top: 5),
            // ),
            SizedBox(
              height: (MediaQuery.of(context).size.height * 50 / 100),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Libreria',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.lightBlue.shade100,
                        fontWeight: FontWeight.bold
                      ), 
                    ),
                    LibreriaSelDropdown(
                      widget.libroViewModel.siglaLibreria != 0
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
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    getDescrizioneField(context, widget, (strDesc) => {
                      setState(() {
                        widget.libroViewModel.descrizione = strDesc;
                      })
                    }),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    // const Padding(padding: EdgeInsets.only(top: 15)),
                    getWidgetLink(
                      context, 'Google Book preview', '', widget.libroViewModel.previewLink, null, 
                      () => {
                        _fnDeleteLink(context, null)
                      },
                      null
                    ),
                    Column(
                      children: widget.lstLinkIsarModule.map((item) {
                          return getWidgetLink(context, null, null, null, item,
                            () => {
                              _fnDeleteLink(context, item)
                            },
                            () => {
                              _fnEditLink(context, item)
                            }
                          );
                        }).toList()
                    ),
                    Divider(
                      height: 5,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                      color: Colors.lime[100],
                    ),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue[400],
                        ),
                        onPressed: () async {
                          String? strDesc = await _addNewLink(context, widget.libroViewModel);
                          if (strDesc != null && strDesc.contains(';') && strDesc.split(';').length == 3) {
                            List<String> lstStr = strDesc.split(';');
                            setState(() {
                              widget.lstLinkIsarModule.add(LibroIsarModuleUtil.createLinkIsarModule(lstStr[0].trim(), lstStr[2].trim(), descrizione: lstStr[1].trim()));
                            });
                          }
                        },
                        child: const Text("Aggiungi un nuovo Link"),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15, bottom: 15)),
                  ],
                ),
              ),
            ),
          ],
          ),
      ),
    );
  }

  _fnDeleteLink(BuildContext context, LinkIsarModule? item) async {
    bool? isRemoveBook = await DialogUtils.showConfirmationSiNo(context, "Procedo all'eliminazione del link ?");
    if (isRemoveBook == true) {
      setState(() {
        if (item == null) {
          widget.libroViewModel.previewLink = '';
        } else {
          widget.lstLinkIsarModule.remove(item);
        }
      });
    }
  }

  _fnEditLink(BuildContext context, LinkIsarModule item) async {
    String? strDesc = await _editLink(context, item);
    if (strDesc != null && strDesc.contains(';') && strDesc.split(';').length == 3) {
      List<String> lstStr = strDesc.split(';');
      setState(() {
        item.name = lstStr[0].trim();
        item.descrizione = lstStr[1].trim();
        item.url = lstStr[2].trim();
      });
    }
  }

  Future<String?> _editLink(BuildContext context, LinkIsarModule item) async {
    List<WidgetDescModel> lstWidgetDescModel = [
      WidgetDescModel('Nome:', item.name, maxLines:1), 
      WidgetDescModel('Descrizione:', item.descrizione, maxLines:1),
      WidgetDescModel('URL:', item.url, maxLines:1),
    ];
    return await DialogUtils.getMultiDescrizione(context, lstWidgetDescModel);    
  }

  Future<String?> _addNewLink(BuildContext context, LibroIsarModel libro) async {
    List<WidgetDescModel> lstWidgetDescModel = [
      WidgetDescModel('Nome:', '', maxLines:1), 
      WidgetDescModel('Descrizione:', '', maxLines:1),
      WidgetDescModel('URL:', 'https://', maxLines:1),
    ];
    return await DialogUtils.getMultiDescrizione(context, lstWidgetDescModel);    
  }
  
  Future<Widget> _getImageNetwork(BuildContext context, LibroIsarModel libroViewModel) async {
    if (widget._isNewDettaglio && !widget.isInsertByUserInterface) {
      await Utils.integrazioneDatiIncompleti(libroViewModel);
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return (widget.libroViewModel.immagineCopertina != '')
      ? context.mounted ?  await Utils.getImageFromUrlFile(widget.libroViewModel) : const Text("")
      : getImmagineDaDefinire();
  }

  Widget getImmagineDaDefinire() {
    return Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width * 35 / 100),
          height: (MediaQuery.of(context).size.height * 25 / 100),
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
