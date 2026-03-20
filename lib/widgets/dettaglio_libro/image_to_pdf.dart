import 'dart:io';


import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/libro_isar.module.util.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/widgets/appbar/appbar_default.dart';
import 'package:book/widgets/dettaglio_libro/pdf_creation_button.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;


class ImageToPdf extends StatefulWidget {
  static const String pagePath = '/imageToPdf';

  final LibroIsarModel libroViewModel;
  final List<PdfIsarModule> lstPdfIsarModule;
  final bool isCamera;
  final bool isGallery;

  const ImageToPdf({super.key,
    required this.libroViewModel,
    required this.lstPdfIsarModule,
    required this.isCamera,
    required this.isGallery,
  });

  @override
  State<ImageToPdf> createState() => _ImageToPdf();
}

class _ImageToPdf extends State<ImageToPdf> {
  final TextEditingController _textCtrlAddSearch = TextEditingController();
  final _picker = ImagePicker();
  final List<File> _image = [];
  final _pdf = pw.Document();
  // int _index = 0;
  bool _isCameraPlusAndImageAlbumVisible = true;

  @override
  void initState() {
    super.initState();

    if (widget.isCamera) {
      _getImageFromCamera();
    } else if (widget.isGallery) {
      _getImageFromGallery();
    }
  }

  @override
  void dispose() {
    _textCtrlAddSearch.dispose();
    super.dispose();
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        debugPrint('No image selected');
      }
    });
  }

  Future<void> _getImageFromCamera() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

    List<String> scannedImages = [];
    bool success = false;

    try {
      // Mostra l'interfaccia scanner e attende il risultato
      scannedImages = await CunningDocumentScanner.getPictures(
        iosScannerOptions: IosScannerOptions(
          imageFormat: IosImageFormat.jpg,
          jpgCompressionQuality: 0.9,
        ),
      ) ?? [];

      success = scannedImages.isNotEmpty;
      debugPrint("success: $success");
    } catch (e) {
      debugPrint(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (success && scannedImages.isNotEmpty) {
        for (String imagePath in scannedImages) {
          _image.add(File(imagePath));
        }
      }
    });
  }

  Widget _createTextAddSearchPDF(BuildContext context, TextEditingController textCtrlSearch) {
    return TextField(
      textCapitalization: TextCapitalization.words,
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
        hintText: 'Nome PDF',
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          color: Colors.black,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.close),
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

  List<Widget> _createListInconButton(BuildContext context) {
    return _image.isEmpty
      ? [const Text("")]
      // : [_removeIconButton(), _createSavePDF(context)];
      : [_createSavePDF(context)];
  }

  Widget _createSavePDF(BuildContext context) {
      // return PDFCreationButton(addPdfIsarModuleToLstPdfIsarModule: _addPdfIsarModuleToLstPdfIsarModule, createPDF: _createPDF, savePDF: _savePDF, showHiddenButton: _showHiddenButton);
    return PDFCreationButton(lstPdfIsarModule: widget.lstPdfIsarModule, createPDF: _createPDF, savePDF: _savePDF, showHiddenButton: _showHiddenButton, checkNomePdf: _checkNomePdf);
  }

  void _showHiddenButton(bool isVisible) {
    if (!mounted) return;
    setState(() {
      _isCameraPlusAndImageAlbumVisible = isVisible;
    });
  }

  bool _checkNomePdf(BuildContext context) {
    bool ok = true;

    if (_textCtrlAddSearch.text.trim().isEmpty) {
      ok = false;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Attenzione:"),
          content: const Text("Nessun 'Nome PDF' inserito."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }

    return ok;
  }

  Future<String> _createPDF(BuildContext context) async {
    String text = '';
    String sep = '';
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      _pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(1),
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }
      ));

      if (Platform.isAndroid || Platform.isIOS) {
        final inputImage = InputImage.fromFile(img);
        final textRecognizer = TextRecognizer(
            script: TextRecognitionScript.latin);
        final RecognizedText recognizedText = await textRecognizer.processImage(
            inputImage);
        String txt = recognizedText.text;
        text += txt + sep;
      } else {
        debugPrint("Il riconoscimento del testo non è supportato su Linux.");
      }
      sep = '----------------------------------------------------------------------------------------------------------------';
    }

    return text;
  }

  Future<PdfIsarModule?> _savePDF(BuildContext context, String txt) async {
    PdfIsarModule? pdfIsarModule;

    try {
      // final Directory appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
      // final String pathFolderRootDefault = p.join(appDocumentDir.path, Constant.books);
      // final String pathFolderDefault = p.join(pathFolderRootDefault, Constant.pdfFilesPath);
      const String appDownloadDir = '/storage/emulated/0/Download/';
      final String pathFolderRootDefault = p.join(appDownloadDir, Constant.books);
      final String pathFolderDefault = p.join(pathFolderRootDefault, Constant.pdfFilesPath);

      // Directory dirRoot = Directory(pathFolderRootDefault);
      // if (!await dirRoot.exists()) {
      //   await dirRoot.create();
      // }

      Directory dir = Directory(pathFolderDefault);
      if (! await dir.exists()) {
        await dir.create();
      }

      String pdfFileName = (_textCtrlAddSearch.text.trim() != '') ? _textCtrlAddSearch.text.trim() : 'pdfFileName';

      final file = File('$pathFolderDefault/${pdfFileName}_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}.pdf');
      File filePDF = await file.writeAsBytes(await _pdf.save());
      debugPrint('PDF salvato in ${file.path}');

      String pathNameFile = filePDF.absolute.path;
      pdfIsarModule = LibroIsarModuleUtil.createPdfIsarModule(pdfFileName, pathNameFile, testo: txt);
    } catch (e) {
      if (!context.mounted) {
        return pdfIsarModule;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: (Colors.red),
          content: Text('error: ${e.toString()}'),
          duration: const Duration(seconds: 5),
        ),
      );
    }

    return pdfIsarModule;
  }

  // GALLERY CAMERA - BUTTON
  Widget _createFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.translucent,
            child: Visibility(
                visible: _isCameraPlusAndImageAlbumVisible,
                maintainInteractivity: false,
                maintainState: false,
                maintainFocusability: false,
                maintainSize: false,
                maintainAnimation: false,
                child: FloatingActionButton(
                    heroTag: "btnImageAlbum",
                    onPressed: () {
                      _getImageFromGallery();
                    },
                    // backgroundColor: Colors.transparent,
                    backgroundColor: const Color.fromARGB(176, 0, 97, 100),
                    child: Icon(
                      MdiIcons.imageAlbum,
                      // color: const Color.fromARGB(183, 244, 67, 54),
                      color: Theme.of(context).colorScheme.onSecondary,
                      shadows: const [],
                      size: 55,
                    )
                )
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.translucent,
            child: Visibility(
                visible: _isCameraPlusAndImageAlbumVisible,
                maintainInteractivity: false,
                maintainState: false,
                maintainFocusability: false,
                maintainSize: false,
                maintainAnimation: false,
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    _getImageFromCamera();
                  },
                  // backgroundColor: Colors.transparent,
                  backgroundColor: const Color.fromARGB(176, 0, 97, 100),
                  child: Icon(
                    MdiIcons.cameraPlus,
                    // color: const Color.fromARGB(183, 244, 67, 54),
                    color: Theme.of(context).colorScheme.onSecondary,
                    shadows: const [],
                    size: 55,
                  ),
                )
            )
          ),
        ],
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final File item = _image.removeAt(oldIndex);
      _image.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarDefault(
          context: context,
          percHeight: 5,
          appBarContent: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.libroViewModel.titolo,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.libroViewModel.lstAutori.join(', '),
                  style: TextStyle(color: Colors.amber[300]),
                  overflow: TextOverflow.ellipsis,
                )
              )
            ],
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _createFloatingActionButton(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: _createTextAddSearchPDF(context, _textCtrlAddSearch),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _createListInconButton(context),
                ),
                const Text('')
              ]
            ),
            Expanded(
              flex: 3,
              child: _image.isNotEmpty
                  ? ReorderableListView.builder(
                onReorderItem: _onReorder,
                itemCount: _image.length,
                itemBuilder: (context, index) {
                  final file = _image[index];
                  // Utilizziamo un Key basato sul percorso del File (o un ID univoco se disponibile)
                  final key = ValueKey(file.path);

                  return Dismissible(
                    key: key, // Chiave univoca per Dismissible
                    direction: DismissDirection.endToStart,

                    // Funzione di eliminazione
                    onDismissed: (direction) {
                      setState(() {
                        _image.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Immagine rimossa')),
                      );
                    },

                    // Sfondo che appare durante lo swipe (opzionale)
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),

                    // Contenuto dell'elemento della lista
                    child: Container(
                      key: key, // Chiave univoca per ReorderableListView
                      // Altezza fissa per mantenere gli elementi compatti
                      height: 250.0,
                      width: MediaQuery.of(context).size.width * 1.0,
                      margin: const EdgeInsets.all(8),

                      // L'immagine stessa, che ora è l'unico contenuto del Container
                      child: Image.file(
                        file,
                        fit: BoxFit.contain, // O BoxFit.cover, a seconda del look desiderato
                      ),
                    ),
                  );
                },
              )
                  : const Text('Nessuna immagine selezionata'),
            ),
          ],
        )
      ),
    );
  }

}