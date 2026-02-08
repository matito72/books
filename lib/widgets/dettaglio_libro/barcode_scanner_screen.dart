import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  // 🔑 FLAG DI STATO: Questa variabile è la chiave per la soluzione.
  bool _isBarcodeDetected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scansiona Codice a Barre'),
        backgroundColor: Colors.black,
      ),
      body: MobileScanner(
        // Il controller permette di mettere in pausa/riprendere la scansione.
        // Puoi ometterlo, ma il flag è la soluzione più diretta per il tuo problema.
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final String? barcodeValue = barcodes.first.rawValue;

            // 1. Verifica se è già stato rilevato un codice.
            if (!_isBarcodeDetected && barcodeValue != null) {

              // 2. Imposta il flag a TRUE immediatamente.
              // Questo impedisce a qualsiasi chiamata successiva a onDetect di eseguire il blocco.
              _isBarcodeDetected = true;

              // 3. Esegui la navigazione una sola volta.
              // NON è necessario un Future.delayed, il flag gestisce la race condition.
              Navigator.of(context).pop(barcodeValue);
            }
          }
        },
      ),
    );
  }
}