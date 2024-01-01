import 'package:books/resources/bisac_codes.dart';
import 'package:flutter/material.dart';


class BisacDropdownMenu extends StatelessWidget {
  final String? _initialSelection;
  final int widthPerc;
  final int heighPerc;
  final void Function(String value) onPressed;

  const BisacDropdownMenu(this._initialSelection, {super.key, required this.onPressed, this.widthPerc=95, this.heighPerc=40});

  @override
  Widget build(BuildContext context) {
    List<String> lstBisacCods = BisacList.lstBisacCods;

    return DropdownMenu<String>(
      width: (MediaQuery.of(context).size.width * widthPerc / 100),
      menuHeight: (MediaQuery.of(context).size.height * heighPerc / 100),
      textStyle: const TextStyle(fontSize: 14),
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
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey[400]!),
      ),
      initialSelection: _initialSelection,
      onSelected: (String? value) {
        onPressed(value!);
      },
      dropdownMenuEntries: lstBisacCods.map<DropdownMenuEntry<String>>((String bisacCode) {
        return DropdownMenuEntry<String>(value: bisacCode, label: bisacCode);
      }).toList(),
    );
  }
}