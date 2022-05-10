import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/RoomMovie.dart';
import 'package:flutter/material.dart';

class BuyTicketsScreen extends StatefulWidget {
  @override
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  CineService _cineService = new CineService();

  List<RoomMovie> movieSesions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    this.loadSession();
    
  }

  loadSession() async {
    await _cineService.getSession(2).then((value) => movieSesions = value);
    print("test movie seasons");
    print(movieSesions.first.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChoiceChip(
          label: Text("prueba"),
          selected: true,
          onSelected: (bool value){},
        ),
      ),
    );
  }
}