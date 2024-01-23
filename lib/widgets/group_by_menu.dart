import 'package:books/config/com_area.dart';
import 'package:books/resources/libro_field_selected.dart';
import 'package:flutter/material.dart';

// class GroupByMenu extends StatefulWidget {
//   final OrdinamentoLibri initOrdinamentoLibri;

//   const GroupByMenu(this.initOrdinamentoLibri, {super.key});

//   @override
//   State<GroupByMenu> createState() => _GroupByState();
// }

// class _GroupByState extends State<GroupByMenu> {

class GroupByMenu extends StatelessWidget {
  final LibroFieldSelected _initOrdinamentoLibri;
  final void Function(String value) onPressed;

  const GroupByMenu({super.key, required LibroFieldSelected initOrdinamentoLibri, required this.onPressed}) :
    _initOrdinamentoLibri = initOrdinamentoLibri;

  @override
  Widget build(BuildContext context) {
    List<LibroFieldSelected> lstBookOrderBy = ComArea.lstBookOrderBy;

    return DropdownMenu<String>(
      width: (MediaQuery.of(context).size.width * 35 / 100),
      menuHeight: (MediaQuery.of(context).size.height * 40 / 100),
      textStyle: const TextStyle(fontSize: 16),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        constraints: BoxConstraints.tight(
          const Size.fromHeight(35)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey[400]!),
      ),
      initialSelection: _initOrdinamentoLibri.label,
      onSelected: (String? value) {
        onPressed(value!);
      },
      dropdownMenuEntries: lstBookOrderBy.map<DropdownMenuEntry<String>>((LibroFieldSelected item) {
        return DropdownMenuEntry<String>(value: item.label, label: item.label);
      }).toList(),
    );
  }
}