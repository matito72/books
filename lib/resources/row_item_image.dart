import 'dart:io';

import 'package:book/config/constant.dart';
import 'package:book/features/libro/data/models/libro_isar.module.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Future<Widget>  getImage(String urlImage) async {
//   late Widget image;
//   File f = File(urlImage);
//
//   if (f.existsSync()) {
//     image = Image.file(File(urlImage), fit: BoxFit.fill);
//   } else {
//     if (urlImage.toLowerCase().startsWith("http")) {
//       image = CachedNetworkImage(
//         imageUrl: urlImage,
//         fit: BoxFit.cover,
//         placeholder: (context, url) => const CircularProgressIndicator(),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//         cacheManager: CacheManager(
//           Config(
//             "googleBooks",
//             stalePeriod: const Duration(days: 30),
//           )
//         )
//       );
//     } else {
//       image = Image.asset(Constant.assetImageDefault, fit: BoxFit.fill);
//     }
//   }
//
//   return image;
// }

Widget getImage(String urlImage) {
  // Definiamo una dimensione massima per la cache in pixel (es. 200px di larghezza)
  // Questo riduce il consumo di RAM di circa l'80-90% per le foto scattate da disco.
  const int cacheMaxWidth = 250;

  if (urlImage.isEmpty) {
    return Image.asset(Constant.assetImageDefault, fit: BoxFit.cover);
  }

  File f = File(urlImage);

  if (f.existsSync()) {
    return Image.file(
      f,
      fit: BoxFit.cover,
      cacheWidth: cacheMaxWidth, // OTTIMIZZAZIONE CHIAVE
      errorBuilder: (ctx, _, __) => Image.asset(Constant.assetImageDefault),
    );
  } else if (urlImage.toLowerCase().startsWith("http")) {
    urlImage = urlImage.replaceFirst("http:", "https:");
    return CachedNetworkImage(
      imageUrl: urlImage,
      fit: BoxFit.cover,
      maxWidthDiskCache: cacheMaxWidth, // Ottimizza lo spazio su disco
      memCacheWidth: cacheMaxWidth,     // Ottimizza l'uso della RAM
      placeholder: (context, url) => const Center(
          child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      // Usa il cacheManager di default o uno statico, non crearne uno nuovo ogni volta
    );
  } else {
    return Image.asset(Constant.assetImageDefault, fit: BoxFit.cover);
  }
}

ClipRRect buildImage(int index, String urlImage) => ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: getImage(urlImage)
);

Widget getItemImage(int index, LibroIsarModel item) {
  return (item.immagineCopertina != '')
    ? buildImage(index, item.immagineCopertina)
    : const Text('-');
}