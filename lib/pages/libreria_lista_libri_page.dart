import 'package:books/config/constant.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/resources/row_item_image.dart';
import 'package:books/widgets/single_card_book.dart';
import 'package:flutter/material.dart';
 
class LibreriaListaLibriPage extends StatelessWidget {
  final BuildContext _parentContext; 
  final LibroBloc _libroBloc;
  final List<LibroViewModel> _listaLibri;
  final Function _fnViewDettaglioLibro;
  final Function _fnDeleteLibro;
  final num _nrTot;

  const LibreriaListaLibriPage(
    this._parentContext, 
    this._libroBloc, 
    this._listaLibri, 
    this._fnViewDettaglioLibro, 
    this._fnDeleteLibro,
    {super.key}
  ) : _nrTot = _listaLibri.length;

  @override
  Widget build(BuildContext context) {    
    
    // Future<Widget>  getImage(String urlImage) async {
    //   late Widget image;
    //   File f = File(urlImage);

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

    //   return image;
    // }
    
    // Future<ClipRRect> buildImage(int index, String urlImage) async => ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: await getImage(urlImage)
    // );

    // Future<Widget> getItemImage(int index, LibroViewModel item) async {
    //   return (item.immagineCopertina != '')
    //     ? await buildImage(index, item.immagineCopertina)
    //     : const Text('-');
    // }

    return SafeArea(
      child: _listaLibri.isEmpty
        ? Center(
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 20,),
                  SizedBox(
                    // height: 200,
                    height: (MediaQuery.of(context).size.height * 40 / 100),
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
                  itemCount: _listaLibri.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = _listaLibri[index];
                    return SingleCardBook(
                      _libroBloc, 
                      _parentContext, 
                      _fnViewDettaglioLibro, 
                      _fnDeleteLibro, 
                      getItemImage, 
                      item, 
                      index, 
                      _nrTot
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
