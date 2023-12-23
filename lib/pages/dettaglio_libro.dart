import 'package:books/features/libro/data/models/libro_dettaglio_result.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/appbar/appbar_default.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_web_view.dart';
import 'package:books/widgets/dettaglio_libro/dettaglio_libro_widget.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';


class DettaglioLibro extends StatefulWidget {
  static const String pagePath = '/HomeLibriLibreria/detailBook';
  static const String pageEditPath = '/LibreriaListaLibriPage/detailBook';

  final LibroViewModel libroViewModel;
  final bool showDelete;

  const DettaglioLibro({super.key, required this.libroViewModel, required this.showDelete});

  @override
  State<DettaglioLibro> createState() => _DettaglioLibro();
}

class _DettaglioLibro extends State<DettaglioLibro> {

  @override
  Widget build(BuildContext context) {
    LibroViewModel libroViewModel = widget.libroViewModel;

    returnToScreen(bool isDelete) async {
      bool? isRemoveBook = false;
      if (isDelete) {
        isRemoveBook = await DialogUtils.showConfirmationSiNo(context, 'Vuoi rimuovere il libro dalla lista ?');
      }
      if (mounted) {
        Navigator.pop(context, LibroDettaglioResult(libroViewModel, !isDelete, isDelete && (isRemoveBook != null && isRemoveBook))); 
      }
    }

    IconButton iconCheckAddLibro = IconButton(
      icon: const Icon(Icons.check),
      onPressed: () => returnToScreen(false),
      color: Colors.greenAccent,
    );

    IconButton iconDeleteLibro = IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => returnToScreen(true),
      color: Colors.orangeAccent,
    );

    TabBar tabBar = const TabBar(
      isScrollable: false,
      labelColor: Colors.yellow,
      indicatorPadding: EdgeInsets.zero,
      automaticIndicatorColorAdjustment: true,
      tabs: [
        Tab(text: 'Dettaglio',),
        Tab(text: 'Note',),
        Tab(text: 'Preview',),
      ],
    );
    
    return SafeArea(
        child: Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBarDefault(
                context: context,
                percHeight: 4,
                secondaryColor: const Color.fromARGB(115, 0, 143, 88),
                txtLabel: libroViewModel.titolo,
                lstWidgetDx: widget.showDelete
                  ? [ iconDeleteLibro, iconCheckAddLibro ]
                  : [ iconCheckAddLibro ]
              ),
              body: Column(
                children: [
                  PreferredSize(
                    // preferredSize: tabBar.preferredSize,
                    preferredSize: Size.fromHeight((MediaQuery.of(context).size.height * 4 / 100)),
                    child: Material(
                      color: const Color.fromARGB(115, 0, 143, 88),
                      child: tabBar,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      viewportFraction: 1,
                      children: [
                        DettaglioLibroWidget(libroViewModel, !widget.showDelete),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(top: 20),
                              child: Text(
                                'Note ... \n\n${libroViewModel.titolo} ...\n\n ${libroViewModel.previewLink}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ]
                        ),
                        Zoom(
                          maxZoomWidth: 1200,
                          maxZoomHeight: 1800,
                          canvasColor: Colors.grey,
                          backgroundColor: Colors.orange,
                          colorScrollBars: const Color.fromARGB(151, 39, 114, 176),
                          opacityScrollBars: 0.9,
                          scrollWeight: 10.0,
                          centerOnScale: true,
                          enableScroll: true,
                          doubleTapZoom: true,
                          zoomSensibility: 0.8,
                          initTotalZoomOut: false,
                          child: Center(
                              child: DettaglioLibroWebView(libroViewModel.previewLink)
                              // #v=onepage&q=isbn=${libroViewModel.isbn}&f=true
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),  
        )
    );
  }
}