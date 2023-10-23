import 'package:flutter/material.dart';

class FiveStars extends StatelessWidget {
  final int value;
  final void Function(int value) onPressed;

  const FiveStars({super.key, required this.value, required this.onPressed});

  Icon _getStar(int pos) {
   if (pos <= value) {
     return const Icon(Icons.star,  color: Colors.orange);
   } else {
     return const Icon(Icons.star_border, color: Colors.grey);
   }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return InkWell(
          child: _getStar(index),
          onTap: () => onPressed(index),
        );
      })
    );
  }
}