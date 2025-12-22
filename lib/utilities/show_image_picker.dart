import 'dart:io';


// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ShowImagePickerUtil {
  final picker = ImagePicker();
  
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
    ).then((value){
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

  Future<void> _getImageFromCamera(Function fn) async {
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
    // String imagePath = join((await getApplicationSupportDirectory()).path,
    //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
      
    bool success = false;

    // OLD metodo con libreria "edge_detection: ^1.1.3"
    // try {
    //   //Make sure to await the call to detectEdge.
    //   success = await EdgeDetection.detectEdge(
    //     imagePath,
    //     canUseGallery: true,
    //     androidScanTitle: 'Scanning', // use custom localizations for android
    //     androidCropTitle: 'Crop',
    //     androidCropBlackWhiteTitle: 'Black White',
    //     androidCropReset: 'Reset',
    //   );
    //   debugPrint("success: $success");
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
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
      fn(File(scannedImages[0]));
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   if(success){
    //     _image.add(File(imagePath));
    //   }
    // });

    // fn(File(imagePath));
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
                            _getImageFromCamera(fn);
                            Navigator.pop(context);
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }

}

