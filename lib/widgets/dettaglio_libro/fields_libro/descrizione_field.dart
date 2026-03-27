import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/link_isar.module.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:book/widgets/dettaglio_testo.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'dart:typed_data';

import 'package:book/utilities/pdf_utils.dart';
import 'package:book/config/com_area.dart';


Widget _getDescrizioneEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        splashColor: Colors.transparent,
        onDoubleTap: () async {
          String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione, isCapitalize: false);
          if (strDesc != null) {
            fn(strDesc);
          }
        },
        child: Text(
          'Descrizione',
          style: TextStyle(
            fontSize: 14,
            color: Colors.lightBlue.shade100,
            fontWeight: FontWeight.bold
          ),                                          
        ),
      ),
      Padding(
        // Applichiamo solo il padding orizzontale (sinistra e destra)
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Puoi cambiare il valore (es. 8.0, 20.0)
        child: ExpandableText(
          widget.libroViewModel.descrizione,
          expanded: ComArea.isDesktopApp,
          maxLines: 10,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
          expandText: '>>',
          collapseText: '<<',
        ),
      )
    ],
  );
}

Widget _getDescrizioneDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione, isCapitalize: true);
      if (strDesc != null) {
        fn(strDesc);
      }
    },
    child: Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width * 98 / 100),
          height: (MediaQuery.of(context).size.height * 20 / 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: Theme.of(context).colorScheme.background)
            border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
            // border: Border.all(color: Colors.transparent)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'Descrizione',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.lightBlue.shade100,
                    fontWeight: FontWeight.bold
                  ),                                          
                ),
              const Text(
                '''
                ''',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
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
              String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione, isCapitalize: true);
              if (strDesc != null) {
                fn(strDesc);
              }
            },
          ),
        )
      ],
    ),
  );
}

Widget getWidgetLink(BuildContext context, String? linkName, String? linkDescription, String? linkUrl, int typeBookSearch, LinkIsarModule? linkIsarModule, Function() fnDelete, Function()? fnEdit) {
  // bool isGoogleLinkPreview = (linkIsarModule == null);
  // linkName = (linkName == null && linkIsarModule != null) ? linkIsarModule.name : linkName;
  if (linkName == null && linkIsarModule != null) {
    linkName = linkIsarModule.name;
  } else {
    linkName = (typeBookSearch == 1)
        ? ("Google ${(linkName == null) ? "" : linkName}")
        : (typeBookSearch == 2)
          ? ("Open Library ${(linkName == null) ? "" : linkName}")
          : "";
  }

  linkDescription = (linkDescription == null && linkIsarModule != null) ? linkIsarModule.descrizione : linkDescription;
  linkUrl = (linkUrl == null && linkIsarModule != null) ? linkIsarModule.url : linkUrl;  
  
  if (linkUrl == null || linkUrl.isEmpty) {
    return const Text('');
  }

  return _getWidgetLinkPdf(context, linkName, linkDescription!, linkUrl: linkUrl, pdfPathFileName:'', fnDelete, fnEdit);
}

Widget getWidgetPdf(BuildContext context, LibroIsarModel libroViewModel, PdfIsarModule pdfIsarModule, Function() fnDelete, Function()? fnEdit) {
  String testoOcr = pdfIsarModule.testo;
  String linkName = pdfIsarModule.name;
  String linkDescription = pdfIsarModule.descrizione;
  String pdfPathFileName = pdfIsarModule.pathNameFile;  

  return _getWidgetLinkPdf(context, linkName, linkDescription, fnDelete, fnEdit,
      linkUrl: '', 
      pdfPathFileName: pdfPathFileName, 
      testoOcr: testoOcr,
      libroViewModel: libroViewModel);
}

Future<void> _fnView(BuildContext context, LibroIsarModel libroViewModel, String testoOcr) async {
    await Navigator.pushNamed(context, DettaglioTesto.pagePath, arguments: {
      'libroViewModel': libroViewModel,
      'testo': testoOcr
    });
}

Widget _getWidgetLinkPdf(BuildContext context, String linkName, String linkDescription,
    Function() fnDelete, Function()? fnEdit, {String linkUrl = '', String pdfPathFileName = '', String testoOcr = '', LibroIsarModel? libroViewModel}) {
  return Center(
    child: Card(
      elevation: 1,
      shadowColor: const Color.fromARGB(139, 48, 63, 159),
      surfaceTintColor: Colors.green.shade100, // : Colors.transparent,
        // color: (dbLibreriaService.libreriaInUso.nome == libreria.nome) ? Colors.cyan.shade800 : Colors.transparent,
      color: const Color.fromARGB(0, 119, 18, 18), // const Color.fromARGB(103, 0, 131, 143), // : const Color.fromARGB(0, 119, 18, 18),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            spacing: 0.9,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      if (fnEdit != null) {
                        fnEdit();
                      }
                    },
                    child: Text(
                      linkDescription.isEmpty
                        ? linkName
                        : "$linkName: $linkDescription",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlue.shade100,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => fnDelete(),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              )
            ],
          ),
          (linkUrl.isNotEmpty)
              ? _getPreviewLinkContainer(context, linkUrl)
              : _getPreviewPdfContainer(context, pdfPathFileName, fnEdit, testoOcr, libroViewModel),
          Divider(
            height: 5,
            thickness: 0.7,
            indent: 50,
            endIndent: 50,
            color: Colors.lime[100],
          )
        ],
      )
    ),
  );
}

Container _getPreviewPdfContainer(BuildContext context, String pdfPathFileName, Function()? fnEdit, String testoOcr, LibroIsarModel? libroViewModel) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.95,
    height: 130, // dimensione verticale fissa
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    // Utilizziamo Row per disporre gli elementi orizzontalmente
    child: Row(
      textDirection: TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topLeft,
            child: _getPdfPreviewWidget(context, pdfPathFileName),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.topCenter,
            child: _getPdfOcrPreviewWidget(context, fnEdit, testoOcr, libroViewModel),
          ),
        ),
      ],
    ),
  );
}

Widget _getPdfOcrPreviewWidget(BuildContext context, Function()? fnEdit, String testoOcr, LibroIsarModel? libroViewModel) {
  return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () {
      if (fnEdit != null) {
        _fnView(context, libroViewModel!, testoOcr);
      }
    },
    child: RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
          text: testoOcr,
          style: TextStyle(
              fontSize: 14,
              color: Colors.white // Colors.lightBlue.shade100,
            // fontWeight: FontWeight.bold
          )// TextStyle(color: Colors.lightGreen[100]), // decoration: TextDecoration.underline,),
      )
    ),
  );
}

Widget _getPdfPreviewWidget(BuildContext context, String pdfPathFileName) {
  return FutureBuilder<Uint8List?>(
    future: PdfUtils.getPdfThumbnail(pdfPathFileName.replaceAll("//", "/")),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.hasError || snapshot.data == null) {
        return const Text("Impossibile caricare l'anteprima.");
      }

      // Se i dati sono presenti, visualizza l'immagine
      return InkWell(
        splashColor: Colors.transparent,
        onDoubleTap: () {
          _openFilePDF(context, pdfPathFileName);
        },
        child: Image.memory(snapshot.data!, width: 90, height: 120, fit: BoxFit.fitHeight,)
      );
    },
  );
}

Container _getPreviewLinkContainer(BuildContext context, String linkUrl) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.95,
    height: 130, // dimensione verticale fissa
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    child: AnyLinkPreview(
        link: linkUrl.startsWith('http://') ? linkUrl.replaceFirst('http://', 'https://') : linkUrl, // "https://books.google.it/books?id=1z09EQAAQBAJ&printsec=frontcover&dq=intitle:Pippo&hl=&cd=2&source=gbs_api", // """https://www.arcane.com/it-it/", // linkUrl
        displayDirection: UIDirection.uiDirectionHorizontal,
        showMultimedia: true,
        bodyMaxLines: 5,
        bodyTextOverflow: TextOverflow.ellipsis,
        titleStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        // bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
        bodyStyle: TextStyle(color: Colors.grey[700], fontSize: 12),
        errorBody: 'Show my custom error body',
        errorTitle: 'Show my custom error title',
        errorWidget: Container(
          color: Colors.grey[300],
          child: Text('Oops!'),
        ),
        errorImage: "https://google.com/",
        cache: Duration(days: 7),
        // backgroundColor: Colors.grey[300],
        backgroundColor: Colors.blueGrey[100],
        borderRadius: 12,
        removeElevation: false,
        // userAgent: 'WhatsApp/2.21.12.21 A',
        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
        onTap: () => {
          _openUrl(linkUrl)
        }, // This disables tap event
        urlLaunchMode: LaunchMode.platformDefault
    ),
  );
}


Future<void> _openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}

Future<void> _openFilePDF(BuildContext context, pdfPathFileName) async {
  Map<Permission, PermissionStatus> statuses = await [Permission.manageExternalStorage].request();
  if (statuses[Permission.manageExternalStorage]!.isGranted) {
    if (context.mounted) {
      OpenFilex.open(pdfPathFileName);                                
    }
  } else {
    debugPrint('no permission provided');
  }
}

Widget getDescrizioneField(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  if (widget.libroViewModel.descrizione.isNotEmpty) {
    return _getDescrizioneEsistente(context, widget, fn);
  } 
  
  return _getDescrizioneDaDefinire(context, widget, fn);
}