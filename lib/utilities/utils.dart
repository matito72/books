

import 'dart:io';

import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:flutter/widgets.dart';

class Utils {

  static Widget getImageFromUrlFile(LibroViewModel libroViewModel) {
    late Widget image;
    
    File f = File(libroViewModel.immagineCopertina);
    if (f.existsSync()) {
      image = Image.file(File(libroViewModel.immagineCopertina), fit: BoxFit.fill,);
    } else {
      image = Image.network(libroViewModel.immagineCopertina, fit: BoxFit.fill);
    }

    return image;
  }
  
}