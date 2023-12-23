import 'package:books/config/com_area.dart';
import 'package:books/resources/ordinamento_libri.dart';
import 'package:flutter/material.dart';

// class GroupByMenu extends StatefulWidget {
//   final OrdinamentoLibri initOrdinamentoLibri;

//   const GroupByMenu(this.initOrdinamentoLibri, {super.key});

//   @override
//   State<GroupByMenu> createState() => _GroupByState();
// }

// class _GroupByState extends State<GroupByMenu> {

class GroupByMenu extends StatelessWidget {
  final OrdinamentoLibri _initOrdinamentoLibri;
  final void Function(String value) onPressed;

  const GroupByMenu({super.key, required OrdinamentoLibri initOrdinamentoLibri, required this.onPressed}) :
    _initOrdinamentoLibri = initOrdinamentoLibri;

  @override
  Widget build(BuildContext context) {
    List<OrdinamentoLibri> lstBookOrderBy = ComArea.lstBookOrderBy;
    // String dropdownValue = ComArea.groupComparatorField.label;

    return DropdownMenu<String>(
      width: (MediaQuery.of(context).size.width * 35 / 100),
      menuHeight: (MediaQuery.of(context).size.height * 40 / 100),
      textStyle: const TextStyle(fontSize: 16),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey[400]!),
      ),
      initialSelection: _initOrdinamentoLibri.label,
      onSelected: (String? value) {
        onPressed(value!);
      },
      dropdownMenuEntries: lstBookOrderBy.map<DropdownMenuEntry<String>>((OrdinamentoLibri item) {
        return DropdownMenuEntry<String>(value: item.label, label: item.label);
      }).toList(),
    );
  }
}