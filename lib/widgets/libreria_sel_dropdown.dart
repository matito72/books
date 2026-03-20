import 'package:book/config/com_area.dart';
// import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:flutter/material.dart';


class LibreriaSelDropdown extends StatelessWidget {
  final int siglaLibreria;
  final int widthPerc;
  final int heighPerc;
  final void Function(int siglaLibreriaSel) onPressed;

  const LibreriaSelDropdown(this.siglaLibreria, {super.key, required this.onPressed, this.widthPerc=70, this.heighPerc=40});

  @override
  Widget build(BuildContext context) {

    return DropdownMenu<int>(
      width: (MediaQuery.of(context).size.width * widthPerc / 100),
      menuHeight: (MediaQuery.of(context).size.height * heighPerc / 100),
      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Colors.limeAccent
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        constraints: BoxConstraints.tight(
          const Size.fromHeight(30)
        ),
        // constraints: const BoxConstraints(
        //   maxWidth: 200, // Limita la larghezza massima del popup
        //   minWidth: 100, // Larghezza minima
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.limeAccent
        ),
      ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blueGrey[900]),
          surfaceTintColor: WidgetStateProperty.all(Colors.cyanAccent),
          shadowColor: WidgetStateProperty.all(Colors.cyanAccent.withValues(alpha: 0.5)),
          elevation: WidgetStateProperty.all(15),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              // Aggiungiamo anche un bordo sottile coordinato
              side: BorderSide(color: Colors.cyanAccent.withValues(alpha: 0.2)),
            ),
          ),
          maximumSize: WidgetStateProperty.all(const Size(90, 50)),
        ),
      initialSelection: siglaLibreria,
      onSelected: (int? value) {
        onPressed(value!);
      },
      dropdownMenuEntries: ComArea.mapCodDescLibreria.entries.map<DropdownMenuEntry<int>>((entry) {
        return DropdownMenuEntry<int>(
          value: entry.key,
          label: entry.value,
          style: MenuItemButton.styleFrom(
            iconColor: Colors.limeAccent,
            textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.yellow[50],
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
            foregroundColor: Colors.limeAccent
          ),
        );
      }).toList()
    );
  }
}