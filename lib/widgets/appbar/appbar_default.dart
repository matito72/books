import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final num _percHeight;
  final Color? _primaryColor;
  final Color? _secondaryColor;
  final bool _showIconSx;
  final IconButton? _iconSx;
  final IconButton? _iconDx;
  final String? _txtLabel;
  final PopupMenuButton? _popupMenuButton;
  final List<Widget> _lstWidgetDx;
  final Widget? _appBarContent;
  final BuildContext context;

  @override 
  late final Size preferredSize;
  
  AppBarDefault({
      super.key, 
      required this.context,
      num percHeight = 4,
      // this.primaryColor = Colors.blue,
      // this.secondaryColor = Colors.pink,
      Color? primaryColor = const Color.fromARGB(255, 38, 50, 56),
      Color? secondaryColor = Colors.blue,
      bool showIconSx = true,
      IconButton? iconSx,
      String? txtLabel,
      Widget? appBarContent, 
      IconButton? iconDx,
      PopupMenuButton<dynamic>? popupMenuButton,
      List<Widget> lstWidgetDx = const []
  }) : _appBarContent = appBarContent, _lstWidgetDx = lstWidgetDx, _popupMenuButton = popupMenuButton, _txtLabel = txtLabel, _iconDx = iconDx, _iconSx = iconSx, _showIconSx = showIconSx, _secondaryColor = secondaryColor, _primaryColor = primaryColor, _percHeight = percHeight {
    preferredSize = Size.fromHeight((MediaQuery.of(context).size.height * _percHeight / 100));
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: MediaQuery.of(context).size.height * _percHeight / 100,
        alignment: const Alignment(-0.9, 0.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[_primaryColor!, _secondaryColor!],
            tileMode: TileMode.clamp,
            begin: Alignment.centerLeft,
            // colors: <Color>[Colors.blue, Color.fromARGB(115, 0, 143, 88)],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _showIconSx
              ? _iconSx ?? IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : const Text('\t\t\t'),
            Expanded(
              child: Container(
                child: (_txtLabel != null && _appBarContent == null)
                  ? Text(
                    _txtLabel!,
                    overflow: TextOverflow.ellipsis,
                  )
                  : (_appBarContent != null)
                    ? _appBarContent!
                    : const Text('')
              ),
            ),
            _iconDx ?? const Text(''),
            _popupMenuButton ?? const Text(''),
            _lstWidgetDx.isNotEmpty 
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _lstWidgetDx,
              ) 
              : const Text(''),
          ]
        ),
      )
    );
  }
  

}