import 'dart:io';

import 'package:books/config/constant.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/widgets/single_list_book.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

 
class LibreriaListaLibriWidget extends StatelessWidget {
  final BuildContext parentContext; 
  final LibroBloc libroBloc;
  final List<LibroViewModel> listaLibri;
  final Function fnViewDettaglioLibro;
  final Function fnDeleteLibro;
  final num nrTot;

  const LibreriaListaLibriWidget(
    this.parentContext, 
    this.libroBloc, 
    this.listaLibri, 
    this.fnViewDettaglioLibro, 
    this.fnDeleteLibro,
    {super.key}
  ) : nrTot = listaLibri.length;

  @override
  Widget build(BuildContext context) {    
    double bookWith = 75;
    double bookHeight = 110;
    double cardBookHeight = bookHeight + 5;

    Future<Widget>  getImage(String urlImage) async {
      late Widget image;
      File f = File(urlImage);

      if (f.existsSync()) {
        image = Image.file(File(urlImage), fit: BoxFit.fill);
      } else {
        if (urlImage.toLowerCase().startsWith("http")) {
          image = CachedNetworkImage(
            imageUrl: urlImage,
            // width: bookWith,
            // height: bookHeight,
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

    Future<Widget> getItemImage(int index, LibroViewModel item) async {
      return (item.immagineCopertina != '')
        ? await buildImage(index, item.immagineCopertina)
        : const Text('-');
    }

    return SafeArea(
      child: listaLibri.isEmpty
        ? Center(
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 20,),
                  SizedBox(
                    // height: 200,
                    height: (MediaQuery.of(context).size.height * 50 / 100),
                    child: Image.asset(Constant.assetImageDefault, fit: BoxFit.cover,)
                  ),
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                  ),
                ],
            ),
          )
        : SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: listaLibri.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = listaLibri[index];
                    return SingleListBook(
                      libroBloc, 
                      parentContext, 
                      fnViewDettaglioLibro, 
                      fnDeleteLibro, 
                      getItemImage, 
                      item, 
                      index, 
                      nrTot
                    );
                  },
                ),
              ),
            ]
          ),
        )
    );
  }

}
