import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/list_items_select/bloc/list_items_select.bloc.dart';
import 'package:books/features/list_items_select/bloc/list_items_select_events.bloc.dart';
import 'package:books/features/libro/bloc/libro.bloc.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:books/widgets/icon_check_item.dart';
import 'package:flutter/material.dart';

class SingleCardBook extends StatefulWidget {
  final LibroBloc _libroBloc;
  final ListItemsSelectBloc _floatingButtonBloc;
  final BuildContext _parentContext; 
  final Function _fnViewDettaglioLibro;
  final Function _fnDeleteLibro;
  final Function _fnGetItemImage;
  final SelectedItem<LibroViewModel> _selItem;
  final int _index;
  final num nrTot;

  const SingleCardBook(
    this._libroBloc,
    this._floatingButtonBloc,
    this._parentContext,
    this._fnViewDettaglioLibro, 
    this._fnDeleteLibro,
    this._fnGetItemImage,
    this._selItem,
    this._index,
    this.nrTot,
    {super.key}
  );

  @override
  State<SingleCardBook> createState() => _SingleCardBook();
}

class _SingleCardBook extends State<SingleCardBook> {
  @override
  Widget build(BuildContext context) {
    double bookWith = 90;
    double bookHeight = 135;
    double cardBookHeight = bookHeight + 5;

    Widget getCoverBook() {
      return SizedBox(
        width: bookWith,
        height: bookHeight,
        child: FutureBuilder<Widget>(
          future: widget._fnGetItemImage(widget._index, widget._selItem.item),
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
        crossAxisUnconstrained: false,
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
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.secondary,
            ),
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
            onPressed: () => widget._fnViewDettaglioLibro(widget._parentContext, widget._libroBloc, widget._selItem.item),
            child: Icon(Icons.edit, color: Colors.yellowAccent.shade100,),
          ),
          MenuItemButton(
            trailingIcon: Text(
              "Seleziona",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green[100],
              ),
            ),
            onPressed: () => setState(() {
              widget._selItem.sel = !widget._selItem.sel;
              widget._floatingButtonBloc.add(InitListItemsSelectEvent());
              widget._floatingButtonBloc.add(RefreshListItemsSelectEvent(widget._libroBloc.state.data));
            }),
            child: Icon(Icons.check_circle, color: Colors.green[200],
              )            
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
            onPressed: () => widget._fnDeleteLibro(widget._parentContext, widget._libroBloc, widget._selItem.item),
            child: Icon(Icons.delete, color: Colors.orange.shade800),
          ),
        ],
      );
    }

    Widget getTitolo() {
      return Text(
        widget._selItem.item.titolo,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Colors.lightBlue[50] //Colors.white
        ),
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getCategoria() {
      return Text(
        widget._selItem.item.lstCategoria[0],
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.lime[50]
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getAutore() {
      return Text(
        widget._selItem.item.lstAutori.join(', '),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontStyle: FontStyle.normal,
          color: Colors.limeAccent[100]
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getCasaEditrice() {
      String editore = '';
      if (widget._selItem.item.editore != Constant.editoreDaDefinire) {
        editore = widget._selItem.item.editore;
      }

      return Text(
        editore,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.lime[100]
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getPrezzo() {
      return Text(
        '€ ${widget._selItem.item.prezzo}',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.orange[50]
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget getDtInserimentoCounter() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text(
          //   // 'Dt.Ins.: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget._selItem.item.dataInserimento))}',
          //   'Cod.: ${Utils.getLastSubstring(widget._selItem.item.dataInserimento, 4)}',
          //   style: Theme.of(context).textTheme.labelSmall,
          //   textAlign: TextAlign.right,
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          // ),
          Text(
            '${ComArea.mapCodDescLibreria[widget._selItem.item.siglaLibreria]}',
            style: TextStyle(
              fontSize: 12.0, 
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.orange[100]
            ),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 5)
          ),
          Text(
            '- ${widget._index+1}/${widget.nrTot}',
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.right,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 5)
          ),
        ],
      );
    }

    Widget getBookDataContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
                        flex: 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            getTitolo(),
                            getAutore()
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: getMenuAnchor()
                      ),
                    ]
                  ),
                  getCategoria(),
                  getCasaEditrice(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      getPrezzo(),
                      getDtInserimentoCounter()
                    ],
                  )
                ],
              )
            )
          ),
        ]
      );
    }

    Widget getBookCardContent() {
      return SizedBox(
        width: (MediaQuery.of(context).size.width * 100 / 100),
        height: cardBookHeight - 5,
        child: InkWell(
          splashColor: Colors.transparent, //Colors.red,
          onDoubleTap: () async {
            widget._fnViewDettaglioLibro(widget._parentContext, widget._libroBloc, widget._selItem.item);
          },
          onLongPress: () => {
            setState(() {
                widget._selItem.sel = !widget._selItem.sel;
                widget._floatingButtonBloc.add(InitListItemsSelectEvent());
                widget._floatingButtonBloc.add(RefreshListItemsSelectEvent(widget._libroBloc.state.data));
            })
          },
          onTap: () => {
            if (ListItemsUtils.isThereOneSelected(widget._libroBloc.state.data)) {
              setState(() {
                  widget._selItem.sel = !widget._selItem.sel;
                  widget._floatingButtonBloc.add(InitListItemsSelectEvent());
                  widget._floatingButtonBloc.add(RefreshListItemsSelectEvent(widget._libroBloc.state.data));
              })
            }
          },
          child: getBookDataContent()
        )
      );
    }

    return Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      // color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: const Color.fromARGB(255, 30, 109, 148),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: !widget._selItem.sel ? 1 : 0.5,
            child: getBookCardContent()
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconCheckItem(
              heightBox: (cardBookHeight - 5),
              onPressed: () => setState(() {
                widget._selItem.sel = !widget._selItem.sel;
                widget._floatingButtonBloc.add(InitListItemsSelectEvent());
                widget._floatingButtonBloc.add(RefreshListItemsSelectEvent(widget._libroBloc.state.data));
              }), 
              isItemSel: widget._selItem.sel,
              selectedIcon: Icon(
                Icons.check_circle,
                color: Colors.green[200],
              )
            ),
          )
        ]
      )
    );
  }
}