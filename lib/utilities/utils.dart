

import 'dart:io';

import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:flutter/widgets.dart';

class Utils {

  static Widget getImageFromUrlFile(LibroViewModel libroViewModel) {
    late Widget image;

    if (libroViewModel.immagineCopertina.isNotEmpty) {
      File f = File(libroViewModel.immagineCopertina);
      if (f.existsSync()) {
        image = Image.file(File(libroViewModel.immagineCopertina), fit: BoxFit.fill,);
      } else {
        if (libroViewModel.immagineCopertina.toLowerCase().startsWith("http")) {
          image = Image.network(libroViewModel.immagineCopertina, fit: BoxFit.fill);
        } else {
          image = Image.asset('assets/images/waiting.png',fit: BoxFit.fill);    
        }
      }
    } else {
      image = Image.asset('assets/images/waiting.png',fit: BoxFit.fill);
    }

    return image;
  }
  
}