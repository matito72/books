import 'package:book/config/com_area.dart';
import 'package:book/features/libreria/bloc/libreria.bloc.dart';
import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:book/models/selected_item.module.dart';
import 'package:book/utilities/list_items_utils.dart';
import 'package:book/widgets/icon_check_item.dart';
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

    createListMenuItemButton() {
      List<MenuItemButton> lstMenuItemButton = [];

      // Helper per creare i bottoni con allineamento costante
      MenuItemButton buildCustomMenuItem({
        required Widget icon,
        required String label,
        required VoidCallback onPressed,
      }) {
        return MenuItemButton(
          onPressed: onPressed,
          // Usiamo 'leadingIcon' per l'icona a sinistra (standard Material)
          // Se vuoi l'icona a sinistra, il testo va nel 'child'
          leadingIcon: SizedBox(
            width: 32, // Larghezza fissa per le icone per allineare i testi
            child: icon,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white, // Bianco per contrasto con lo sfondo blu del menu
              ),
            ),
          ),
        );
      }

      lstMenuItemButton.add(buildCustomMenuItem(
        icon: Icon(MdiIcons.locationEnter, color: Colors.lightGreenAccent[100]),
        label: "Entra nella Libreria",
        onPressed: () {
          selectedItem.sel = true;
          widget._goToHomeLibriLibreria(context, selectedItem.item);
        },
      ));

      if (selectedItem.item.nrLibriCaricati == 0) {
        lstMenuItemButton.add(buildCustomMenuItem(
          icon: Icon(Icons.edit, color: Colors.yellowAccent.shade100),
          label: "Modifica Libreria",
          onPressed: () => widget._editLibreria(context, selectedItem.item),
        ));
      }

      lstMenuItemButton.add(buildCustomMenuItem(
        icon: const Icon(Icons.check_circle, color: Colors.lightGreenAccent),
        label: "Seleziona Libreria",
        onPressed: () {
          setState(() {
            selectedItem.sel = !selectedItem.sel;
          });
        },
      ));

      lstMenuItemButton.add(buildCustomMenuItem(
        icon: Icon(Icons.delete, color: Colors.orange.shade800),
        label: "Elimina Libreria",
        onPressed: () => widget._deleteLibreria(context, selectedItem.item),
      ));

      return lstMenuItemButton;
    }

    Widget getMenu() {
      return MenuAnchor(
        crossAxisUnconstrained: false,
        style: const MenuStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(224, 88, 136, 182)),
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
        menuChildren: createListMenuItemButton(),
      );
    }

    Widget getCardLibreriaContent() {
      // Avvolgiamo tutto in MouseRegion per forzare il cursore su Desktop/Linux
      return MouseRegion(
        hitTestBehavior: HitTestBehavior.opaque,
        cursor: SystemMouseCursors.click, // Cambiato in 'click' (la manina), più naturale per le liste,
        child: InkWell(
          // Manteniamo mouseCursor anche qui per ridondanza, ma MouseRegion è il driver principale
          mouseCursor: SystemMouseCursors.click,
          splashColor: Colors.lightBlue[50],
          onLongPress: () {
            setState(() {
              selectedItem.sel = !selectedItem.sel;
            });
          },
          onTap: () {
            if (ListItemsUtils.isThereOneSelected(widget._libreriaBloc.state.data)) {
              setState(() {
                selectedItem.sel = !selectedItem.sel;
              });
            } else {
              selectedItem.sel = true;
              widget._goToHomeLibriLibreria(context, selectedItem.item);
            }
          },
          child: ListTile(
            isThreeLine: true, // Aiuta a prevenire overflow verticali
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green[100],
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      selectedItem.item.sigla.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            title: (!ComArea.initApp)
                ? Text(
              selectedItem.item.nome,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
                : (selectedItem.sel)
                ? Text(
              selectedItem.item.nome.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.double,
                color: Colors.white,
              ),
            )
                : Text(
              selectedItem.item.nome,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Libri: ${selectedItem.item.nrLibriCaricati}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                selectedItem.sel
                    ? SizedBox(
                  width: 48,
                  height: 48,
                  child: IconCheckItem(
                    // Usiamo un valore fisso leggermente inferiore a 48 per sicurezza
                    heightBox: 47.8,
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
                      size: 47, // Dimensione dell'icona più equilibrata
                    ),
                  ),
                )
                : getMenu(),
              ],
            ),
          ),
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