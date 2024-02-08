import 'dart:io';

import 'package:books/config/constant.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<Widget>  getImage(String urlImage) async {
  late Widget image;
  File f = File(urlImage);

  if (f.existsSync()) {
    image = Image.file(File(urlImage), fit: BoxFit.fill);
  } else {
    if (urlImage.toLowerCase().startsWith("http")) {
      image = CachedNetworkImage(
        imageUrl: urlImage,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        cacheManager: CacheManager(
          Config(
            "googleBooks",
            stalePeriod: const Duration(days: 30),
          )
        )
      );
    } else {
      image = Image.asset(Constant.assetImageDefault, fit: BoxFit.fill);
    }
  }

  return image;
}

Future<ClipRRect> buildImage(int index, String urlImage) async => ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: await getImage(urlImage)
);

Future<Widget> getItemImage(int index, LibroIsarModel item) async {
  return (item.immagineCopertina != '')
    ? await buildImage(index, item.immagineCopertina)
    : const Text('-');
}