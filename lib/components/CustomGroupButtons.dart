import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class CustomGroupButtons extends StatelessWidget {
  final List<Object?> TextList;
  final int btnHeight;
  final int btnWidth;
  final double btnRadius;
  final Color? btnSelectedColor;
  final Color? btnUnselectedColor;

const CustomGroupButtons(
  {
    required this.TextList,
    required this.btnHeight,
    required this.btnWidth,
    required this.btnRadius,
    required this.btnSelectedColor,
    required this.btnUnselectedColor
  });


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Wrap(
      children: [
        GroupButton(
          isRadio: true,
          onSelected: (i, selected, bol) => debugPrint('Button #$i $selected'),
          options: GroupButtonOptions(
            buttonHeight: 30,
            buttonWidth: 65,
            borderRadius: BorderRadius.circular(8.0),
            spacing: 10,
            elevation: 0,
            selectedColor: Colors.pink[100],
            unselectedColor: Colors.amber[100],
            selectedBorderColor: Colors.pink[900],
            unselectedBorderColor: Colors.amber[900],
          ),
          buttons: TextList,
        ),
      ],
    );
  }
  
}
