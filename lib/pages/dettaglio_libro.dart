import 'dart:convert';

import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/appbar/appbar_default.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:books/widgets/dettaglio_libro/note_libro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';


class DettaglioLibro extends StatelessWidget {
  static const String pagePath = '/HomeLibriLibreria/detailBook';
  static const String pageEditPath = '/LibreriaListaLibriPage/detailBook';

  final LibroViewModel libroViewModel;
  final bool showDelete;
  late final QuillController controller;

  DettaglioLibro({super.key, required this.libroViewModel, required this.showDelete}) {
    String noteInit = libroViewModel.note;
    // print("===========================> $noteInit");
    if (noteInit.trim() == '') {
      controller = QuillController.basic();
    } else {
      // print(jsonDecode(noteInit));
      controller = QuillController(document: Document.fromJson(jsonDecode(noteInit)),
          selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    returnToScreen(bool isDelete) async {
      bool? isRemoveBook = false;
      if (isDelete) {
        isRemoveBook = await DialogUtils.showConfirmationSiNo(context, 'Vuoi rimuovere il libro dalla lista ?');
      }
      if (context.mounted) {
        Navigator.pop(context, LibroDettaglioResult(libroViewModel, !isDelete, isDelete && (isRemoveBook != null && isRemoveBook))); 
      }
    }

    IconButton iconCheckAddLibro = IconButton(
      icon: const Icon(Icons.check),
      onPressed: () => returnToScreen(false),
      color: Colors.greenAccent,
    );

    IconButton iconDeleteLibro = IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => returnToScreen(true),
      color: Colors.orangeAccent,
    );

    TabBar tabBar = TabBar(
      isScrollable: false,
      labelColor: Colors.yellow,
      unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
      indicatorPadding: EdgeInsets.zero,
      automaticIndicatorColorAdjustment: true,
      tabs: const [
        Tab(text: 'Dettaglio',),
        Tab(text: 'Note',),
        // Tab(text: 'Preview',),
      ],
    );
    
    return SafeArea(
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBarDefault(
                context: context,
                percHeight: 4,
                // secondaryColor: const Color.fromARGB(115, 0, 143, 88),
                // colors: <Color>[Color.fromARGB(255, 33, 44, 49), Colors.blue],
                primaryColor : const Color.fromARGB(255, 33, 44, 49),
                secondaryColor: Colors.blue,
                txtLabel: libroViewModel.titolo,
                lstWidgetDx: showDelete
                  ? [ iconDeleteLibro, iconCheckAddLibro ]
                  : [ iconCheckAddLibro ]
              ),
              body: Column(
                children: [
                  PreferredSize(
                    // preferredSize: tabBar.preferredSize,
                    preferredSize: Size.fromHeight((MediaQuery.of(context).size.height * 4 / 100)),
                    child: Material(
                      // color: const Color.fromARGB(115, 0, 143, 88),
                      color: const Color.fromARGB(110, 27, 69, 90),
                      surfaceTintColor: Colors.deepOrange[100],
                      child: tabBar,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      viewportFraction: 1,
                      children: [
                        DettaglioLibroWidget(libroViewModel, !showDelete),
                        NoteLibro(libroViewModel, controller)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),  
        )
    );
  }
}