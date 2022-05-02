import 'package:flutter/material.dart';
import './user_screen.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('User route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserRoute()),
            );
          },
        ),
      ),
    );
  }
}
