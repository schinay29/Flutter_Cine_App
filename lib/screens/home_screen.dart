import 'package:flutter/material.dart';
import '../Services/CineService.dart';
import './user_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('home screen'),
      ),
    );
  }
}
