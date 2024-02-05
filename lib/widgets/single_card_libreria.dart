import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/bloc/libreria.bloc.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:books/widgets/icon_check_item.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleCardLibreria extends StatefulWidget {
  final LibreriaBloc _libreriaBloc;
  final SelectedItem<LibreriaIsarModel> _selItem;
  final Function(BuildContext context, LibreriaIsarModel libreriaModelSel) _goToHomeLibriLibreria;
  final Function _editLibreria;
  final Function _deleteLibreria;

  const SingleCardLibreria(
    this._libreriaBloc,
    this._selItem,
    this._goToHomeLibriLibreria,
    this._editLibreria,
    this._deleteLibreria,
    {super.key}
  );

  @override
  State<SingleCardLibreria> createState() => _SingleCardLibreria();
}

class _SingleCardLibreria extends State<SingleCardLibreria> {

  @override
  Widget build(BuildContext context) {
    SelectedItem selectedItem = widget._selItem;
    // LibreriaModel? libreriaInUso = ComArea.libreriaInUso;

    Widget getMenu() {
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
              "Entra nella Libreria",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onPressed: () => {
              selectedItem.sel = true,
              widget._goToHomeLibriLibreria(context, selectedItem.item)
            },
            child: Icon(MdiIcons.locationEnter, color: Colors.lightGreenAccent[100],),
          ),
          MenuItemButton(
            trailingIcon: Text(
              "Modifica Libreria",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onPressed: () => widget._editLibreria(context, selectedItem.item),
            child: Icon(Icons.edit, color: Colors.yellowAccent.shade100,),
          ),
          MenuItemButton(
            trailingIcon: Text(
              "Seleziona Libreria",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onPressed: () => {
              setState(() {
                  selectedItem.sel = !selectedItem.sel;
              })
            },
            child: const Icon(Icons.check_circle, color: Colors.lightGreenAccent),
          ),
          MenuItemButton(
            trailingIcon: Text(
              "Elimina Libreria",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onPressed: () => widget._deleteLibreria(context, selectedItem.item),
            child: Icon(Icons.delete, color: Colors.orange.shade800),
          ),
        ],
      );
    }

    Widget getCardLibreriaContent() {
      return InkWell(
        splashColor: Colors.lightBlue[50],
        onLongPress: () => {
          setState(() {
              selectedItem.sel = !selectedItem.sel;
          })
        },
        onTap: () => {
          if (ListItemsUtils.isThereOneSelected(widget._libreriaBloc.state.data)) {
            setState(() {
                selectedItem.sel = !selectedItem.sel;
            })
          } else {
            selectedItem.sel = true,
            widget._goToHomeLibriLibreria(context, selectedItem.item) // selezionata la riga libreria
          }
        },
        child: ListTile(
          style: ListTileStyle.list,
          leading: Padding(
              padding: const EdgeInsets.all(3),
              child: FittedBox(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[100],
                  child: Text(
                    // libreria.sigla,
                    selectedItem.item.sigla.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black, // Colors.blue.shade900,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              )
            ),
          title: (!ComArea.initApp) 
            ? Text(selectedItem.item.nome, style: Theme.of(context).textTheme.headlineSmall)
            : (selectedItem.sel) 
              ? Text(
                  selectedItem.item.nome.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 5,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.double,
                    color: Colors.white,
                    decorationColor: Colors.white,
                  ),
                ) 
              : Text(
                selectedItem.item.nome,
                style: Theme.of(context).textTheme.headlineSmall
              ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                'Libri: ${selectedItem.item.nrLibriCaricati}',
                style: Theme.of(context).textTheme.headlineSmall
              ),
            ],
          ),
          trailing: selectedItem.sel
            ? ColoredBox(
                color: Colors.transparent,
                child: IconCheckItem(
                  heightBox: (MediaQuery.of(context).size.height * (selectedItem.sel ? 8 : 0) / 100),
                  onPressed: () => setState(() {
                    if (ListItemsUtils.isThereOneSelected(widget._libreriaBloc.state.data)) {
                      widget._goToHomeLibriLibreria(context, selectedItem.item);
                    } else {
                      selectedItem.sel = !selectedItem.sel;
                    }
                  }), 
                  isItemSel: selectedItem.sel,
                  selectedIcon: Icon(
                    MdiIcons.locationEnter,
                    color: Colors.green[200],
                  )
                ),
              )
            : getMenu(),
        ),
      );
    }

    return Card(
      shadowColor: const Color.fromARGB(139, 48, 63, 159),
      surfaceTintColor: selectedItem.sel ? Colors.green.shade100 : Colors.transparent,
      // color: (dbLibreriaService.libreriaInUso.nome == libreria.nome) ? Colors.cyan.shade800 : Colors.transparent,
      color: selectedItem.sel ? const Color.fromARGB(103, 0, 131, 143) : const Color.fromARGB(0, 119, 18, 18),
      // color: Colors.transparent,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Stack(
        children: [
          Opacity(
            opacity: !selectedItem.sel ? 1 : 0.5,
            child: getCardLibreriaContent(),
          ),
          Visibility(
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            visible: selectedItem.sel,
            child: Icon(
              Icons.check_circle,
              color: (ComArea.libreriaInUso != null && selectedItem.item.sigla == ComArea.libreriaInUso!.sigla) 
                ? Colors.lightBlue[400]
                : Colors.green[200],
            ),
          )
        ]
      )
    );
  }

}