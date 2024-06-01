import 'dart:io';

import 'package:books/features/libro/data/models/pdf_isar.module.dart';
import 'package:books/models/widget_desc.module.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/fields_libro/descrizione_field.dart';
import 'package:books/widgets/dettaglio_libro/image_to_pdf.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';

import '../../config/constant.dart';

class Scansioni extends StatefulWidget {
  final LibroIsarModel _libroViewModel;
  final List<PdfIsarModule> _lstPdfIsarModule;

  const Scansioni(this._libroViewModel, this._lstPdfIsarModule, {super.key});

  @override
  State<Scansioni> createState() => _Scansioni();
}

class _Scansioni extends State<Scansioni> {
  final TextEditingController _textCtrlAddSearch = TextEditingController();

  @override
  void dispose() {
    _textCtrlAddSearch.dispose();
    super.dispose();
  }

  _fnDeleteLink(BuildContext context, PdfIsarModule item) async {
    bool? isRemoveBook = await DialogUtils.showConfirmationSiNo(context, "Elimino il PDF '${item.name}' ?");
    if (isRemoveBook == true) {
      setState(() {
        File file = File(item.pathNameFile);
        if (file.existsSync()) {
          file.deleteSync();
        }
        widget._lstPdfIsarModule.remove(item);
      });
    }
  }

  _fnEditLink(BuildContext context, PdfIsarModule item) async {
    String? strDesc = await _editLink(context, item);

    if (strDesc != null && strDesc.contains(';') && strDesc.split(';').length == 2) {
      List<String> lstStr = strDesc.split(';');
      setState(() {
        item.name = lstStr[0].trim();
        item.descrizione = lstStr[1].trim();
      });
    }
  }

  Future<String?> _editLink(BuildContext context, PdfIsarModule item) async {
    List<WidgetDescModel> lstWidgetDescModel = [
      WidgetDescModel('Nome:', item.name, maxLines:1), 
      WidgetDescModel('Descrizione:', item.descrizione, maxLines:1),
    ];
    return await DialogUtils.getMultiDescrizione(context, lstWidgetDescModel);    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createPreferredSize(context), // _createAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _createFloatingActionButton(context),
      body: widget._lstPdfIsarModule.isNotEmpty
        ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: widget._lstPdfIsarModule.map((item) {
                  return getWidgetPdf(context, widget._libroViewModel, item,
                    () => {
                      _fnDeleteLink(context, item)
                    },
                    () => {
                      _fnEditLink(context, item)
                    }
                  );
                }).toList()
            ),
        )
          : Center(
            child: Image.asset(Constant.assetImageDefault, fit: BoxFit.cover,),
              // Text('Nessun PDF salvato',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.blue, fontSize: 24),
            )
    );
  } 

  PreferredSize _createPreferredSize(BuildContext context) {
    const num percHeight = 5;
    const Color primaryColor = Color.fromARGB(132, 33, 149, 243);
    const Color secondaryColor = Color.fromARGB(166, 3, 163, 175);
    
    return PreferredSize(
      preferredSize: Size.fromHeight((MediaQuery.of(context).size.height * percHeight / 100)),
      child: Container(
        height: MediaQuery.of(context).size.height * percHeight / 100,
        alignment: const Alignment(-0.9, 0.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[primaryColor, secondaryColor],
            tileMode: TileMode.clamp,
            begin: Alignment.centerLeft,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: _createTextAddSearchPDF(context, _textCtrlAddSearch),
            ),
          ]
        ),
      )
    );
  }

  void _goToImageToPdf(BuildContext context, {bool isCamera = false, bool isGallery = false}) async {
    await Navigator.pushNamed(context, ImageToPdf.pagePath, arguments: {
      'libroViewModel': widget._libroViewModel,
      'lstPdfIsarModule': widget._lstPdfIsarModule,
      'isCamera': isCamera,
      'isGallery': isGallery
    });

    setState(() {
      // ...
    });
  }
  
  Widget _createFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              _goToImageToPdf(context, isGallery: true);
            },
            backgroundColor: Colors.transparent,
            child: const Icon(
              Icons.photo_album_rounded,
              color: Color.fromARGB(166, 255, 235, 59),
              size: 55,
            ),
          ),
          const Spacer(),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              _goToImageToPdf(context, isCamera: true);
            },
            backgroundColor: Colors.transparent,
            child: Icon(
              MdiIcons.cameraPlus,
              color: const Color.fromARGB(183, 244, 67, 54),
              shadows: const [],
              size: 55
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTextAddSearchPDF(BuildContext context, TextEditingController textCtrlSearch) {
    return TextField(
      textInputAction: TextInputAction.search,
      controller: textCtrlSearch,
      textAlignVertical: TextAlignVertical.center,
      // autofocus: true,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      onSubmitted: (value) {
        // ComArea.bookToSearch = textCtrlSearch.text;
        // widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 180, 218, 228),
        hintText: 'cerca...',
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          color: Colors.black,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.search),
          onPressed: () {                  
            textCtrlSearch.clear();
            // ComArea.bookToSearch = '';
            // widget._libroBloc.add(LoadLibroEvent(ComArea.lstLibrerieInUso));
            FocusScope.of(context).unfocus();
            setState(() {
              // ComArea.appBarStateText = true;
            });
          },
        ),
        isCollapsed: true,
        isDense: true
      ),
    );
  }
}

