import 'dart:io';
import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/utilities/show_image_picker.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/appbar/appbar_default.dart';
import 'package:books/widgets/list_cover_book.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


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
  ShowImagePickerUtil showImagePickerUtil = ShowImagePickerUtil();

  _updateWidget({File? imageFile, String? urlImage, bool? isMiSentoFortunato}) {
    if (imageFile != null) {
      setState(() {
        widget._libroViewModel.immagineCopertina = imageFile.path;
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

  _reloadImage(File? imageFile) {
    _updateWidget(imageFile: imageFile);
  }

  _selectImage(String urlImage) {
    _updateWidget(urlImage: urlImage);
  }

  @override
  Widget build(BuildContext context) {
    swMiSentoFortunato = widget._libroViewModel.immagineCopertina.contains('zoom=0');

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarDefault(
          context: context,
          percHeight: 7,
          // secondaryColor: const Color.fromARGB(115, 0, 143, 88),
          appBarContent: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget._libroViewModel.titolo,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget._libroViewModel.lstAutori.join(', '), 
                  style: TextStyle(color: Colors.amber[300]),
                  overflow: TextOverflow.ellipsis,
                )
              )
            ],
          ),
          lstWidgetDx: [getMenuBar(context)],
        ),
        body: _getWidgetImageCopertina(),
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
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.manageExternalStorage, Permission.camera,
                ].request();
                if(statuses[Permission.manageExternalStorage]!.isGranted && statuses[Permission.camera]!.isGranted) {
                  if (!context.mounted) return;
                    // _updateWidget(swithSearchPhone: true);
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
    double heightPerc = 75;
    
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 95 / 100),
        height: (MediaQuery.of(context).size.height * 95 / 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          // children: lstWidget,
          children: !swSearchWeb 
            ? (widget._isImmaginePresent && widget._libroViewModel.immagineCopertina.isNotEmpty) 
              ? [_getFutureImage(heightPerc), _widgetMiSentoFortunato()] 
              : [_getFutureImage(heightPerc)]
            : [_getGoogleSearchImage()],
        ),
      ),
    );
  }

  Widget _getGoogleSearchImage() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          // buildItemGoogleSearch("demo01", const Demo01())
          Container(
            width: (MediaQuery.of(context).size.width * 100 / 100),
            height: (MediaQuery.of(context).size.height * 85 / 100),
            padding: const EdgeInsets.all(1),
            child: Center(
              child: lstCoverBookUrl.isNotEmpty
                ? ListCoverBook(lstCoverBookUrl: lstCoverBookUrl, fn: _selectImage)
                : FutureBuilder<List<String>>(
                  future: Utils.simpleGoogleCoverBookSearch(widget._libroViewModel, 20),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.data != null) {
                        lstCoverBookUrl = snapshot.data!;
                        return ListCoverBook(lstCoverBookUrl: lstCoverBookUrl, fn: _selectImage);
                      }
                      return const Text("...");
                    }
                  }
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
          activeColor: Colors.lightBlueAccent,
          onChanged: (bool value) {
            _updateWidget(isMiSentoFortunato: value);
          },
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
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 1,
              maxScale: 5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * heightPerc/100,
                child: snapshot.data!
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
