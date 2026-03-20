import 'package:book/resources/bisac_codes.dart';
import 'package:flutter/material.dart';


class BisacDropdownMenu extends StatelessWidget {
  final String? _initialSelection;
  final int widthPerc;
  final int heighPerc;
  final void Function(String value) onPressed;

  const BisacDropdownMenu(this._initialSelection, {super.key, required this.onPressed, this.widthPerc=70, this.heighPerc=40});

  @override
  Widget build(BuildContext context) {
    List<String> lstBisacCods = BisacList.lstBisacCods;

    return DropdownMenu<String>(
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      // menuStyle: MenuStyle(
      //   // backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey[400]!),
      //   backgroundColor: WidgetStatePropertyAll<Color>(Colors.blueGrey[900]!),
      // ),
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
      initialSelection: _initialSelection,
      onSelected: (String? value) {
        onPressed(value!);
      },
      dropdownMenuEntries: lstBisacCods.map<DropdownMenuEntry<String>>((String bisacCode) {
        return DropdownMenuEntry<String>(
            value: bisacCode,
            label: bisacCode,
          style: MenuItemButton.styleFrom(
            // iconColor: Colors.limeAccent,
            textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
              foregroundColor: Colors.limeAccent
          ),
        );
      }).toList(),
    );
  }
}