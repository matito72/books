import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final num percHeight;
  final Color secondaryColor;
  final bool showIconSx;
  final IconButton? iconSx;
  final IconButton? iconDx;
  final String? txtLabel;
  final PopupMenuButton? popupMenuButton;
  final List<IconButton> lstIconButtonDx;
  // final Widget appBarContent;
  final BuildContext context;

  @override 
  late final Size preferredSize;

  AppBarDefault({
      super.key, 
      required this.context,
      // required this.appBarContent, 
      this.percHeight = 4,
      this.secondaryColor = Colors.pink,
      this.showIconSx = true,
      this.iconSx,
      this.txtLabel,
      this.iconDx,
      this.popupMenuButton,
      this.lstIconButtonDx = const []
  }) {
    preferredSize = Size.fromHeight((MediaQuery.of(context).size.height * percHeight / 100));
  }

  @override
  Widget build(BuildContext context) {    
    final goBackIconButton = IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: MediaQuery.of(context).size.height * percHeight / 100,
        alignment: const Alignment(-0.9, 0.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.blue, secondaryColor],
            // colors: <Color>[Colors.blue, Color.fromARGB(115, 0, 143, 88)],
          ),
        ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showIconSx
                ? iconSx ?? goBackIconButton
                : const Text('\t\t\t'),
              Expanded(
                child: Container(
                  // color: Colors.white,
                  child: (txtLabel != null)
                    ? Text(txtLabel!)
                    : const TextField(decoration: InputDecoration(hintText: "Search",contentPadding: EdgeInsets.all(10),),),
                ),
              ),
              iconDx ?? const Text(''),
              popupMenuButton ?? const Text(''),
              lstIconButtonDx.isNotEmpty 
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: lstIconButtonDx,
                ) 
                : const Text(''),
            ]
          ),
      )
    );
  }
  

}