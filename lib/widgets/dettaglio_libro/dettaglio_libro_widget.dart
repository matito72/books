import 'package:book/config/com_area.dart';
import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/libro_isar.module.util.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/models/widget_desc.module.dart';
import 'package:book/pages/immagine_copertina.dart';
import 'package:book/resources/libro_field_selected.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/utilities/utils.dart';
import 'package:book/widgets/bisac_dropdown_menu.dart';
import 'package:book/widgets/dettaglio_libro/fields_libro/descrizione_field.dart';
import 'package:book/widgets/dettaglio_libro/fields_libro/field_dett_libro.dart';
import 'package:book/widgets/dettaglio_libro/five_stars.dart';
import 'package:book/widgets/libreria_sel_dropdown.dart';
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
          title: Text(
              "Anno di pubblicazione:",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.amber[200],
                fontWeight: FontWeight.bold,
                fontSize: 20
              )
          ),
          titleTextStyle:
            Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.limeAccent,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
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
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.amber[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _headerBook(BuildContext context) {
    FieldDettLibro fieldDettLibro = FieldDettLibro(context, widget.libroViewModel);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. L'IMMAGINE: Larghezza fissa o proporzionale, ma controllata
          SizedBox(
            width: ComArea.isMobileApp ? (MediaQuery.of(context).size.width * 0.34) : 150.0,
            // Rimuovi l'altezza fissa basata su MediaQuery se vuoi evitare distorsioni su desktop
            child: InkWell(
              onDoubleTap: () => _goToImageview(context, widget.libroViewModel),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FutureBuilder<Widget>(
                  future: _getImageNetwork(context, widget.libroViewModel),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    return snapshot.data!;
                  },
                ),
              ),
            ),
          ),

          const SizedBox(width: 10), // Un piccolo distanziatore

          // 2. IL TESTO: Usiamo Expanded per occupare TUTTO lo spazio rimanente senza sforare
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rimosso il Container trasparente inutile
                  fieldDettLibro.getField(
                      Colors.yellowAccent[200],
                      LibroFieldSelected.titolo().label, 5, true,
                      fnString: (strDesc) {
                        setState(() => widget.libroViewModel.titolo = strDesc);
                      }
                  ),
                  fieldDettLibro.getField(
                      Colors.lightBlue[50],
                      LibroFieldSelected.autore().label, 2, true,
                      fnString: (strDesc) {
                        setState(() {
                          widget.libroViewModel.lstAutori = [strDesc];
                        });
                      }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerBook_1(BuildContext context) {
    FieldDettLibro fieldDettLibro = FieldDettLibro(context, widget.libroViewModel);

    // Verifichiamo se siamo su mobile o desktop per decidere la larghezza della colonna stelle
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. COLONNA STARS: Usiamo una larghezza fissa o proporzionale più piccola
        SizedBox(
          // Su mobile 34% va bene, su desktop diamo un valore fisso (es. 150)
          width: !isDesktop ? (MediaQuery.of(context).size.width * 34 / 100) : 150.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: FiveStars(
              value: widget.libroViewModel.stars,
              onPressed: (value) {
                setState(() {
                  widget.libroViewModel.stars = (value == widget.libroViewModel.stars) ? 0 : value;
                });
              },
            ),
          ),
        ),

        // 2. COLONNA EDITORE: Usiamo Expanded!
        // Si adatterà automaticamente allo spazio rimanente, che sia mobile o desktop.
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                fieldDettLibro.getField(
                  Colors.lime[100],
                  LibroFieldSelected.editore().label, 1, true,
                  fnString: (strDesc) => setState(() {
                    widget.libroViewModel.editore = strDesc;
                  }),
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
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16.0, right: 0.0),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisSize: MainAxisSize.max,
      child: Wrap( // Sostituito Row con Wrap
        spacing: 15.0, // Spazio orizzontale tra i widget
        runSpacing: 10.0, // Spazio verticale se vanno a capo
        alignment: WrapAlignment.start,
        children: <Widget>[
          // Expanded(
          //   flex: 3,
          //   child: fieldDettLibro.getField(
          //       Colors.lime[100],
          //       LibroFieldSelected.isbn().label, 1, false,
          //       fnString: (strDesc) => {
          //         setState(() {
          //           widget.libroViewModel.isbn = strDesc;
          //         })
          //       }
          //   ),
          // ),
          SizedBox(
            width: 150, // Larghezza fissa o proporzionale
            child: fieldDettLibro.getField(
              Colors.lime[100],
              LibroFieldSelected.isbn().label, 1, false,
              fnString: (strDesc) => setState(() => widget.libroViewModel.isbn = strDesc),
            ),
          ),
          const SizedBox(width: 15.0),
          // Expanded(
          //   flex: 1,
          //   child: fieldDettLibro.getField(
          //       Colors.lime[100],
          //       LibroFieldSelected.dtPubblicazione().label, 1, false,
          //       fn: () => {
          //         _getYear(context, widget.libroViewModel)
          //       }
          //   ),
          // ),
          SizedBox(
            width: 100,
            child: fieldDettLibro.getField(
              Colors.lime[100],
              LibroFieldSelected.dtPubblicazione().label, 1, false,
              fn: () => _getYear(context, widget.libroViewModel),
            ),
          ),
          // Uso SizedBox per uno spazio fisso tra i campi
          const SizedBox(width: 15.0),
          // Expanded(
          //   flex: 2,
          //   child: fieldDettLibro.getField(
          //       Colors.lime[100],
          //       LibroFieldSelected.nrPagine().label, 1, false,
          //       fnString: (strNr) => {
          //         setState(() {
          //           int? nr = int.tryParse(strNr);
          //           widget.libroViewModel.nrPagine = (nr != null) ? nr : 0;
          //         })
          //       }
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: fieldDettLibro.getField(
          //       Colors.lime[100],
          //       LibroFieldSelected.prezzo().label, 1, false,
          //       fnString: (strNr) => {
          //         setState(() {
          //           double? nr = double.tryParse(strNr);
          //           widget.libroViewModel.prezzo = (nr != null) ? nr : 0;
          //         })
          //       }
          //   ),
          // ),
          SizedBox(
            width: 100,
            child: fieldDettLibro.getField(
              Colors.lime[100],
              LibroFieldSelected.nrPagine().label, 1, false,
              fnString: (strNr) {
                int? nr = int.tryParse(strNr);
                setState(() => widget.libroViewModel.nrPagine = nr ?? 0);
              },
            ),
          ),
          SizedBox(
            width: 100,
            child: fieldDettLibro.getField(
              Colors.lime[100],
              LibroFieldSelected.prezzo().label, 1, false,
              fnString: (strNr) {
                double? nr = double.tryParse(strNr);
                setState(() => widget.libroViewModel.prezzo = nr ?? 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 0,
              child: SingleChildScrollView(
                padding: EdgeInsetsGeometry.all(0),
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                            _headerBook(context),
                            // _headerBook_1(context),
                            // _dataHeaderBook(context),
                  ]
                )
              )
            ),
            Expanded(
              // height: (MediaQuery.of(context).size.height * 50 / 100),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _headerBook_1(context),
                    _dataHeaderBook(context),
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
                    getWidgetLink(
                        context, 'Book preview', '', widget.libroViewModel.previewLink, widget.libroViewModel.typeBookSearch, null,
                            () => {
                          _fnDeleteLink(context, null)
                        },
                        null
                    ),
                    Column(
                        children: widget.lstLinkIsarModule.map((item) {
                          return getWidgetLink(context, null, null, null, -1, item,
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
                      thickness: 0.7,
                      indent: 50,
                      endIndent: 50,
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
                              setLinkState(lstStr, context);
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

  void setLinkState(List<String> lstStr, BuildContext context) {
    // String nameLink = lstStr[0].trim();
    String url = lstStr[2].trim();
    bool isAlert = false;
    
    if (widget.lstLinkIsarModule.isNotEmpty) {
      if (widget.lstLinkIsarModule.toList().map((e) => e.url).contains(url)) {
        isAlert = true;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Attenzione:"),
            content: const Text("URL già esistente!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
    if (!isAlert) {
      widget.lstLinkIsarModule.add(LibroIsarModuleUtil.createLinkIsarModule(lstStr[0].trim(), lstStr[2].trim(), descrizione: lstStr[1].trim()));
    }
  }

  Future<void> _fnDeleteLink(BuildContext context, LinkIsarModule? item) async {
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

  Future<void> _fnEditLink(BuildContext context, LinkIsarModule item) async {
    String? strDesc = await _editLink(context, item);
    if (strDesc != null && strDesc.contains(';') && strDesc.split(';').length == 3) {
      List<String> lstStr = strDesc.split(';');
      setState(() {
        setLinkState(lstStr, context);
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
