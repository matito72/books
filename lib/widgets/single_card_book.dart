import 'package:books/config/constant.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:flutter/material.dart';

class SingleCardBook extends StatelessWidget {
  
  final LibroBloc _libroBloc;
  final BuildContext _parentContext; 
  final Function _fnViewDettaglioLibro;
  final Function _fnDeleteLibro;
  final Function _fnGetItemImage;
  final LibroViewModel _item;
  final int _index;
  final num nrTot;

  const SingleCardBook(
    this._libroBloc,
    this._parentContext,
    this._fnViewDettaglioLibro, 
    this._fnDeleteLibro,
    this._fnGetItemImage,
    this._item,
    this._index,
    this.nrTot,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    double bookWith = 75;
    double bookHeight = 110;
    double cardBookHeight = bookHeight + 5;

    Widget getCoverBook() {
      return SizedBox(
        width: bookWith,
        height: bookHeight,
        child: FutureBuilder<Widget>(
          future: _fnGetItemImage(_index, _item),
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
      );
    }

    Widget getMenuAnchor() {
      return MenuAnchor(
        alignmentOffset: Offset.fromDirection(-100.1, -200),
        style: const MenuStyle(
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
            onPressed: () => _fnViewDettaglioLibro(_parentContext, _libroBloc, _item),
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
            onPressed: () => _fnDeleteLibro(_parentContext, _libroBloc, _item),
            child: Icon(Icons.delete, color: Colors.orange.shade800),
          ),
        ],
      );
    }

    Widget getTitolo() {
      return Text(
        _item.titolo,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Colors.lightBlue[50] //Colors.white
        ),
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getAutore() {
      return Text(
        _item.lstAutori.join(', '),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontStyle: FontStyle.normal,
          color: Colors.lime[100]
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getCasaEditrice() {
      String editore = '';
      if (_item.editore != Constant.editoreDaDefinire) {
        editore = _item.editore;
      }

      return Text(
        editore,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.lime[50]
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getPrezzo() {
      return Text(
        '€ ${_item.prezzo}',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.orange[50]
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

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
        height: cardBookHeight - 5,
        child: InkWell(
          splashColor: Colors.red,
          onTap: () async {
            _fnViewDettaglioLibro(_parentContext, _libroBloc, _item);
          },
          child: Row(
            children: <Widget>[
              getCoverBook(),
              SizedBox(
                width: (MediaQuery.of(context).size.width * 70 / 100),
                height: cardBookHeight,  
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Row( 
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,                         
                              children: <Widget>[
                                Expanded(
                                  flex: 9,
                                  child: getTitolo(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: getMenuAnchor()
                                )
                              ]
                            )
                          ),
                        ]
                      ),
                      // Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: getAutore(),
                      //     )
                      //   ]
                      // )
                      getAutore(),
                      getCasaEditrice(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 8,
                            child: getPrezzo(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                                '${_index+1}/$nrTot',
                                style: Theme.of(context).textTheme.labelSmall,
                                textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                )
              ),
            ]
          ),
        )
      )
    );
  }
}