import 'dart:io';
import 'dart:typed_data';

import 'package:pdfx/pdfx.dart';


class PdfUtils {
  /// Restituisce la thumbnail (immagine) della prima pagina di un PDF.
  ///
  /// @param pdfPath Il percorso completo del file PDF.
  /// @return Un Future<Uint8List?> contenente i dati dell'immagine (PNG) o null in caso di errore.
  static Future<Uint8List?> getPdfThumbnail(String pdfPath) async {
    // 1. Verifica l'esistenza del file
    final file = File(pdfPath);
    if (!file.existsSync()) {
      print('🚨 Errore: File PDF non trovato in $pdfPath');
      return null;
    }

    try {
      // 2. Apri il documento PDF
      final document = await PdfDocument.openFile(pdfPath);

      // 3. Ottieni la prima pagina (le pagine partono da 1)
      final page = await document.getPage(1);

      // 4. Renderizza la pagina in un'immagine
      // Definiamo una dimensione standard per la thumbnail (es. 150x200 pixel)
      final render = await page.render(
        width: 150,
        height: 200,
        format: PdfPageImageFormat.png, // Formato dell'immagine in uscita
        backgroundColor: '#ffffff', // Sfondo bianco per trasparenza (opzionale)
      );

      // 5. Chiudi le risorse
      await page.close();
      await document.close();

      // 6. Restituisce i byte dell'immagine
      return render!.bytes;

    } catch (e) {
      print('❌ Errore durante la generazione della thumbnail PDF: $e');
      return null;
    }
  }
}