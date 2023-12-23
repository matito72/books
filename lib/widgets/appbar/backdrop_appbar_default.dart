import 'package:flutter/material.dart';

class BackdropAppbarDefault extends StatelessWidget implements PreferredSizeWidget {
  final num _percHeight;
  // final Color? primaryColor;
  // final Color? secondaryColor;
  final bool _showIconSx;
  final IconButton? _iconSx;
  final IconButton? _iconDx;
  final String? _txtLabel;
  final PopupMenuButton? _popupMenuButton;
  final List<Widget> _lstWidgetDx;
  final Widget? _appBarContent;
  final BuildContext _context;

  @override 
  late final Size preferredSize;
  
  BackdropAppbarDefault({
      super.key, 
      required BuildContext context,
      num percHeight = 4,
      // this.primaryColor = Colors.blue,
      // this.secondaryColor = Colors.pink,
      // this.primaryColor = const Color.fromARGB(0, 38, 50, 56),
      // this.secondaryColor = const Color.fromARGB(0, 33, 149, 243),
      bool showIconSx = true,
      IconButton? iconSx,
      String? txtLabel,
      Widget? appBarContent, 
      IconButton? iconDx,
      PopupMenuButton<dynamic>? popupMenuButton,
      List<Widget> lstWidgetDx = const []
  }) : _context = context, _appBarContent = appBarContent, _lstWidgetDx = lstWidgetDx, _popupMenuButton = popupMenuButton, _txtLabel = txtLabel, _iconDx = iconDx, _iconSx = iconSx, _showIconSx = showIconSx, _percHeight = percHeight {
    preferredSize = Size.fromHeight((MediaQuery.of(_context).size.height * _percHeight / 100));
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(
        MediaQuery.of(context).size.width, 
        (MediaQuery.of(context).size.height * 5 / 100)
      ),
      child: Container(
        // height: MediaQuery.of(context).size.height * percHeight / 100,
        alignment: const Alignment(-0.9, 0.0),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: <Color>[primaryColor!, secondaryColor!],
        //     tileMode: TileMode.clamp,
        //     begin: Alignment.centerLeft,
        //     // colors: <Color>[Colors.blue, Color.fromARGB(115, 0, 143, 88)],
        //   ),
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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