import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cine_view/constants/base_api.dart';
import 'package:cine_view/constants/util.dart';
import 'package:cine_view/theme/theme_colors.dart';
import 'package:http/http.dart' as http;

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _controllerFullName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creation User"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerFullName,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "FullName",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerEmail,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Email",
          ),
        ),
        SizedBox(
          height: 40,
        ),
        FlatButton(
            color: primary,
            onPressed: () {
              createNewUser();
            },
            child: Text(
              "Done",
              style: TextStyle(color: white),
            ))
      ],
    );
  }

  createNewUser() async {
    var fullname = _controllerFullName.text;
    var email = _controllerEmail.text;
    if (fullname.isNotEmpty && email.isNotEmpty) {
      var url = BASE_API + "User";
      var bodyData = json.encode({
        "name": "Hannah2",
        "email": "hananh2@test.com",
        "password": "123456789",
        "rol": "admin",
        "phone": "639416250"
      });
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200) {
        var message = json.decode(response.body)['name'];
        showMessage(context, message);
        setState(() {
          _controllerFullName.text = "";
          _controllerEmail.text = "";
        });
      } else {
        var messageError = "Can not create new user!!";
        showMessage(context, messageError);
      }
    }
  }
}
