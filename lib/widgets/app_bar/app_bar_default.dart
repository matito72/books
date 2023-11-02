import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final num percHeight;
  final Widget appBarContent;
  final BuildContext context;
  final Color secondaryColor;

  @override 
  late final Size preferredSize;

  AppBarDefault({
      super.key, 
      required this.context,
      required this.appBarContent, 
      this.percHeight = 4,
      this.secondaryColor = Colors.pink
  }) {
    preferredSize = Size.fromHeight((MediaQuery.of(context).size.height * percHeight / 100));
  }

  @override
  Widget build(BuildContext context) {    
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.blue, secondaryColor],
            // colors: <Color>[Colors.blue, Color.fromARGB(115, 0, 143, 88)],
          ),
        ),
        child: appBarContent
      )
    );
  }
  
  // @override
  // Size get preferredSize => throw UnimplementedError();
  
}