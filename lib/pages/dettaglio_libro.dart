
import 'dart:convert';

import 'package:book/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/utilities/libro_utils.dart';
import 'package:book/widgets/appbar/appbar_default.dart';
import 'package:book/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:book/widgets/dettaglio_libro/note_libro.dart';
import 'package:book/widgets/dettaglio_libro/scansioni.dart';
// import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:flutter/material.dart';
// import 'package:isar_community/isar.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DettaglioLibro extends StatelessWidget {
  static const String pagePath = '/HomeLibriLibreria/detailBook';
  static const String pageEditPath = '/LibreriaListaLibriPage/detailBook';
  static const String pageNewBookPath = '/LibreriaListaLibriPage/newBook';

  final LibroIsarModel libroViewModel;
  final List<LinkIsarModule> lstLinkIsarModule;
  final List<PdfIsarModule> lstPdfIsarModule;
  final bool showDelete;

  final bool isInsertByUserInterface;
  // late final TextEditingController txtNoteLibroCtrl;
  late final QuillController txtNoteLibroCtrl;
  late final LibroIsarModel libroViewModelClone;
  late final String hashLibroViewModelClone;
  late final List<LinkIsarModule> lstLinkIsarModuleInit;
  late final List<PdfIsarModule> lstPdfIsarModuleInit;

  DettaglioLibro({
    super.key,
    required this.libroViewModel,
    required this.lstLinkIsarModule,
    required this.lstPdfIsarModule,
    required this.showDelete,
    this.isInsertByUserInterface = false,
  }) {
    String noteInit = libroViewModel.note;

    if (noteInit.trim() == '') {
      // txtNoteLibroCtrl = TextEditingController();
      txtNoteLibroCtrl = QuillController.basic();
    } else {
      // txtNoteLibroCtrl = QuillController(document: Document.fromJson(jsonDecode(noteInit)),
      //   selection: const TextSelection.collapsed(offset: 0),
      // );
      try {
        // 2. PROVA: È un JSON Delta di Quill? (es. '[{"insert":"Test\\n"}]')
        final jsonString = noteInit;
        txtNoteLibroCtrl = QuillController(
          document: Document.fromJson(jsonDecode(jsonString)),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        // 3. FALLITO: Allora è testo semplice (es. "Test\n")
        // Creiamo un documento vuoto e inseriamo il testo manualmente
        final doc = Document()..insert(0, noteInit);

        txtNoteLibroCtrl =  QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      }

      // print(jsonDecode(noteInit));
      // txtNoteLibroCtrl = TextEditingController(text: noteInit);
      // controller = QuillController(
      //   document: Document.fromJson(jsonDecode(noteInit)),
      //   selection: const TextSelection.collapsed(offset: 0),
      // );
    }

    libroViewModelClone = libroViewModel.clonaLibro();
    hashLibroViewModelClone = libroViewModelClone.calcolaHash();

    lstLinkIsarModuleInit = cloneLstLinkIsarModule(lstLinkIsarModule);
    lstPdfIsarModuleInit = cloneLstPdfIsarModule(lstPdfIsarModule);
  }

  List<LinkIsarModule> cloneLstLinkIsarModule(List<LinkIsarModule> original) {
    return original.map((item) => LinkIsarModule()
      ..id = item.id
      ..name = item.name
      ..descrizione = item.descrizione
      ..url = item.url).toList();
  }

  List<PdfIsarModule> cloneLstPdfIsarModule(List<PdfIsarModule> original) {
    return original.map((item) => PdfIsarModule()
      ..id = item.id
      ..name = item.name
      ..descrizione = item.descrizione
      ..testo = item.testo
        ..pathNameFile = item.pathNameFile).toList();
  }

  @override
  Widget build(BuildContext context) {

    returnToScreen(bool isDelete) async {
      bool? isRemoveBook = false;
      if (isDelete) {
        isRemoveBook = await DialogUtils.showConfirmationSiNo(
          context,
          'Vuoi rimuovere il libro dalla lista ?',
        );
      }
      if (isDelete && isRemoveBook == false) {
        return;
      } else if (context.mounted) {
        Navigator.pop(
          context,
          LibroDettaglioResult(
            libroViewModel,
            lstLinkIsarModule,
            lstPdfIsarModule,
            !isDelete,
            isDelete && (isRemoveBook != null && isRemoveBook),
          ),
        );
      }
    }

    // V
    IconButton iconCheckAddLibro(context) {
      return IconButton(
        icon: const Icon(Icons.check),
        // onPressed: () => returnToScreen(false),
        onPressed: () {
          libroViewModel.note = jsonEncode(txtNoteLibroCtrl.document.toDelta().toJson());
          returnToScreen(false);
        },
        color: Colors.greenAccent,
      );
    }

    goBack() async {
      // libroViewModel.note = txtNoteLibroCtrl.document.toPlainText();
      // libroViewModel.note = txtNoteLibroCtrl.document.toPlainText();
      if (txtNoteLibroCtrl.document.getPlainText(0, txtNoteLibroCtrl.document.length) == "\n") {
        libroViewModel.note = "";
      } else {
        libroViewModel.note = jsonEncode(txtNoteLibroCtrl.document.toDelta().toJson());
      }

      // libroViewModel.note = libroViewModel.note.substring(0, libroViewModel.note.length - 1);
      String hashLibro = libroViewModel.calcolaHash();

      bool isLinkEqual = LibroUtils.areLinkIsarModuleListsEqual(lstLinkIsarModuleInit, lstLinkIsarModule);
      bool isListPdfEqual = LibroUtils.arePdfIsarModuleListsEqual(lstPdfIsarModuleInit, lstPdfIsarModule);
      // if (!isLinkEqual) {
      //   libroViewModel.lstLinkIsarModule.clear();
      //   libroViewModel.lstLinkIsarModule.addAll(lstLinkIsarModule);
      // }

      if (hashLibro != hashLibroViewModelClone || !isLinkEqual || !isListPdfEqual) {
        bool? isUpdateBook = await DialogUtils.showConfirmationSiNo(
          context,
          'Vuoi salvare le modifiche ?',
        );
        if (isUpdateBook != null && isUpdateBook) {
          // Update
          // libroViewModel.note = txtNoteLibroCtrl.document.toPlainText();
          returnToScreen(false);
        } else {
          if (!context.mounted) return;
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
      }
    }

    // <=
    IconButton iconButtonBack = IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      onPressed: () async {
        goBack();
      },
    );

    // DELETE
    IconButton iconDeleteLibro = IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => returnToScreen(true),
      color: Colors.orangeAccent,
    );

    Widget tabBarDettaglioLibro = TabBar(
      indicatorColor: Colors.green,
      tabs: const [
        Tab(text: "Dettaglio"),
        Tab(text: " N o t e "),
        Tab(text: "Scansioni"),
      ],
      unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
      labelColor: Colors.yellow,
      indicator: MaterialIndicator(
          color: Colors.green,
          height: 5,
          topLeftRadius: 8,
          topRightRadius: 8,
          horizontalPadding: 0.0,
          tabPosition: TabPosition.bottom,
          strokeWidth: 10
      ),
    );

    // Vedi: buttons_tabbar: 1.3.15
    // ButtonsTabBar tabBarDettaglioLibro =  ButtonsTabBar(
    //   backgroundColor: Colors.red,
    //   unselectedBackgroundColor: Colors.blue[700], //[300],
    //   unselectedLabelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
    //   labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //   contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
    //   contentCenter: false,
    //   center: false,
    //   elevation: 0.5,
    //   buttonMargin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
    //   physics: const NeverScrollableScrollPhysics(),
    //   splashColor: Colors.lightBlueAccent,
    //   tabs: [
    //     Tab(
    //       icon: Icon(Icons.book),
    //       text: "Dettaglio",
    //     ),
    //     Tab(
    //       icon: Icon(Icons.note),
    //       text: "Note",
    //     ),
    //     Tab(
    //       icon: Icon(Icons.picture_as_pdf),
    //       text: "Scansioni",
    //     ),
    //   ],
    // );

    // TabBar tabBarDettaglioLibro = TabBar(
    //   isScrollable: false,
    //   labelColor: Colors.yellow,
    //   unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
    //   indicatorPadding: EdgeInsets.zero,
    //   labelPadding: EdgeInsets.zero,
    //   padding: EdgeInsets.zero,
    //   automaticIndicatorColorAdjustment: true,
    //   overlayColor: WidgetStateProperty.resolveWith<Color?>(
    //         (Set<WidgetState> states) {
    //       if (states.contains(WidgetState.hovered)) {
    //         return Colors.amberAccent; //<-- SEE HERE
    //       }
    //       return null;
    //     },
    //   ),
    //   indicator: BoxDecoration(
    //     // shape: BoxShape.circle,
    //     borderRadius: BorderRadius.circular(0), // Creates border
    //     color: Colors.blueGrey,
    //   ),
    //   tabs: const [
    //     Tab(text: 'D e t t a g l i o'),
    //     Tab(text: '-  N o t e  -'),
    //     Tab(text: 'S c a n s i o n i'),
    //   ],
    // );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        goBack();
      },
      child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Builder(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBarDefault(
                    context: context,
                    percHeight: 4,
                    primaryColor: const Color.fromARGB(255, 33, 44, 49),
                    secondaryColor: Colors.blue,
                    txtLabel: libroViewModel.titolo,
                    lstWidgetDx: showDelete
                        ? [iconDeleteLibro, iconCheckAddLibro(context)]
                        : [iconCheckAddLibro(context)],
                    iconSx: iconButtonBack,
                  ),
                  body: Column(
                    children: [
                      PreferredSize(
                        preferredSize: Size.fromHeight(
                          (MediaQuery.of(context).size.height * 4 / 100),
                        ),
                        child: Material(
                          color: const Color.fromARGB(110, 27, 69, 90),
                          surfaceTintColor: Colors.deepOrange[100],
                          child: tabBarDettaglioLibro, // Assumendo che questo contenga la tua TabBar
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          // Rimuovendo 'physics: const NeverScrollableScrollPhysics()'
                          // si ripristina la funzionalità di swipe predefinita.
                          viewportFraction: 1,
                          children: [
                            DettaglioLibroWidget(
                              libroViewModel,
                              !showDelete,
                              lstLinkIsarModule,
                              isInsertByUserInterface: isInsertByUserInterface,
                            ),
                            NoteLibro(libroViewModel, txtNoteLibroCtrl),
                            Scansioni(libroViewModel, lstPdfIsarModule),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
    );
  }
}
