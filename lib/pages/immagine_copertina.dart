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

  const ImmagineCopertina({Key? key, required this.libroViewModel}) : super(key: key);

  @override
  State<ImmagineCopertina> createState() => _ImmagineCopertinaState();
}

class _ImmagineCopertinaState extends State<ImmagineCopertina> {
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
    // final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    // final LibroViewModel libroViewModel = arguments['libroViewModel'];

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey.shade400,
        appBar: AppBarDefault(
          context: context,
          percHeight: 7,
          secondaryColor: const Color.fromARGB(115, 0, 143, 88),
          // txtLabel: libroViewModel.titolo,
          appBarContent: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.libroViewModel.titolo),
              Text(widget.libroViewModel.lstAutori.join(', '), style: TextStyle(color: Colors.amber[300]))
            ],
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
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GridTile(
              // child: (immagineCopertina == null) 
              //   ? Image.network(
              //       widget.libroViewModel.immagineCopertina,
              //       fit: BoxFit.fill,
              //     )
              //   : Image.file(immagineCopertina!, fit: BoxFit.fill,)
              child: Utils.getImageFromUrlFile(widget.libroViewModel)
            ),
          ),
        ),
      ),
    );
  }
  
}
