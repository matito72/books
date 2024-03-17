import 'package:books/features/libro/data/models/link_isar.module.dart';
import 'package:books/features/libro/data/models/pdf_isar.module.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Widget _getDescrizioneEsistente(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        splashColor: Colors.transparent,
        onDoubleTap: () async {
          String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione);
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
      ExpandableText(
        widget.libroViewModel.descrizione,
        maxLines: 10,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        expandText: '>>',
        collapseText: '<<',
      ),
      // ReadMoreText.selectable(
      //   widget._libroViewModel.descrizione,
      //   numLines: 10,
      //   style: const TextStyle(
      //     fontSize: 14,
      //     color: Colors.white,
      //   ),
      //   readMoreTextStyle: TextStyle(color: Colors.blue.shade200,),
      //   readMoreIcon: Icon(Icons.more_horiz, color: Colors.blue.shade200),
      //   readLessIcon: Icon(Icons.keyboard_arrow_up, color: Colors.blue.shade200),
      //   readMoreText: '',
      //   readLessText: '',
      //   cursorColor: Colors.blue.shade200,
      //   cursorRadius: const Radius.circular(1),
      //   readMoreAlign: AlignmentDirectional.topEnd,
      // )
    ],
  );
}

Widget _getDescrizioneDaDefinire(BuildContext context, DettaglioLibroWidget widget, Function(String) fn) {
  return InkWell(
    splashColor: Colors.transparent,
    onDoubleTap: () async {
      String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione);
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
              String? strDesc = await DialogUtils.getDescrizione(context, 'Descrizione:', widget.libroViewModel.descrizione);
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

Widget getWidgetLink(BuildContext context, String? linkName, String? linkDescription, String? linkUrl, LinkIsarModule? linkIsarModule, Function() fnDelete, Function()? fnEdit) {
  bool isGoogleLinkPreview = (linkIsarModule == null);
  linkName = (linkName == null && linkIsarModule != null) ? linkIsarModule.name : linkName;
  linkDescription = (linkDescription == null && linkIsarModule != null) ? linkIsarModule.descrizione : linkDescription;
  linkUrl = (linkUrl == null && linkIsarModule != null) ? linkIsarModule.url : linkUrl;  
  
  if (linkUrl == null || linkUrl.isEmpty) {
    return const Text('');
  }

  return getWidgetLinkPdf(context, isGoogleLinkPreview, linkName!, linkDescription!, linkUrl: linkUrl, pdfPathFileName:'', fnDelete, fnEdit);
}

Widget getWidgetPdf(BuildContext context, PdfIsarModule pdfIsarModule, Function() fnDelete, Function()? fnEdit) {
  bool isGoogleLinkPreview = false;
  String linkName = pdfIsarModule.name;
  String linkDescription = pdfIsarModule.descrizione;
  String pdfPathFileName = pdfIsarModule.pathNameFile;  

  return getWidgetLinkPdf(context, isGoogleLinkPreview, linkName, linkDescription, linkUrl: '', pdfPathFileName: pdfPathFileName, fnDelete, fnEdit);
}

Widget getWidgetLinkPdf(BuildContext context, bool isGoogleLinkPreview, String linkName, String linkDescription, Function() fnDelete, Function()? fnEdit,
    {String linkUrl = '', String pdfPathFileName = ''}) {
  return Column(
    children: [
      const Padding(padding: EdgeInsets.only(top: 10)),
      Divider(
        height: 5,
        thickness: 1,
        indent: 5,
        endIndent: 5,
        color: Colors.orange[100],
      ),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Stack(
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width * 95 / 100),
            height: (MediaQuery.of(context).size.height * 15 / 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      linkName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.lightBlue.shade100,
                        fontWeight: FontWeight.bold
                      ),                                          
                    ),
                    SizedBox(
                      width: 25,
                      height: 20,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.topRight,
                        icon: Icon(
                          Icons.open_in_browser,
                          size: 20,
                          color: Colors.blue[400]
                        ),
                        onPressed: () => {
                          if (linkUrl.isNotEmpty) {
                            _openUrl(linkUrl)
                          } else {
                            _openFilePDF(context, pdfPathFileName)
                          }
                        },
                      ),
                    )
                  ],
                ),
                ExpandableText(
                  linkDescription.isNotEmpty ? linkDescription : '',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.lime[100],
                  ),
                  expandText: '>>',
                  collapseText: '<<',
                ),
                ExpandableText(
                  linkUrl.isNotEmpty ? linkUrl : pdfPathFileName,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  expandText: '>>',
                  collapseText: '<<',
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                !isGoogleLinkPreview
                  ? IconButton(
                      // iconSize: 20,
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.topRight,
                      icon: Icon(
                        size: 20,
                        Icons.edit,
                        color: Colors.yellowAccent[700]
                      ),
                      onPressed: () => {
                        if (fnEdit != null) {
                          fnEdit()
                        }
                      },
                    )
                  : const Text(''),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.topRight,
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.red[400],
                  ),
                  onPressed: () => {
                    fnDelete()
                  },
                )
              ],
            )
          )
        ],
      ),
    ],
  );
}

_openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}

_openFilePDF(BuildContext context, pdfPathFileName) async {
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