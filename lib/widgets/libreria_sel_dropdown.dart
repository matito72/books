import 'package:books/config/com_area.dart';
import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:flutter/material.dart';


class LibreriaSelDropdown extends StatelessWidget {
  final String siglaLibreria;
  final int widthPerc;
  final int heighPerc;
  final void Function(String siglaLibreriaSel) onPressed;

  const LibreriaSelDropdown(this.siglaLibreria, {super.key, required this.onPressed, this.widthPerc=95, this.heighPerc=40});

  @override
  Widget build(BuildContext context) {

    return DropdownMenu<String>(
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
      onSelected: (String? value) {
        onPressed(value!);
      },
      dropdownMenuEntries: ComArea.lstLibrerieInUso.map<DropdownMenuEntry<String>>((LibreriaModel libreriaModel) {
        return DropdownMenuEntry<String>(value: libreriaModel.sigla, label: libreriaModel.nome);
      }).toList(),
    );
  }
}