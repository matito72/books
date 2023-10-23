import 'package:books/features/libreria/data/models/libreria_model.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final LibreriaModel libreriaSel;

  const TestScreen(this.libreriaSel, {super.key});
  
  @override
  Widget build(Object context) {
    return Center(
      child: Text('TEST SCREEN : ${libreriaSel.nome}'),
    );
  }


}