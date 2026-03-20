import 'package:flutter/material.dart';

class Lightbulb extends StatefulWidget {
  final Function()? fnOnOff;
  final bool isOn;

  const Lightbulb({
    super.key,
    required this.fnOnOff,
    required this.isOn
  });

  @override
  State<Lightbulb> createState() => _LightbulbState();
}

class _LightbulbState extends State<Lightbulb> {
  void _toggleLight() {
    setState(() {
      if (widget.fnOnOff != null) {
        widget.fnOnOff?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 35.0,
      icon: Icon(
        widget.isOn ? Icons.lightbulb : Icons.lightbulb_outline,
        // Se _isOn è true usa il colore passato, altrimenti grigio
        color: widget.isOn ? Colors.yellowAccent : Colors.grey,
        shadows: [
          if (widget.isOn) // Aggiunge il bagliore solo se colorata
            Shadow(
              blurRadius: 20.0,
              color: Colors.yellowAccent.withValues(alpha: 0.5),
            ),
        ],
      ),
      onPressed: _toggleLight, // L'evento che scatena il cambio
      tooltip: widget.isOn ? 'Glitch ON' : 'Glitch OFF',
    );
  }
}