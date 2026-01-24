import 'dart:io';

import 'package:book/config/com_area.dart';
import 'package:book/config/constant.dart';
import 'package:book/utilities/utils.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowImagePickerUtil {
  final picker = ImagePicker();
  final String isbn;
  final String folderImage;
  final String folderLibInUsoCompatto;

  factory ShowImagePickerUtil(String isbn) {
    String root = p.join(ComArea.appDocumentDir.path, Constant.books);
    String folderImage = p.join(root, Constant.imageFilesPath);

    String nomeLibInUsoCompatto = Utils.stringConcat(ComArea.libreriaInUso!.nome);
    String folderLibInUsoCompatto = p.join(folderImage, nomeLibInUsoCompatto);

    return ShowImagePickerUtil._internal(isbn, folderImage, folderLibInUsoCompatto);
  }

  // Costruttore privato
  ShowImagePickerUtil._internal(this.isbn, this.folderImage, this.folderLibInUsoCompatto);
  
  Future<void> _cropImage(File imgFile, Function fn) async {
    CroppedFile? croppedFile;
    if (Platform.isAndroid || Platform.isIOS) {
      croppedFile = await ImageCropper().cropImage(
          sourcePath: imgFile.path,
          uiSettings: [AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
            IOSUiSettings(
              title: "Image Cropper",
            )
          ]
      );
    } else {
      croppedFile = CroppedFile(imgFile.path);
    }

    if (croppedFile != null) {
      imageCache.clear();
      // setState(() {
        // imageFile = File(croppedFile.path);
      // });
      // reload();
      fn(File(croppedFile.path));
    }
  }

  Future<void> _imgFromGallery(Function fn) async {
    await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value) {
      if (value != null){
        _cropImage(File(value.path), fn);
      }
    });
  }

  // _imgFromCamera(Function fn) async {
  //   await picker.pickImage(source: ImageSource.camera, imageQuality: 50
  //   ).then((value){
  //     if (value != null) {
  //       _cropImage(File(value.path), fn);
  //     }
  //   });
  // }

  Future<void> _initDirectory() async {
    Directory dirRoot = Directory(p.join(ComArea.appDocumentDir.path, Constant.books));
    if (!await dirRoot.exists()) {
      await dirRoot.create();
    }

    Directory dirImage = Directory(folderImage);
    if (!await dirImage.exists()) {
      await dirImage.create();
    }

    Directory dirLibInUsoCompatto = Directory(folderLibInUsoCompatto);
    if (!await dirLibInUsoCompatto.exists()) {
      await dirLibInUsoCompatto.create();
    }
  }

  Future<File?> _getImageFromCamera() async {  // Function fn
    await _initDirectory();
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }
    if (!isCameraGranted) {
      // Have not permission to camera
      return null;
    }
      
    bool success = false;
    List<String> scannedImages = [];
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

    if (success && scannedImages.isNotEmpty) {
      File fileImage = File(scannedImages[0]);
      String fileNamePhoto = basename(fileImage.path);

      String nomeFileDestinazione = this.isbn.isNotEmpty ? '${this.isbn}.jpg' : fileNamePhoto;
      bool okCopy = await Utils.copyFile(pathSorgenteCompleto: fileImage.path, pathFolderDestinazione: folderLibInUsoCompatto, nomeFileDestinazione: nomeFileDestinazione);
      if (okCopy) {
        await fileImage.delete();
        fileImage = File('$folderLibInUsoCompatto/$nomeFileDestinazione');
        // fn(fileImage);
      }
      // image.copy(newPath)
      // fn(fileImage);
      return fileImage;
    }

    return null;
  }

  void showImagePicker(BuildContext context, Function fn) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          child: const Column(
                            children: [
                              Icon(Icons.image, size: 60.0,),
                              SizedBox(height: 12.0),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                          onTap: () {
                            _imgFromGallery(fn);
                            Navigator.pop(context);
                          },
                        )),
                    Expanded(
                        child: InkWell(
                          child: const SizedBox(
                            child: Column(
                              children: [
                                Icon(Icons.camera_alt, size: 60.0,),
                                SizedBox(height: 12.0),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            // _imgFromCamera(fn);
                            File? fileImage = await _getImageFromCamera();
                            if (fileImage != null) {
                              fn(fileImage);
                            }
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }

}

