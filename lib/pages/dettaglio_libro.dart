import 'dart:convert';

import 'package:book/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/utilities/libro_utils.dart';
import 'package:book/utilities/utils.dart';
import 'package:book/widgets/appbar/appbar_default.dart';
import 'package:book/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:book/widgets/dettaglio_libro/note_libro.dart';
import 'package:book/widgets/dettaglio_libro/scansioni.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:book/widgets/appbar/desktop_bar.dart';


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
      txtNoteLibroCtrl = QuillController.basic();
    } else {
      try {
        // Check: è un JSON Delta di Quill? (es. '[{"insert":"Test\\n"}]')
        final jsonString = noteInit;
        txtNoteLibroCtrl = QuillController(
          document: Document.fromJson(jsonDecode(jsonString)),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        // Check FALLITO: è testo semplice (es. "Test\n")
        final doc = Document()..insert(0, noteInit);

        txtNoteLibroCtrl =  QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
    }

    libroViewModelClone = libroViewModel.clonaLibro();
    if (libroViewModelClone.note != "" && jsonDecode(libroViewModelClone.note).toString() == jsonDecode("[{\"insert\":\"\\n\"}]").toString()) {
      libroViewModelClone.note = "";
    }
    hashLibroViewModelClone = libroViewModelClone.calcolaHash();

    lstLinkIsarModuleInit = LibroUtils.cloneLstLinkIsarModule(lstLinkIsarModule);
    lstPdfIsarModuleInit = LibroUtils.cloneLstPdfIsarModule(lstPdfIsarModule);
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

    DesktopBar desktopBar = DesktopBar();
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return DefaultTabController(
      length: 3,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) return;
          goBack(); // Assicurati che goBack gestisca correttamente il Navigator
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                desktopBar.gestureDetector,
                Expanded(
                  child: Scaffold(
                    appBar: AppBarDefault(
                      context: context,
                      percHeight: 4,
                      primaryColor: const Color.fromARGB(255, 33, 44, 49),
                      secondaryColor: Colors.blue,
                      txtLabel: Utils.rimuoviAccapo(libroViewModel.titolo),
                      lstWidgetDx: showDelete
                          ? [iconDeleteLibro, iconCheckAddLibro(context)]
                          : [iconCheckAddLibro(context)],
                      iconSx: iconButtonBack,
                    ),
                    body: Column(
                      children: [
                        !isDesktop
                          ? Material(
                            color: const Color.fromARGB(110, 27, 69, 90),
                            child: tabBarDettaglioLibro,
                          ) : Padding(padding: EdgeInsetsGeometry.all(0)),
                        // Sezione Contenuto Pagine
                        Expanded(
                          child: isDesktop
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 3, child: DettaglioLibroWidget(libroViewModel, !showDelete, lstLinkIsarModule, isInsertByUserInterface: isInsertByUserInterface)),
                                    const VerticalDivider(width: 1), // Separatore opzionale
                                    Expanded(flex: 3, child: NoteLibro(libroViewModel, txtNoteLibroCtrl)),
                                    const VerticalDivider(width: 1),
                                    Expanded(flex: 3, child: Scansioni(libroViewModel, lstPdfIsarModule)),
                                  ],
                                )
                              : TabBarView( // VISUALIZZAZIONE MOBILE (Tab classiche)
                                  children: [
                                    DettaglioLibroWidget(libroViewModel, !showDelete, lstLinkIsarModule, isInsertByUserInterface: isInsertByUserInterface),
                                    NoteLibro(libroViewModel, txtNoteLibroCtrl),
                                    Scansioni(libroViewModel, lstPdfIsarModule),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
