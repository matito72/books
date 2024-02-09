import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/models/books_search_parameters.module.dart';
import 'package:books/resources/bisac_codes.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/bisac_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class RicercaAvanzata extends StatefulWidget {
  final LibroBloc _libroBloc;
  final List<LibreriaIsarModel> _lstLibreriaSel;
  
  const RicercaAvanzata(this._libroBloc, this._lstLibreriaSel, {super.key});

  @override
  State<RicercaAvanzata> createState() => _RicercaAvanzataState();
}

class _RicercaAvanzataState extends State<RicercaAvanzata> {
  TextEditingController txtTitoloCtrl = TextEditingController();
  TextEditingController txtAutoreCtrl = TextEditingController();
  TextEditingController txtEditoreCtrl = TextEditingController();
  TextEditingController txtDescrizioneCtrl = TextEditingController();
  String txtCategoriaSel = BisacList.nonClassifiable;
  TextEditingController txtAnnoPubblicazioneDaCtrl = TextEditingController();
  TextEditingController txtAnnoPubblicazioneACtrl = TextEditingController();
  TextEditingController txtPrezzoMinCtrl = TextEditingController();
  TextEditingController txtPrezzoMaxCtrl = TextEditingController();
  TextEditingController txtCategoriaCtrl = TextEditingController();

  @override
  void dispose() {
    txtTitoloCtrl.dispose();
    txtAutoreCtrl.dispose();
    txtEditoreCtrl.dispose();
    txtDescrizioneCtrl.dispose();
    txtAnnoPubblicazioneDaCtrl.dispose();
    txtAnnoPubblicazioneACtrl.dispose();
    txtPrezzoMinCtrl.dispose();
    txtPrezzoMaxCtrl.dispose();
    txtCategoriaCtrl.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (ComArea.booksSearchParameters.isEmpty()) {
      clearTxtControllerForm();
    }

    return SizedBox(
      width: (MediaQuery.of(context).size.width * 98 / 100),
      height: (MediaQuery.of(context).size.height * 35 / 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              getHeaderText(),
            ],
          ),
          // const Padding(
          //   padding: EdgeInsets.only(top: 5),
          // ),
          formRicercaLibriLibreria(context)
        ],
      ),
    );
  }

  Widget formRicercaLibriLibreria(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    Color getColor(int i) {
      if (i % 2 == 0) {
        return evenItemColor;
      } else {
        return oddItemColor;
      }
    }

    int j = 0;

    return Expanded(
      flex: 10,
      child: SizedBox(
        height: 150.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: 1,
                textCapitalization: TextCapitalization.none,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                decoration: InputDecoration(
                  prefixStyle: Theme.of(context).textTheme.titleSmall,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  fillColor: getColor(j++),
                  filled: true, 
                  hintText: (txtTitoloCtrl.text.isEmpty || txtTitoloCtrl.text == '') ? 'Titolo: ' : '',
                  prefixText: txtTitoloCtrl.text.isEmpty ? '' : 'Titolo: ',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                controller: txtTitoloCtrl,
                onChanged: (value) => {
                  setState(() {
                    txtTitoloCtrl.text = value;
                    updateComAreaBooksSearchParameters();
                  })
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 3)),
              TextField(
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                keyboardType: TextInputType.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                decoration: InputDecoration(
                  prefixStyle: Theme.of(context).textTheme.titleSmall,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  hintText: txtAutoreCtrl.text.isEmpty ? 'Autore: ' : '',
                  prefixText: txtAutoreCtrl.text.isEmpty ? '' : 'Autore: ',
                  fillColor: getColor(j++),
                  filled: true, 
                ),
                controller: txtAutoreCtrl,
                onChanged: (value) => {
                  setState(() {
                    txtAutoreCtrl.text = value;
                    updateComAreaBooksSearchParameters();
                  })
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 1)),
              TextField(
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                decoration: InputDecoration(
                  prefixStyle: Theme.of(context).textTheme.titleSmall,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  hintText: txtEditoreCtrl.text.isEmpty ? 'Editore: ' : '',
                  prefixText: txtEditoreCtrl.text.isEmpty ? '' : 'Editore: ',
                  fillColor: getColor(j++),
                  filled: true, 
                ),
                controller: txtEditoreCtrl,
                onChanged: (value) => {
                  setState(() {
                    txtEditoreCtrl.text = value;
                    updateComAreaBooksSearchParameters();
                  })
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 1)),
              TextField(
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                decoration: InputDecoration(
                  prefixStyle: Theme.of(context).textTheme.titleSmall,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  hintText: txtDescrizioneCtrl.text.isEmpty ? 'Descrizione: ' : '',
                  prefixText: txtDescrizioneCtrl.text.isEmpty ? '' : 'Descrizione: ',
                  fillColor: getColor(j++),
                  filled: true, 
                ),
                controller: txtDescrizioneCtrl,
                onChanged: (value) => {
                  setState(() {
                    txtDescrizioneCtrl.text = value;
                    updateComAreaBooksSearchParameters();
                  })
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 1)),
              ColoredBox(
                color: getColor(j++),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 3)),
                      Text(
                        'Categoria:',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      BisacDropdownMenu(
                        txtCategoriaSel,
                        widthPerc: 75,
                        onPressed: (value) {
                          setState(() {
                            txtCategoriaSel = value;
                            updateComAreaBooksSearchParameters();
                          });
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(left: 5)),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 1)),
              ColoredBox(
                color: Colors.transparent,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: TextField(
                        maxLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: true,
                        readOnly: true,
                        controller: txtAnnoPubblicazioneDaCtrl,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                        decoration: InputDecoration(
                          prefixStyle: Theme.of(context).textTheme.titleSmall,
                          labelStyle: Theme.of(context).textTheme.titleSmall,
                          hintText: txtAnnoPubblicazioneDaCtrl.text.isEmpty ? 'Dt. Pubb.ne da: ' : '',
                          prefixText: txtAnnoPubblicazioneDaCtrl.text.isEmpty ? '' : 'Dt. Pubb.ne da: ',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: evenItemColor,
                          filled: true, 
                        ),
                        onTap: () async {
                          String? annoDa = await DialogUtils.getAnno(context, DateTime(DateTime.now().year - 5, 1).year.toString());
                          if (annoDa != null) {
                            setState(() {
                              txtAnnoPubblicazioneDaCtrl.text = annoDa;
                              updateComAreaBooksSearchParameters();
                            });
                          }
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: TextField(
                        maxLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: true,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        controller: txtAnnoPubblicazioneACtrl,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                        decoration: InputDecoration(
                          prefixStyle: Theme.of(context).textTheme.titleSmall,
                          labelStyle: Theme.of(context).textTheme.titleSmall,
                          hintText: txtAnnoPubblicazioneACtrl.text.isEmpty ? 'Dt. Pubbl.ne a: ' : '',
                          prefixText: txtAnnoPubblicazioneACtrl.text.isEmpty ? '' : 'Dt. Pubbl.ne a: ',
                          fillColor: evenItemColor,
                          filled: true, 
                        ),
                        onTap: () async {
                          String? annoDa = await DialogUtils.getAnno(context, DateTime(DateTime.now().year, 1).year.toString());
                          if (annoDa != null) {
                            setState(() {
                              txtAnnoPubblicazioneACtrl.text = annoDa;
                              updateComAreaBooksSearchParameters();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextField(
                      maxLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      autofocus: true,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                      decoration: InputDecoration(
                        prefixStyle: Theme.of(context).textTheme.titleSmall,
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        hintText: txtPrezzoMinCtrl.text.isEmpty ? 'Prezzo min: ' : '',
                        prefixText: txtPrezzoMinCtrl.text.isEmpty ? '' : 'Prezzo min: ',
                        fillColor: getColor(j++),
                        filled: true, 
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
                      controller: txtPrezzoMinCtrl,
                      onChanged: (value) => {
                        setState(() {
                          txtPrezzoMinCtrl.text = value;
                          updateComAreaBooksSearchParameters();
                        })
                      },
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      maxLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.amberAccent[100]),
                      decoration: InputDecoration(
                        prefixStyle: Theme.of(context).textTheme.titleSmall,
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        hintText: txtPrezzoMaxCtrl.text.isEmpty ? 'Prezzo max: ' : '',
                        prefixText: txtPrezzoMaxCtrl.text.isEmpty ? '' : 'Prezzo max: ',
                        fillColor: getColor(j++),
                        filled: true, 
                      ),
                      controller: txtPrezzoMaxCtrl,
                      onChanged: (value) => {
                        setState(() {
                          txtPrezzoMaxCtrl.text = value;
                          updateComAreaBooksSearchParameters();
                        })
                      },
                    ),
                  ),
                ]
              ),
            ],
          ),
        )
      )
    );
  }

  Widget getHeaderText() {
    TextStyle defaultStyle = TextStyle(color: Colors.grey[200], fontSize: 18);
    TextStyle linkStyle = TextStyle(color: Colors.lightGreen[100]);

    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: Icon(
                MdiIcons.eraser, 
                size: 20,
                // color: const Color.fromARGB(255, 236, 26, 26)
                color: Colors.deepOrangeAccent
              ),
              onPressed: () => {
                setState(() {
                    clearSearchForm();
                })
                
              },
            ),
          ),
          TextSpan(
            text: '   Ricerca Libri  ',
            style: linkStyle
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: Icon(
                MdiIcons.bookSearch, 
                size: 20,
                color: const Color.fromARGB(255, 127, 228, 11),
              ),
              onPressed: () => {
                setState(() {
                    widget._libroBloc.add(LoadLibroEvent(widget._lstLibreriaSel));
                })
                
              },
            ),
          ),
        ],
      ),
    );
  }

  updateComAreaBooksSearchParameters() {
    ComArea.booksSearchParameters = BooksSearchParameters(
      txtTitolo: txtTitoloCtrl.text, 
      txtAutore: txtAutoreCtrl.text, 
      txtEditore: txtEditoreCtrl.text,
      txtCategoria: txtCategoriaSel,
      txtAnnoPubblicazioneDa: txtAnnoPubblicazioneDaCtrl.text, 
      txtAnnoPubblicazioneA: txtAnnoPubblicazioneACtrl.text,
      txtPrezzoMin: txtPrezzoMinCtrl.text,
      txtPrezzoMax: txtPrezzoMaxCtrl.text,
      txtDescrizione: txtDescrizioneCtrl.text
    );
    // if (ComArea.booksSearchParameters.isEmpty()) {
    //   ComArea.appBarStateText = true;
    //   ComArea.bookToSearch = '';
    // }
  }

  clearSearchForm() {
    clearTxtControllerForm();
    updateComAreaBooksSearchParameters();
    widget._libroBloc.add(LoadLibroEvent(widget._lstLibreriaSel));
  }

  clearTxtControllerForm() {
    txtTitoloCtrl.text = '';
    txtAutoreCtrl.text = '';
    txtEditoreCtrl.text = '';
    txtCategoriaSel = BisacList.nonClassifiable;
    txtAnnoPubblicazioneDaCtrl.text = '';
    txtAnnoPubblicazioneACtrl.text = '';
    txtPrezzoMinCtrl.text = '';
    txtPrezzoMaxCtrl.text = '';
    txtDescrizioneCtrl.text = '';
  }
}
