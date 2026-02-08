import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';


class NoteLibro extends StatefulWidget {
  final LibroIsarModel _libroViewModel;
  final QuillController _controller;

  const NoteLibro(this._libroViewModel, this._controller, {super.key});

  @override
  State<NoteLibro> createState() => _NoteLibro();
}

class _NoteLibro extends State<NoteLibro> with AutomaticKeepAliveClientMixin {
  final FocusNode _focusNode = FocusNode();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // È buona norma disporre il FocusNode quando il widget viene distrutto
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Necessario per il KeepAlive

    return ColoredBox(
      color: const Color.fromARGB(255, 27, 69, 90),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: (MediaQuery.of(context).size.height * 55 / 100),
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[50]!,
                            offset: const Offset(5.0, 5.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0
                        ),
                        const BoxShadow(
                            color: Colors.black87,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0
                        )
                      ]
                  ),
                  child: QuillEditor.basic(
                    controller: widget._controller,
                    config: const QuillEditorConfig(),
                  ),
                  // child: QuillEditor.basic(
                  //   config: QuillEditorConfig(
                  //     controller: widget._controller,
                  //     readOnly: false,
                  //     sharedConfigurations:  QuillSharedConfigurations(
                  //       locale: const Locale('it'),
                  //       dialogTheme: QuillDialogTheme(
                  //           labelTextStyle: const TextStyle(color: Colors.black),
                  //           inputTextStyle: TextStyle(color: Colors.yellow[200])
                  //       ),
                  //     ),
                  //     onTapOutside: (event, focusNode) => {
                  //       widget._libroViewModel.note = jsonEncode(widget._controller.document.toDelta().toJson()),
                  //     },
                  //   ),
                  // )
              ),
            ),
            QuillSimpleToolbar(
              controller: widget._controller,
              config: const QuillSimpleToolbarConfig(
                  dialogTheme: QuillDialogTheme(
                    // Colore di sfondo della finestra (es. quando inserisci un link)
                    dialogBackgroundColor: Color.fromARGB(255, 240, 248, 255), // AliceBlue

                    // Bordo arrotondato della finestra
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      side: BorderSide(color: Color.fromARGB(255, 27, 69, 90), width: 2),
                    ),

                    // Stile del testo delle etichette (es. "Inserisci URL")
                    labelTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 27, 69, 90),
                    ),

                    // Stile del testo che l'utente scrive (l'URL o il testo del link)
                    inputTextStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),

                    // Spaziatura interna
                    // padding: EdgeInsets.all(20.0),
                  )
              ),
            ),
            // QuillToolbar.simple(
            //   configurations: QuillSimpleToolbarConfigurations(
            //     controller: widget._controller,
            //     sharedConfigurations: const QuillSharedConfigurations(
            //       dialogBarrierColor: Colors.black,
            //       locale: Locale('it'),
            //     ),
            //     color: Colors.amber,
            //
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

}



// import 'package:flutter/material.dart';
//
// class NoteLibro extends StatefulWidget {
//   //  final LibroIsarModel _libroViewModel;
//   //  final QuillController _controller;
//   //  const NoteLibro(this._libroViewModel, this._controller, {super.key});
//
//   final TextEditingController _txtNoteLibroCtrl;
//
//   const NoteLibro(this._txtNoteLibroCtrl, {super.key});
//
//   @override
//   State<NoteLibro> createState() => _NoteLibro();
// }
//
// class _NoteLibro extends State<NoteLibro> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       // La SafeArea garantisce che il contenuto non sia coperto dalle tacche/barra di stato
//       child: Padding(
//         // Applica un bordo (padding) uniforme tutto attorno al widget (es. 8.0)
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           // La Column si espande per riempire lo spazio orizzontale disponibile
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//
//           // NON usare SingleChildScrollView qui.
//           // NON usare mainAxisSize: MainAxisSize.min, altrimenti non si espande.
//
//           children: <Widget>[
//             // Usiamo Expanded per riempire tutto lo spazio verticale rimanente
//             Expanded(
//               child: Card(
//                 color: Colors.grey,
//                 // Rimuoviamo il SizedBox con altezza fissa e lasciamo che Expanded faccia il suo lavoro
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: TextField(
//                     // Imposta maxLines a null e expands a true per espandere il TextField
//                     // e usare tutto lo spazio disponibile all'interno del Card.
//                     maxLines: null,
//                     expands: true,
//                     keyboardType: TextInputType.multiline,
//                     autofocus: true,
//                     controller: widget._txtNoteLibroCtrl,
//                     style: Theme.of(context).textTheme.titleSmall,
//                     textAlignVertical: TextAlignVertical.top, // Allinea il testo in alto
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
