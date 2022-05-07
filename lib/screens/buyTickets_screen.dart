import 'package:flutter/material.dart';

class BuyTicketsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChoiceChip(
          label: Text("choice chip"),
          selected: true,
          onSelected: (bool value){},
        ),
      ),
    );
  }



  List<Widget> choiceSessionDate () {
    List<Widget> chips = [];
    /*for (int i=0; i< _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left:10, right: 5),
        child: ChoiceChip(
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: _chipsList[i].color,
          selected: selectedIndex == i,
          onSelected: (bool value)
          {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }*/
    return chips;
  }
}