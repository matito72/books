import 'package:flutter/material.dart';

class IconCheckItem extends StatelessWidget {
  final double _heightBox;  
  final Function _onPressed;
  final bool _isItemSel;
  final Icon _selectedIcon;

  const IconCheckItem({
    super.key, 
    required heightBox, 
    required onPressed,
    required bool isItemSel,
    required Icon selectedIcon
  }) : _heightBox = heightBox, _onPressed = onPressed, _isItemSel = isItemSel, _selectedIcon = selectedIcon;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 20 / 100),
      height: _heightBox,
      child: Visibility(
        maintainSize: true, 
        maintainAnimation: true,
        maintainState: true,
        visible: _isItemSel,
        child: IconButton(
          alignment: Alignment.topRight,  
          onPressed: () => {
            _onPressed()
          },
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.blueGrey[100],
          ),
          selectedIcon: _selectedIcon,
          iconSize: 50,
          enableFeedback: true,
          isSelected: _isItemSel,
        ),
      ),
    );
  }
}