import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final num percHeight;
  final Color? primaryColor;
  final Color? secondaryColor;
  final bool showIconSx;
  final IconButton? iconSx;
  final IconButton? iconDx;
  final String? txtLabel;
  final PopupMenuButton? popupMenuButton;
  final List<Widget> lstWidgetDx;
  final Widget? appBarContent;
  final BuildContext context;

  @override 
  late final Size preferredSize;
  
  AppBarDefault({
      super.key, 
      required this.context,
      this.percHeight = 4,
      // this.primaryColor = Colors.blue,
      // this.secondaryColor = Colors.pink,
      this.primaryColor = const Color.fromARGB(255, 38, 50, 56),
      this.secondaryColor = Colors.blue,
      this.showIconSx = true,
      this.iconSx,
      this.txtLabel,
      this.appBarContent, 
      this.iconDx,
      this.popupMenuButton,
      this.lstWidgetDx = const []
  }) {
    preferredSize = Size.fromHeight((MediaQuery.of(context).size.height * percHeight / 100));
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: MediaQuery.of(context).size.height * percHeight / 100,
        alignment: const Alignment(-0.9, 0.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[primaryColor!, secondaryColor!],
            tileMode: TileMode.clamp,
            begin: Alignment.centerLeft,
            // colors: <Color>[Colors.blue, Color.fromARGB(115, 0, 143, 88)],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showIconSx
              ? iconSx ?? IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : const Text('\t\t\t'),
            Expanded(
              child: Container(
                child: (txtLabel != null && appBarContent == null)
                  ? Text(
                    txtLabel!,
                    overflow: TextOverflow.ellipsis,
                  )
                  : (appBarContent != null)
                    ? appBarContent!
                    : const Text('')
              ),
            ),
            iconDx ?? const Text(''),
            popupMenuButton ?? const Text(''),
            lstWidgetDx.isNotEmpty 
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lstWidgetDx,
              ) 
              : const Text(''),
          ]
        ),
      )
    );
  }
  

}