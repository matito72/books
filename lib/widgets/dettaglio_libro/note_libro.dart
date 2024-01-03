import 'dart:convert';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill; 

class NoteLibro extends StatefulWidget {
  final LibroViewModel _libroViewModel;
  final QuillController _controller;
  
  const NoteLibro(this._libroViewModel, this._controller, {super.key});

  @override
  State<NoteLibro> createState() => _NoteLibro();
}

class _NoteLibro extends State<NoteLibro> {

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(255, 27, 69, 90),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: (MediaQuery.of(context).size.height * 55 / 100),
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                  boxShadow: [
                     BoxShadow(
                      color: Colors.grey[50]!,
                      offset: const Offset(5.0, 5.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0
                    ),
                    const BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0
                    )
                  ]
                ),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: widget._controller,
                    readOnly: false,
                    sharedConfigurations:  QuillSharedConfigurations(
                      locale: const Locale('it'),
                      dialogTheme: QuillDialogTheme(
                        labelTextStyle: const TextStyle(color: Colors.black),
                        inputTextStyle: TextStyle(color: Colors.yellow[200])
                      ),
                    ),
                    onTapOutside: (event, focusNode) => {
                      widget._libroViewModel.note = jsonEncode(widget._controller.document.toDelta().toJson()),
                    },
                  ),
                )
              ),
            ),
            QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: widget._controller,
                sharedConfigurations: const QuillSharedConfigurations(
                  dialogBarrierColor: Colors.black,
                  locale: Locale('it'),
                ),
                color: Colors.amber,
                  
              ),
            ),
          ],
        ),
      ),
    );
  
  }

}
