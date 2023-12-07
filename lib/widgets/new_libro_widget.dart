import 'dart:io';

import 'package:books/config/constant.dart';
import 'package:books/features/appbar/blocs/app_bar_bloc.dart';
import 'package:books/features/appbar/blocs/app_bar_events.dart';
import 'package:books/features/libro/blocs/libro_bloc.dart';
import 'package:books/features/libro/blocs/libro_events.dart';
import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_search_model.dart';
import 'package:books/models/parameter_google_search_model.dart';
import 'package:books/pages/search_list_book_page.dart';
import 'package:books/services/libro_search_service.dart';
import 'package:flutter/material.dart';


class NewLibroWidget extends StatefulWidget {
  // final BuildContext parentContext;
  // final Function addTx;
  // final Function addNewLibro;
  final LibroBloc libroBloc;
  final AppBarBloc appBarBloc;

  const NewLibroWidget(this.libroBloc, this.appBarBloc, {super.key});

  @override
  State<NewLibroWidget> createState() => _NewLibroWidgetState();
}

class _NewLibroWidgetState extends State<NewLibroWidget> {
  final titoloController = TextEditingController();
  final autoreController = TextEditingController();
  final editoreController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    Future<void> execSimpleGoogleBooksSearch(ParameterGoogleSearchModel googleSearchModel) async {
      if (googleSearchModel.title != null || googleSearchModel.author != null || googleSearchModel.isbn != null) {
        List<LibroSearchModel> libri = [];
        try {
          libri = await LibroSearchService.simpleGoogleBooksSearch(googleSearchModel);
        } catch (errore) {
          if (errore is HandshakeException && errore.type == "HandshakeException") {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Problemi di connessione, riprovare più tardi !')));
            }
          }
          else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Errore chiamata al Google !')));
            }
          }
        }
        
        if (libri.isNotEmpty) {
          if (mounted) {
            Navigator.of(context).pop();

            LibroDettaglioResult? libroDettaglioResult = await Navigator.pushNamed<dynamic> (
              context, 
              SearchListBookPage.pagePath, 
              arguments: {'googleSearchModel': googleSearchModel, 'libreriaSel': Constant.libreriaInUso! /* 'libri': libri, 'nrTot': totalFindedBooks*/}
            );
            
            if (libroDettaglioResult != null) {
              widget.libroBloc.add(AddLibroEvent(Constant.libreriaInUso!, libroDettaglioResult.libroViewModel));
              widget.appBarBloc.add(SwithToTextAppBarEvent());
            }
          }        
        } else {
          if (mounted) {
            Navigator.of(context).pop();  
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nessun libro trovato !')));
          }
        }
      }
    }

    Future<void> submitData(BuildContext context) async {
      final enteredTitolo = titoloController.text;
      final enteredAutore = autoreController.text;
      final enteredEditore = editoreController.text;

      if (enteredTitolo.isEmpty && enteredAutore.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Inserire anche il Titolo e/o l'Autore !")));
        return;
      }
      
      ParameterGoogleSearchModel googleSearchModel = ParameterGoogleSearchModel(title: enteredTitolo, author: enteredAutore, casaEditrice: enteredEditore);
      await execSimpleGoogleBooksSearch(googleSearchModel);

      // if (mounted) {
      //   Navigator.of(context).pop();
      // }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,      
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(labelText: 'Titolo'),
            controller: titoloController,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(color: Colors.amber.shade700, fontSize: 16),
            onSubmitted: (_) => submitData(context),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Autore'),
            controller: autoreController,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(color: Colors.deepOrange.shade300, fontSize: 16),
            keyboardType: TextInputType.name,
            onSubmitted: (_) => submitData(context),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Casa Editrice'),
            controller: editoreController,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(color: Colors.deepOrange.shade400, fontSize: 16),
            keyboardType: TextInputType.text,
            onSubmitted: (_) => submitData(context),
          ),
          // const SizedBox(height: 1),
          TextButton.icon(
            icon: const Icon(
              Icons.search,
              color: Colors.greenAccent,
              size: 20.0,
            ),
            label: const Text('Cerca', 
              style: TextStyle(color: Colors.greenAccent, fontSize: 16),
              selectionColor: Colors.greenAccent
            ),
            onPressed: () => submitData(context),
            /*style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            ),*/
          ),
        ],
      ),
    );
  }
}
