import 'dart:io';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/utilities/show_image_picker.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/app_bar/app_bar_default.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class ImmagineCopertina extends StatefulWidget {
  static const String pagePath = '/detailImage';
  final LibroViewModel libroViewModel;
  // late final bool light;
  late final bool isImmaginePresent;

  ImmagineCopertina({Key? key, required this.libroViewModel}) : super(key: key) {
    isImmaginePresent = libroViewModel.immagineCopertina.isNotEmpty 
      && libroViewModel.immagineCopertina.contains('zoom=');
  }

  @override
  State<ImmagineCopertina> createState() => _ImmagineCopertinaState();
}

class _ImmagineCopertinaState extends State<ImmagineCopertina> {
  bool light = false; //widget.libroViewModel.immagineCopertina.contains('zoom=0');
  File? immagineCopertina;
  ShowImagePickerUtil showImagePickerUtil = ShowImagePickerUtil();

  reloadImage(File? imageFile) {
    if (imageFile != null) {
      setState(() {
        immagineCopertina = imageFile;
        widget.libroViewModel.immagineCopertina = imageFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    light = widget.libroViewModel.immagineCopertina.contains('zoom=0');

    return SafeArea(
      child: Scaffold(
        appBar: AppBarDefault(
          context: context,
          percHeight: 10,
          secondaryColor: const Color.fromARGB(115, 0, 143, 88),
          appBarContent: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(widget.libroViewModel.titolo)
                ),
                // const Padding(padding: EdgeInsets.only(bottom: 5)),
                Expanded(
                  flex: 1,
                  child: Text(widget.libroViewModel.lstAutori.join(', '), style: TextStyle(color: Colors.amber[300]))
                )
              ],
            ),
          ),
          lstIconButtonDx: [
            IconButton(
              icon: const Icon(Icons.image_search_sharp),
              onPressed: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.manageExternalStorage, Permission.camera,
                  ].request();
                  if(statuses[Permission.manageExternalStorage]!.isGranted && statuses[Permission.camera]!.isGranted) {
                    if (mounted) {
                      showImagePickerUtil.showImagePicker(context, reloadImage);
                    }
                  } else {
                    debugPrint('no permission provided');
                  }
                },
              color: Colors.greenAccent,
            )
          ]
        ),
        body: getWidgetImageCopertina(),
      ),
    );
  }
  
  Widget getWidgetImageCopertina() {
    bool isImageOk = widget.isImmaginePresent; // widget.libroViewModel.immagineCopertina.contains('zoom=0');
    double heightPerc = (isImageOk) ? 78 : 80;
    List<Widget> lstWidget = [getFutureImage(heightPerc)];

    if (isImageOk) {
      lstWidget.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Immagine migliore', 
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.amber[300]),
            textAlign: TextAlign.left,
          ),
          Switch(
            value: light,
            activeColor: Colors.lightBlueAccent,
            onChanged: (bool value) {
              setState(() {
                light = value;

                if (light) {
                  if (widget.libroViewModel.immagineCopertina.contains('zoom=1')) {
                    widget.libroViewModel.immagineCopertina = widget.libroViewModel.immagineCopertina.replaceFirst('zoom=1', 'zoom=0');
                  } else if (widget.libroViewModel.immagineCopertina.contains('zoom=5')) {
                    widget.libroViewModel.immagineCopertina = widget.libroViewModel.immagineCopertina.replaceFirst('zoom=5', 'zoom=0');
                  } 
                } else {
                  widget.libroViewModel.immagineCopertina = widget.libroViewModel.immagineCopertina.replaceFirst('zoom=0', 'zoom=5');
                }
              });
            },
          )
        ],
      ));
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lstWidget,
    );
  }

  Widget getFutureImage(double heightPerc) {
    return FutureBuilder<Image>(
      future: Utils.getImageFromUrlFile(
        widget.libroViewModel,
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
    );
  }

}
