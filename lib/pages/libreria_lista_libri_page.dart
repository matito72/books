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
          image = Image.asset('assets/images/waiting.png',fit: BoxFit.fill);
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
                    child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,)
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
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.blueGrey,
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: SizedBox(
                        height: cardBookHeight-5,
                        child: InkWell(
                          splashColor: Colors.red,
                          onTap: () async {
                            fnViewDettaglioLibro(parentContext, libroBloc, item);
                          },
                          child: Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsetsDirectional.only(start: 5)
                              ),
                              SizedBox(
                                width: bookWith,
                                height: bookHeight,
                                child: FutureBuilder<Widget>(
                                  future: getItemImage(index, item),
                                  builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return snapshot.data as Widget;
                                    }
                                  }
                                )
                              ),
                              SizedBox(
                                width: (MediaQuery.of(context).size.width * 70 / 100),
                                height: cardBookHeight,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        // flex: 2,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
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
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                  '${index+1}/$nrTot',
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                  textAlign: TextAlign.right,
                                              ),
                                            )
                                          ]
                                        )
                                      ),
                                      Expanded(
                                        // flex: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                            MenuAnchor(
                                              alignmentOffset: Offset.fromDirection(-100.1, -200),
                                              style: const MenuStyle(
                                                // backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(225, 24, 134, 134)),
                                                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(224, 88, 136, 182)),
                                              ),
                                              clipBehavior: Clip.none,
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
                                                  trailingIcon: Text(
                                                    "Dettaglio/Modifica",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.amber[200],
                                                    ),
                                                  ),
                                                  onPressed: () => fnViewDettaglioLibro(parentContext, libroBloc, item),
                                                  child: Icon(Icons.edit, color: Colors.yellowAccent.shade100,),
                                                ),
                                                MenuItemButton(
                                                  trailingIcon: const Text(
                                                    "Elimina libro",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 235, 193, 180)
                                                    ),
                                                  ),
                                                  onPressed: () => fnDeleteLibro(parentContext, libroBloc, item),
                                                  child: Icon(Icons.delete, color: Colors.orange.shade800),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ]
                                  )
                                )
                              )
                            ]
                          ),
                        )
                      )
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
