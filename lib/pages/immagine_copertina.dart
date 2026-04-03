import 'dart:io';

import 'package:book/config/com_area.dart';
import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:book/utilities/dialog_utils.dart';
import 'package:book/utilities/show_image_picker.dart';
import 'package:book/utilities/utils.dart';
import 'package:book/widgets/appbar/appbar_default.dart';
import 'package:book/widgets/list_cover_book.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:book/widgets/appbar/desktop_bar.dart';


class ImmagineCopertina extends StatefulWidget {
  static const String pagePath = '/detailImage';
  final LibroIsarModel _libroViewModel;
  // late final bool light;
  late final bool _isImmaginePresent;

  ImmagineCopertina({super.key, required LibroIsarModel libroViewModel}) : _libroViewModel = libroViewModel {
    _libroViewModel.pathImmagineCopertina ??= _libroViewModel.immagineCopertina;

    _isImmaginePresent = _libroViewModel.immagineCopertina.isNotEmpty 
      && _libroViewModel.immagineCopertina.contains('zoom=');
  }

  @override
  State<ImmagineCopertina> createState() => _ImmagineCopertinaState();
}

class _ImmagineCopertinaState extends State<ImmagineCopertina> {
  // INIT:
  String immagineCopertinaBackup = '';
  List<String> lstCoverBookUrl = [];
  bool swMiSentoFortunato = false;
  bool swSearchWeb = false;
  // File? immagineCopertina;
  late ShowImagePickerUtil showImagePickerUtil; // = ShowImagePickerUtil(widget._libroViewModel.isbn);

  @override
  void initState() {
    super.initState();
    showImagePickerUtil = ShowImagePickerUtil(widget._libroViewModel.isbn);
  }

  void _updateWidget({File? imageFile, String? urlImage, bool? isMiSentoFortunato}) {
    if (imageFile != null) {
      setState(() {
        widget._libroViewModel.immagineCopertina = imageFile.path;
        FileImage(File(imageFile.path)).evict();
      });
    } else if (urlImage != null) {
      setState(() {
        swSearchWeb = false;
        if (urlImage.isNotEmpty) {
          widget._libroViewModel.immagineCopertina = urlImage;
        }
      });
    } else if (isMiSentoFortunato != null) {
      setState(() {
        swMiSentoFortunato = isMiSentoFortunato;

        if (swMiSentoFortunato) {
          immagineCopertinaBackup = widget._libroViewModel.immagineCopertina;

          if (widget._libroViewModel.immagineCopertina.contains('zoom=1')) {
            widget._libroViewModel.immagineCopertina = widget._libroViewModel.immagineCopertina.replaceFirst('zoom=1', 'zoom=0');
          } else if (widget._libroViewModel.immagineCopertina.contains('zoom=5')) {
            widget._libroViewModel.immagineCopertina = widget._libroViewModel.immagineCopertina.replaceFirst('zoom=5', 'zoom=0');
          } else if (widget._libroViewModel.pathImmagineCopertina != null && widget._libroViewModel.pathImmagineCopertina!.trim().isNotEmpty) {
            if (widget._libroViewModel.pathImmagineCopertina!.contains('zoom=1')) {
              widget._libroViewModel.immagineCopertina = widget._libroViewModel.pathImmagineCopertina!.replaceFirst('zoom=1', 'zoom=0');
            } else if (widget._libroViewModel.pathImmagineCopertina!.contains('zoom=5')) {
              widget._libroViewModel.immagineCopertina = widget._libroViewModel.pathImmagineCopertina!.replaceFirst('zoom=5', 'zoom=0');
            }
          } 
        } else {
          if (immagineCopertinaBackup.trim().isNotEmpty) {
            widget._libroViewModel.immagineCopertina = immagineCopertinaBackup.replaceFirst('zoom=0', 'zoom=5');
          } else {
            widget._libroViewModel.immagineCopertina = widget._libroViewModel.immagineCopertina.replaceFirst('zoom=0', 'zoom=5');
          }
        }
      });
    }
  }

  void _reloadImage(File? imageFile) {
    _updateWidget(imageFile: imageFile);
  }

  void _selectImage(String urlImage) {
    _updateWidget(urlImage: urlImage);
  }

  @override
  Widget build(BuildContext context) {
    swMiSentoFortunato = widget._libroViewModel.immagineCopertina.contains('zoom=0');
    DesktopBar desktopBar = DesktopBar();

    return SafeArea(
      child: Column(
        children: [
          // 1. La barra superiore trascinabile (fissa in alto)
          desktopBar.gestureDetector,

          // 2. Il resto dell'interfaccia che occupa lo spazio rimanente
          Expanded(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBarDefault(
                context: context,
                percHeight: 7,
                appBarContent: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        Utils.rimuoviAccapo(widget._libroViewModel.titolo),
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        Utils.rimuoviAccapo(widget._libroViewModel.lstAutori.join(', ')),
                        style: TextStyle(color: Colors.amber[300]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                lstWidgetDx: [getMenuBar(context)],
              ),
              body: _getWidgetImageCopertina(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getMenuBar(BuildContext context) {
    return MenuBar(
      children: <Widget>[
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () {
                setState(() {
                  swSearchWeb = !swSearchWeb;
                });
              },
              leadingIcon: Icon(MdiIcons.imageSearch),
              child: !swSearchWeb 
                ? const MenuAcceleratorLabel('Cerca nel Web')
                : const MenuAcceleratorLabel('Ripristina Immagine'),
            ),
            MenuItemButton(
              onPressed: () async {
                swSearchWeb = false;
                if (await Utils.hasPlatformPermissions()) {
                  if (!context.mounted) return;
                    showImagePickerUtil.showImagePicker(context, _reloadImage);
                } else {
                  debugPrint('no permission provided');
                }
              },
              leadingIcon: const Icon(Icons.photo_camera),
              child: const MenuAcceleratorLabel('Foto/Cerca nel telefono'),
            ),
            MenuItemButton(
              onPressed: () async {
                String? newUrl = await DialogUtils.getDescrizione(context, 'URL', '', maxLines: 1);
                setState(() {
                  if (newUrl != null) {
                    widget._libroViewModel.immagineCopertina = newUrl;
                  }
                });
              },
              leadingIcon: const Icon(Icons.link),
              child: const MenuAcceleratorLabel('Aggiungi collegamento immagine'),
            ),
            MenuItemButton(
              onPressed: () {
                setState(() {
                  widget._libroViewModel.immagineCopertina = '';
                  // widget._isImmaginePresent = false;
                });
              },
              leadingIcon: const Icon(Icons.delete),
              child: const MenuAcceleratorLabel('Cancella immagine'),
            )
          ],
          child: const MenuAcceleratorLabel('Modifica'),
        ),
      ],
    );
  }

  Widget _getWidgetImageCopertina() {
    return Center( // 1. Centra tutto il blocco orizzontalmente
      child: ConstrainedBox(
        // 2. Imposta un limite di larghezza massima solo per il desktop
        constraints: BoxConstraints(
          maxWidth: ComArea.isMobileApp ? double.infinity : 800.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InteractiveViewer(
                minScale: 0.1,
                maxScale: 4.0,
                clipBehavior: Clip.none,
                child: Center(
                  child: !swSearchWeb
                      ? (widget._isImmaginePresent && widget._libroViewModel.immagineCopertina.isNotEmpty)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _getFutureImage(75),
                      _widgetMiSentoFortunato(),
                    ],
                  )
                      : _getFutureImage(75)
                      : _getGoogleSearchImage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGoogleSearchImage() {
    bool isNarrow = ComArea.isMobileApp || MediaQuery.of(context).size.width < 900;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width * 100 / 100),
            height: (MediaQuery.of(context).size.height * 85 / 100),
            padding: isNarrow ? const EdgeInsets.all(1) : EdgeInsets.symmetric(horizontal: 350),
            child: Center(
              child: lstCoverBookUrl.isNotEmpty
                ? ListCoverBook(lstCoverBookUrl: lstCoverBookUrl, fn: _selectImage)
                : FutureBuilder<List<String>>(
                  future: Utils.simpleGoogleCoverBookSearch(widget._libroViewModel, 20),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    // 1. Stato di caricamento
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // 2. Errore o Dati nulli/vuoti
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "Nessuna copertina trovata",
                          style: Theme.of(context).textTheme.headlineMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }

                    // 3. Controllo specifico per la libreria Gallery3D (minimo 3 elementi)
                    if (snapshot.data!.length < 3) {
                      // Puoi decidere di mostrarle comunque in una ListView normale
                      // o dare un messaggio di errore.
                      return Center(
                        child: Text(
                          "Risultati non sufficienti",
                          style: Theme.of(context).textTheme.headlineMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }

                    // 4. Se tutto è OK, salviamo e mostriamo
                    lstCoverBookUrl = snapshot.data!;

                    // Usiamo Flexible o un Container con altezza definita per evitare l'overflow
                    return ListCoverBook(lstCoverBookUrl: lstCoverBookUrl, fn: _selectImage);
                  },
                )
              // child: ListCoverBook()
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetMiSentoFortunato() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Mi sento fortunato', 
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.amber[300]),
          textAlign: TextAlign.left,
        ),
        Switch(
          value: swMiSentoFortunato,
          activeThumbColor: Colors.lightBlueAccent,
          onChanged: (bool value) {
            _updateWidget(isMiSentoFortunato: value);
          },
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        )
      ],
    );
  }

  Widget _getFutureImage(double heightPerc) {
    return widget._libroViewModel.immagineCopertina.isNotEmpty
      ? FutureBuilder<Image>(
        future: Utils.getImageFromUrlFile(
          widget._libroViewModel,
          w: MediaQuery.of(context).size.width,
          h: MediaQuery.of(context).size.height * heightPerc/100
        ),
        builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.symmetric(vertical: 0.5),
              minScale: 1,
              maxScale: 5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * heightPerc/100,
                key: ValueKey(DateTime.now().millisecondsSinceEpoch.toString()),
                child: snapshot.data!,
              ),
            );
          }
        }
      )
      : Center(
        heightFactor: 0.8,
        child: SizedBox(
          // height: 200,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(Constant.assetImageDefault, fit: BoxFit.none)
        ),
    );
  }

}
