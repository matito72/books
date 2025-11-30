import 'dart:io';


import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/features/libro/data/models/libro_isar.module.util.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';
import 'package:book/widgets/appbar/appbar_default.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';


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
    required this.isGallery
  });

  @override
  State<ImageToPdf> createState() => _ImageToPdf();
}

class _ImageToPdf extends State<ImageToPdf> {
  final TextEditingController _textCtrlAddSearch = TextEditingController();
  final _picker = ImagePicker();
  final List<File> _image = [];
  final _pdf = pw.Document();
  int _index = 0;
  
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

    // Generate filepath for saving
    // String imagePath = join((await getApplicationDocumentsDirectory()).path,
    //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
    // debugPrint("imagePath: >$imagePath<");

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
      : [_removeIconButton(), _createSavePDF(context)];
  }

  Widget _removeIconButton() {
    return IconButton(
      icon: const Icon(Icons.highlight_remove),
      onPressed: () {
        _removePDF();
      }
    );
  }

  Widget _createSavePDF(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.picture_as_pdf),
      onPressed: () async {
        String txt = await _createPDF(context);
        
        if (!context.mounted) {
          return;
        }

        PdfIsarModule? pdfFilePath = await _savePDF(context, txt);
        if (pdfFilePath != null) {
          widget.lstPdfIsarModule.add(pdfFilePath);
        }
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll<Color>(Color.fromARGB(184, 94, 243, 101)),
        iconColor: const WidgetStatePropertyAll<Color>(Color.fromARGB(176, 255, 28, 11)),
        iconSize: WidgetStateProperty.all(30.0),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Color.fromARGB(188, 104, 236, 104))
          )
        )
      )
    );
  }

  void _removePDF() {
    if (_image.isNotEmpty) {
      setState(() {
        _image.remove(_image[_index]);
        // _image.removeLast();
      });
    }
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

      final inputImage = InputImage.fromFile(img);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      String txt = recognizedText.text;
      text += txt + sep;
      sep = '----------------------------------------------------------------------------------------------------------------';
    }

    return text;
  }

  Future<PdfIsarModule?> _savePDF(BuildContext context, String txt) async {
    PdfIsarModule? pdfIsarModule;

    try {
      const String pathFolderDefault = '/storage/emulated/0/Download/';

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
              ),
            ),
          ),
          // FloatingActionButton(
          //   heroTag: "GALLERY",
          //   onPressed: () {
          //     _getImageFromGallery();
          //   },
          //   backgroundColor: Colors.transparent,
          //   child: const Icon(
          //     Icons.photo_album_rounded,
          //     color: Color.fromARGB(166, 255, 235, 59),
          //     size: 55,
          //   ),
          // ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.translucent,
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
            ),
          ),
          // FloatingActionButton(
          //   heroTag: "CAMERA",
          //   onPressed: () {
          //     _getImageFromCamera();
          //   },
          //   backgroundColor: Colors.transparent,
          //   child: Icon(
          //     MdiIcons.cameraPlus,
          //     color: const Color.fromARGB(183, 244, 67, 54),
          //     shadows: const [],
          //     size: 55
          //   ),
          // ),
        ],
      ),
    );
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
                ? ListView.builder(
                    itemCount: _image.length,
                    itemBuilder: (context, index) {
                      _index = index;
                      return InteractiveViewer(
                        panEnabled: true,
                        minScale: 1,
                        maxScale: 10,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 80 / 100,
                          width: MediaQuery.of(context).size.width * 100 / 100,
                          margin: const EdgeInsets.all(8),
                          child: Image.file(_image[index],fit: BoxFit.contain,)

                        ),
                      );
                      // return Container(
                      //   height: MediaQuery.of(context).size.height * 80 / 100,
                      //   width: MediaQuery.of(context).size.width * 100 / 100,
                      //   margin: const EdgeInsets.all(8),
                      //   child: Image.file(
                      //     _image[index],
                      //     fit: BoxFit.none,
                      //   ));
                    },
                  )
                : const Text(''),
            ),
              ],
        )
      ),
    );
  }

}