import 'package:cine_view/Services/CineService.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final CineService _cineService = CineService();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),

    );
  }
}