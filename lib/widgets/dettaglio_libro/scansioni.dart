import 'dart:io';

import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/models/widget_desc.module.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/widgets/dettaglio_libro/fields_libro/descrizione_field.dart';
import 'package:book/widgets/dettaglio_libro/image_to_pdf.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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

  Future<void> _fnDeleteLink(BuildContext context, PdfIsarModule item) async {
    bool? isRemoveBook = await DialogUtils.showConfirmationSiNo(
      context,
      "Elimino il PDF '${item.name}' ?",
    );
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

  Future<void> _fnEditLink(BuildContext context, PdfIsarModule item) async {
    String? strDesc = await _editLink(context, item);

    if (strDesc != null &&
        strDesc.contains(';') &&
        strDesc.split(';').length == 2) {
      List<String> lstStr = strDesc.split(';');
      setState(() {
        item.name = lstStr[0].trim();
        item.descrizione = lstStr[1].trim();
      });
    }
  }

  Future<String?> _editLink(BuildContext context, PdfIsarModule item) async {
    List<WidgetDescModel> lstWidgetDescModel = [
      WidgetDescModel('Nome:', item.name, maxLines: 1),
      WidgetDescModel('Descrizione:', item.descrizione, maxLines: 1),
    ];
    return await DialogUtils.getMultiDescrizione(context, lstWidgetDescModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Per ora commentata la ricerca
      // appBar: _createPreferredSize(context), // _createAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (widget._libroViewModel.id > 0) ? _createFloatingActionButton(context) : Padding(padding: const EdgeInsets.symmetric(horizontal: 0)),
      body: widget._lstPdfIsarModule.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: widget._lstPdfIsarModule.map((item) {
                  return getWidgetPdf(
                    context,
                    widget._libroViewModel,
                    item,
                    () => {_fnDeleteLink(context, item)},
                    () => {_fnEditLink(context, item)},
                  );
                }).toList(),
              ),
            )
          : Center(
              child: Image.asset(Constant.assetImageDefault, fit: BoxFit.cover),
            ),
    );
  }

  void _goToImageToPdf(BuildContext context, {bool isCamera = false, bool isGallery = false,}) async {
    await Navigator.pushNamed(
      context,
      ImageToPdf.pagePath,
      arguments: {
        'libroViewModel': widget._libroViewModel,
        'lstPdfIsarModule': widget._lstPdfIsarModule,
        'isCamera': isCamera,
        'isGallery': isGallery
      },
    );

    setState(() {
      // ...
    });
  }

  Widget _createFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.translucent,
            child: FloatingActionButton(
              heroTag: "btnImageAlbum",
              onPressed: () {
                _goToImageToPdf(context, isGallery: true);
              },
              // backgroundColor: Colors.transparent,
              backgroundColor: const Color.fromARGB(38, 50, 56, 100),
              child: Icon(
                MdiIcons.imageAlbum,
                // color: const Color.fromARGB(183, 244, 67, 54),
                color: Theme.of(context).colorScheme.onSecondary,
                shadows: const [],
                size: 55,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.translucent,
            child: FloatingActionButton(
              heroTag: "btnCameraPlus",
              onPressed: () {
                _goToImageToPdf(context, isCamera: true);
              },
              // backgroundColor: Colors.transparent,
              backgroundColor: const Color.fromARGB(38, 50, 56, 100),
              elevation: 6,
              hoverElevation: 8,
              highlightElevation: 12,
              enableFeedback: true,
              child: Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: true,
                child: Icon(
                  MdiIcons.cameraPlus,
                  color: Theme.of(context).colorScheme.onSecondary,
                  shadows: const [],
                  size: 55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
