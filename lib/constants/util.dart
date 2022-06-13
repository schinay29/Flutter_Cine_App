import 'package:cine_view/screens/movies/List.dart';
import 'package:flutter/material.dart';
import 'package:cine_view/theme/theme_colors.dart';

showMessage(BuildContext context, String contentMessage) {
  Widget yesButton = FlatButton(
    child: const Text("OK", style: TextStyle(color: primary)),
    onPressed: () {
      Navigator.pop(context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ListMovie()),
          (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Message"),
    content: Text(contentMessage),
    actions: [
      yesButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
