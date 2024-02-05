import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final LibreriaIsarModel libreriaSel;

  const TestScreen(this.libreriaSel, {super.key});
  
  @override
  Widget build(Object context) {
    return Center(
      child: Text('TEST SCREEN : ${libreriaSel.nome}'),
    );
  }


}