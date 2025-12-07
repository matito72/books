import 'package:flutter/material.dart';
import 'package:book/features/libro/data/models/pdf_isar.module.dart';

class PDFCreationButton extends StatefulWidget {
  final List<PdfIsarModule> lstPdfIsarModule;
  final Future<String> Function(BuildContext context) createPDF;
  final Future<PdfIsarModule?> Function(BuildContext context, String txt) savePDF;

  const PDFCreationButton({
    super.key,
    required this.lstPdfIsarModule,
    required this.createPDF,
    required this.savePDF,
  });

  @override
  State<PDFCreationButton> createState() => _PDFCreationButtonState();
}

class _PDFCreationButtonState extends State<PDFCreationButton> {
  // 1. Variabile di stato per contenere il Future
  Future<void>? _pdfCreationFuture;

  // 2. Metodo che avvia l'elaborazione
  Future<void> _startCreationProcess() async {
    setState(() {
      // Inizializza il Future che verrà monitorato dal FutureBuilder
      _pdfCreationFuture = _processPDF();
    });
  }

  // 3. La tua logica originale trasformata in un metodo privato
  Future<void> _processPDF() async {
    try {
      // 3a. Chiamata _createPDF
      final String txt = await widget.createPDF(context);

      if (!context.mounted) return;

      // 3b. Chiamata _savePDF
      final PdfIsarModule? pdfFilePath = await widget.savePDF(context, txt);

      if (pdfFilePath != null) {
        widget.lstPdfIsarModule.add(pdfFilePath);
      }

      // 3c. Chiusura del pop-up o navigazione (se ancora montato)
      if (context.mounted) {
        // Usa `pop` solo se sei sicuro che il widget sia in un popup/dialogo
        Navigator.pop(context);
      }
    } catch (e) {
      // Gestione degli errori (opzionale)
      print('Errore durante la creazione del PDF: $e');
      if (context.mounted) {
        // Mostra un messaggio di errore all'utente se necessario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Errore durante la creazione del PDF.')),
        );
      }
    }
  }

  // 4. Il metodo build usa il FutureBuilder
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _pdfCreationFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {

        // 4a. Se c'è un Future in corso (cioè, l'utente ha premuto il bottone)
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mostra l'indicatore di progresso al posto dell'icona
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                color: Color.fromARGB(176, 255, 28, 11), // Colore icona originale
              ),
            ),
          );
        }

        // 4b. Se il Future è terminato (con successo o con errore) o non è mai partito
        // (ConnectionState.none o ConnectionState.done)
        return IconButton(
          icon: const Icon(Icons.picture_as_pdf),
          onPressed: () {
            // Avvia l'elaborazione al click
            _startCreationProcess();
          },
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll<Color>(
                Color.fromARGB(184, 94, 243, 101)),
            iconColor: const WidgetStatePropertyAll<Color>(
                Color.fromARGB(176, 255, 28, 11)),
            iconSize: WidgetStateProperty.all(30.0),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(
                    color: Color.fromARGB(188, 104, 236, 104)),
              ),
            ),
          ),
        );
      },
    );
  }
}