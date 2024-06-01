import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/widgets/appbar/appbar_default.dart';
import 'package:flutter/material.dart';

class DettaglioTesto extends StatefulWidget {
  static const String pagePath = '/dettaglioTesto';

  final LibroIsarModel libroViewModel;
  final String testo;

  const DettaglioTesto({super.key, required this.libroViewModel, required this.testo});

  @override
  State<DettaglioTesto> createState() => _DettaglioTesto();
}

class _DettaglioTesto extends State<DettaglioTesto> {
  final TextEditingController _textCtrl = TextEditingController();
    
  @override
  void initState() {
    super.initState();

    _textCtrl.text = widget.testo;
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarDefault(
          context: context,
          percHeight: 5,
          appBarContent: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.libroViewModel.titolo,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.libroViewModel.lstAutori.join(', '), 
                  style: TextStyle(color: Colors.amber[300]),
                  overflow: TextOverflow.ellipsis,
                )
              )
            ],
          )
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                maxLines: 30,
                // maxLines: null, // Set this 
                // expands: true, // and this
                keyboardType: TextInputType.multiline,
                autofocus: true,
                // decoration: InputDecoration(hintText: strHintText),
                controller: _textCtrl,
                style: Theme.of(context).textTheme.titleSmall
              )
            ],
          ),
        )
      ),
    );
  }
}


