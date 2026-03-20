import 'dart:io';

import 'package:book/config/com_area.dart';
import 'package:book/features/libreria/bloc/libreria.bloc.dart';
import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:book/models/selected_item.module.dart';
import 'package:book/utilities/list_items_utils.dart';
import 'package:book/widgets/icon_check_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../config/constant.dart';

class SingleCardLibreria extends StatefulWidget {
  final LibreriaBloc _libreriaBloc;
  final SelectedItem<LibreriaIsarModel> _selItem;
  final Function(BuildContext context, LibreriaIsarModel libreriaModelSel) _goToHomeLibriLibreria;
  final Function _editLibreria;
  final Function _deleteLibreria;
  final Function _saveLibreria;

  const SingleCardLibreria(
    this._libreriaBloc,
    this._selItem,
    this._goToHomeLibriLibreria,
    this._editLibreria,
    this._deleteLibreria,
      this._saveLibreria,
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
        icon: Icon(Icons.delete_forever, color: Colors.orange.shade800),
        label: "Elimina Libreria",
        onPressed: () => widget._deleteLibreria(context, selectedItem.item),
      ));

      lstMenuItemButton.add(buildCustomMenuItem(
        icon: Icon(Icons.delete_outline_sharp, color: Colors.orange.shade600),
        label: "Elimina Immagine",
        onPressed: () => {
          selectedItem.item.pathImmagineLibreria = null,
          widget._saveLibreria(context, selectedItem.item)
        }
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
              width: 100, // Larghezza fissa
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.none,
                      child: Text(
                        selectedItem.item.sigla.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 16, // Font leggermente più piccolo
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Spazio minimo
                    GestureDetector(
                      onDoubleTap: () {
                        // Se esiste un'immagine, la mostriamo a tutto schermo
                        if (selectedItem.item.pathImmagineLibreria != null) {
                          _mostraImmagineIntera(selectedItem.item.pathImmagineLibreria!);
                        }
                      },
                      onLongPress: () => {
                        _gestisciImmagine(context, selectedItem.item)
                      },
                      child: CircleAvatar(
                        radius: 25, // Portato a 20 per evitare l'overflow di 5px visto prima
                        // backgroundColor: Colors.green[100],
                        backgroundImage: (selectedItem.item.pathImmagineLibreria != null)
                            ? FileImage(File(selectedItem.item.pathImmagineLibreria!))
                            : null,
                        child: (selectedItem.item.pathImmagineLibreria == null)
                            ? const Icon(Icons.camera_alt, color: Colors.black54, size: 30)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            title: (selectedItem.sel)
                ? Text(
                    selectedItem.item.nome.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.double,
                      color: Colors.yellowAccent
                    ),
                  )
                : Text(
                    selectedItem.item.nome,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.lightBlueAccent[700] // Colors.limeAccent[100]
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: (selectedItem.sel)
                ? Text(
                    'Libri: ${selectedItem.item.nrLibriCaricati} - Valore: ${Constant.formatoEuro.format(selectedItem.item.valoreTot)}',
                    // style: Theme.of(context).textTheme.bodyMedium,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.lightGreenAccent
                    ),
                  )
                : Text(
                    'Libri: ${selectedItem.item.nrLibriCaricati} - Valore: ${Constant.formatoEuro.format(selectedItem.item.valoreTot)}',
                    // style: Theme.of(context).textTheme.bodyMedium,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.lightBlueAccent
                    ),
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
                      color: Colors.limeAccent,
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
      // shadowColor: const Color.fromARGB(139, 48, 63, 159),
      // surfaceTintColor: selectedItem.sel ? Colors.green.shade100 : Colors.transparent,
      // color: selectedItem.sel ? const Color.fromARGB(103, 0, 131, 143) : const Color.fromARGB(0, 119, 18, 18),

      // shadowColor: const Color.fromARGB(139, 208, 211, 221),
      // surfaceTintColor: selectedItem.sel ? Colors.green.shade100 : Colors.transparent,
      // color: selectedItem.sel ? const Color.fromARGB(103, 0, 131, 143) : const Color.fromARGB(0, 119, 18, 18),

        shadowColor: const Color.fromARGB(250, 228, 164, 119),
        surfaceTintColor: selectedItem.sel ? Colors.green.shade100 : Colors.transparent,
        color: selectedItem.sel ? const Color.fromARGB(255, 3, 43, 119) : const Color.fromARGB(0, 119, 18, 18),

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

  Future<void> _gestisciImmagine(BuildContext context, LibreriaIsarModel libreriaIsarModel) async {
    final ImagePicker picker = ImagePicker();

    // Mostriamo un dialogo veloce per la scelta
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Scatta Foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Scegli dalla Galleria'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80, // Comprimiamo un po' per non appesantire il DB
      );

      if (image != null) {
        libreriaIsarModel.pathImmagineLibreria = image.path;
        widget._saveLibreria(context, libreriaIsarModel);
      }
    }
  }

  void _mostraImmagineIntera(String path) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Sfondo trasparente per far risaltare l'immagine
          insetPadding: EdgeInsets.all(10), // Margine esterno
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              // Contenitore immagine con Zoom
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.file(
                      File(path),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Pulsante per chiudere
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}