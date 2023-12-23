import 'dart:io';
import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/utilities/show_image_picker.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/appbar/appbar_default.dart';
import 'package:books/widgets/list_cover_book.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class ImmagineCopertina extends StatefulWidget {
  static const String pagePath = '/detailImage';
  final LibroViewModel _libroViewModel;
  // late final bool light;
  late final bool _isImmaginePresent;

  ImmagineCopertina({super.key, required LibroViewModel libroViewModel}) : _libroViewModel = libroViewModel {
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
        // immagineCopertina = imageFile;
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
          // if (widget.libroViewModel.pathImmagineCopertina != null && widget.libroViewModel.pathImmagineCopertina!.trim().isNotEmpty) {
          //   widget.libroViewModel.immagineCopertina = widget.libroViewModel.pathImmagineCopertina!;
          // } else {
          //   widget.libroViewModel.immagineCopertina = widget.libroViewModel.immagineCopertina.replaceFirst('zoom=0', 'zoom=5');
          // }
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
        appBar: AppBarDefault(
          context: context,
          percHeight: 7,
          secondaryColor: const Color.fromARGB(115, 0, 143, 88),
          appBarContent: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(widget._libroViewModel.titolo)
                ),
                Expanded(
                  flex: 1,
                  child: Text(widget._libroViewModel.lstAutori.join(', '), style: TextStyle(color: Colors.amber[300]))
                )
              ],
            ),
          ),
          lstWidgetDx: [
            _getSwithSearchPhoneWeb(),
            // swSearchWeb ? _getIconSearchImageFromWeb() : _getIconSearchImageFromPhone()
            swSearchWeb 
            ? const SizedBox(
                width: 50,
                height: 20,
               child: Text(' ')
              ) 
            : _getIconSearchImageFromPhone()
          ]
        ),
        body: _getWidgetImageCopertina(),
      ),
    );
  }

  Widget _getSwithSearchPhoneWeb() {
    return Switch(
      value: swSearchWeb,
      trackColor: MaterialStateProperty.all(Colors.black38),
      activeColor: Colors.greenAccent[400],
      inactiveThumbColor: Colors.yellowAccent[700],
      // when the switch is on, this image will be displayed
      // activeThumbImage: const AssetImage('assets/happy_emoji.png'),
      activeThumbImage: const AssetImage('assets/images/searchWeb.png'),
      // when the switch is off, this image will be displayed
      inactiveThumbImage: const AssetImage('assets/images/searchPhotoLibrary.png'),
      onChanged: (value) => setState(
        () => swSearchWeb = value
      )
    );
  }

  Widget _getIconSearchImageFromPhone() {
    return IconButton(
      icon: Icon(MdiIcons.imageSearch),
      onPressed: () async {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.manageExternalStorage, Permission.camera,
        ].request();
        if(statuses[Permission.manageExternalStorage]!.isGranted && statuses[Permission.camera]!.isGranted) {
          if (mounted) {
            // _updateWidget(swithSearchPhone: true);
            showImagePickerUtil.showImagePicker(context, _reloadImage);
          }
        } else {
          debugPrint('no permission provided');
        }
      },
      color: Colors.yellowAccent[700],
    );
  }

  // Widget _getIconSearchImageFromWeb() {
  //   return IconButton(
  //     icon: Icon(MdiIcons.web),
  //     onPressed: () => {}, // _updateWidget(swithSearchWeb: true), 
  //     color: Colors.greenAccent[400],
  //   );
  // }
  
  Widget _getWidgetImageCopertina() {
    // bool isImageOk = widget.isImmaginePresent; 
    double heightPerc = 80; // (widget.isImmaginePresent) ? 80 : 80;
    // List<Widget> lstWidget = [_getFutureImage(heightPerc)];

    // if (isImageOk) {
    //   lstWidget.add(
    //     _widgetMiSentoFortunato()
    //   );
    // }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // children: lstWidget,
      children: !swSearchWeb 
        ? widget._isImmaginePresent ? [_getFutureImage(heightPerc), _widgetMiSentoFortunato()] : [_getFutureImage(heightPerc)]
        : [_getGoogleSearchImage()],
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return InteractiveViewer(
            panEnabled: true,
            minScale: 1,
            maxScale: 5,
            child: snapshot.data!,
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
