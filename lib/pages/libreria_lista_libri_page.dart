import 'dart:io';

import 'package:books/features/libro/blocs/libro_bloc.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
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

    return SafeArea(
      child: listaLibri.isEmpty
        ? Center(
          child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,)
                ),
                const Padding(
                  padding: EdgeInsets.all(40.0),
                ),
              ],
          ),
        )
        : ListView.builder(
            itemCount: listaLibri.length,

            itemBuilder: (context, index) {
              final item = listaLibri[index];
              return Column(
                children: [
                  const Divider(height: 5),
                  ListTile(
                    tileColor: const Color.fromARGB(47, 0, 131, 143), 
                    isThreeLine: false,
                    dense: false,
                    onTap: () async {
                      fnViewDettaglioLibro(parentContext, libroBloc, item);
                    },
                    leading: (item.immagineCopertina != '')
                        ? buildImage(index, item.immagineCopertina)
                        : const Text('-'),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: Text(
                            item.titolo,
                            style: item.titolo.length <= 50 
                            ? Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white) 
                            : item.titolo.length <= 100
                              ? Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)
                              : Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                            '${index+1}/$nrTot',
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.right,
                        )
                      ]
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            item.lstAutori.join(', '),
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.white70
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: MenuAnchor(
                      builder: (BuildContext context, MenuController controller, Widget? child) {
                      return IconButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: const Icon(Icons.more_vert),
                        tooltip: 'Show menu',
                      );
                    },
                    menuChildren: <MenuItemButton>[
                      MenuItemButton(
                        onPressed: () => fnViewDettaglioLibro(parentContext, libroBloc, item),
                        child: Icon(Icons.edit, color: Colors.yellowAccent.shade100,),
                      ),
                      MenuItemButton(
                        onPressed: () => fnDeleteLibro(parentContext, libroBloc, item),
                        child: Icon(Icons.delete, color: Colors.orange.shade800),
                      ),
                    ],
                  )
                  ),
                ],
              );
            },
          )
    );
  }

  Widget buildImage(int index, String urlImage) => ClipRRect(
    borderRadius: BorderRadius.circular(0),
    child: getImage(urlImage)
  );

  Widget getImage(String urlImage) {
    late Widget image;
    File f = File(urlImage);

    if (f.existsSync()) {
      image = Image.file(File(urlImage), fit: BoxFit.fill,);
    } else {
      image = CachedNetworkImage(
        imageUrl: urlImage,
        height: 120,
        width: 40,
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
    }

    return image;
  }

}
