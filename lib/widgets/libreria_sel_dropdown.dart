import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:flutter/material.dart';


class LibreriaSelDropdown extends StatelessWidget {
  final int siglaLibreria;
  final int widthPerc;
  final int heighPerc;
  final void Function(int siglaLibreriaSel) onPressed;

  const LibreriaSelDropdown(this.siglaLibreria, {super.key, required this.onPressed, this.widthPerc=95, this.heighPerc=40});

  @override
  Widget build(BuildContext context) {

    return DropdownMenu<int>(
      width: (MediaQuery.of(context).size.width * widthPerc / 100),
      menuHeight: (MediaQuery.of(context).size.height * heighPerc / 100),
      textStyle: Theme.of(context).textTheme.titleSmall, // const TextStyle(fontSize: 14),
      // selectedTrailingIcon: Icon(Icons.more_horiz, color: Colors.blue.shade200),
      // trailingIcon: Icon(Icons.more_horiz, color: Colors.blue.shade200),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        constraints: BoxConstraints.tight(
          const Size.fromHeight(30)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      menuStyle: MenuStyle(
        // backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey[400]!),
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey[900]!),
      ),
      initialSelection: siglaLibreria,
      onSelected: (int? value) {
        onPressed(value!);
      },
      dropdownMenuEntries: ComArea.lstLibrerieInUso.map<DropdownMenuEntry<int>>((LibreriaIsarModel libreriaModel) {
        return DropdownMenuEntry<int>(value: libreriaModel.sigla, label: libreriaModel.nome);
      }).toList(),
    );
  }
}