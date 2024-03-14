import 'package:books/features/libro/data/models/pdf_isar.module.dart';
import 'package:books/widgets/dettaglio_libro/image_to_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createPreferredSize(context), // _createAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _createFloatingActionButton(context),
      body: widget._lstPdfIsarModule.isNotEmpty
          ? ListView.builder(
              itemCount: widget._lstPdfIsarModule.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(widget._lstPdfIsarModule[index].name),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue[400],
                        ),
                        onPressed: () async {
                          Map<Permission, PermissionStatus> statuses = await [Permission.manageExternalStorage].request();
                            if (statuses[Permission.manageExternalStorage]!.isGranted) {
                              if (mounted) {
                                OpenFilex.open(widget._lstPdfIsarModule[index].pathNameFile);                                
                              }
                            } else {
                              debugPrint('no permission provided');
                            }
                        },
                        child: Text(
                            widget._lstPdfIsarModule[index].pathNameFile,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.blue
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      )
                    ],
                  ),
                );
              },
            )
          : Center(
            child: Text(
              'Nessun PDF salvato',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.blue,
                fontSize: 24
              ),
            )),
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
              // child: Text(txtLabel),
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
            backgroundColor: const Color.fromARGB(166, 255, 235, 59),
            child: const Icon(
              Icons.photo_album_rounded,
              size: 45,
            ),
          ),
          const Spacer(),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              _goToImageToPdf(context, isCamera: true);
            },
            backgroundColor: const Color.fromARGB(183, 244, 67, 54),
            child: Icon(
              // Icons.photo_camera_rounded,
              MdiIcons.cameraPlus,
              size: 45
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
          icon: widget._lstPdfIsarModule.isEmpty ? const Icon(Icons.search) : const Icon(Icons.close),
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

