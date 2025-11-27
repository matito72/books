import 'package:flutter/material.dart';

class FiveStars extends StatelessWidget {
  final int _value;  
  final void Function(int value) onPressed;

  const FiveStars({super.key, required int value, required this.onPressed}) : _value = value;

  // Icon _getStar(int pos) {
  //  if (pos <= _value) {
  //    return const Icon(Icons.star,  color: Colors.orange);
  //  } else {
  //    return const Icon(Icons.star_border, color: Colors.grey);
  //  }
  // }
  Icon _getStar(int pos) {
    if (pos > _value) {
      return const Icon(Icons.star_border, color: Colors.grey);
    } else {
      return const Icon(Icons.star,  color: Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return InkWell(
          child: _getStar(index+1),
          onTap: () => onPressed(index+1),
        );
      })
    );
  }
}