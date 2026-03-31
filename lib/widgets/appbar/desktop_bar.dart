

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DesktopBar  {
  final windowManager = WindowManager.instance;

  late final IconButton _iconMinimizza;
  // late final IconButton _iconMassimizza;
  late final IconButton _iconClose;
  late Widget _windowsBarGestureDetector;

  DesktopBar() {
    _iconMinimizza = IconButton(
      constraints: const BoxConstraints(maxWidth: 40),
      icon: const Icon(Icons.remove, color: Colors.white, size: 18),
      onPressed: () => windowManager.minimize(),
      hoverColor: Colors.white12,
      splashRadius: 20,
    );

    // _iconMassimizza = IconButton(
    //   constraints: const BoxConstraints(maxWidth: 40),
    //   icon: const Icon(Icons.crop_square, color: Colors.white, size: 16),
    //   onPressed: () async {
    //     if (await windowManager.isMaximized()) {
    //       await windowManager.unmaximize();
    //     } else {
    //       await windowManager.maximize();
    //     }
    //   },
    //   hoverColor: Colors.white12,
    //   splashRadius: 20,
    // );

       _iconClose = IconButton(
        constraints: const BoxConstraints(maxWidth: 40),
        icon: const Icon(Icons.close, color: Colors.white, size: 18),
        onPressed: () => windowManager.close(),
        hoverColor: Colors.redAccent, // Effetto classico rosso alla chiusura
        splashRadius: 20,
      );

    _windowsBarGestureDetector = GestureDetector(
      onPanStart: (_) => windowManager.startDragging(),
      child: Material( // <--- Aggiungi questo
        color: Colors.black26, // Sposta il colore qui dal Container
        child: SizedBox(
          height: 40,
          // color: Colors.black26, // Rimuovilo da qui o lascialo trasparente
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "BOOKs",
                  style: TextStyle(
                    fontSize: 14.0, // Alzato leggermente per leggibilità
                    fontWeight: FontWeight.bold, // Opzionale: lo rende più visibile
                    color: Colors.yellow.shade50,
                    decoration: TextDecoration.none, // Rimuove esplicitamente sottolineature
                  ),
                ),
              ),
              const Spacer(),
              _iconMinimizza,
              _iconClose,
            ],
          ),
        ),
      ),
    );
  }

  Widget get gestureDetector => Platform.isLinux
      ? _windowsBarGestureDetector
      : Padding(padding: EdgeInsetsGeometry.all(0));
}