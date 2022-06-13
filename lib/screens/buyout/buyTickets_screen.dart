import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Room.dart';
import 'package:cine_view/models/Session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group_button/group_button.dart';
import 'dart:convert';

class BuyTicketsScreen extends StatefulWidget {
  @override
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  CineService _cineService = new CineService();
  Sessions movieSesions =
      new Sessions(new Movie(0, '', '', '', 0, '', '', 0), []);
  List<int> buySeats = [];
  int movieId = 2;
  String selectedDay = 'lunes';
  String selectedSchedule = '20:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _loadData() async {
    await _cineService
        .getSession(movieId)
        .then((value) => {movieSesions = value});
  }

  _loadExtra() async {
    print('in loadextra()');
    //if (this.movieSesions.length == 0) return print('failed');
    // await _cineService
    //     .getRoomSeat(movieSesions[0].roomId)
    //     .then((value) => {room = value});
    //     print('roomcol: ' + room.col.toString());
    // await _cineService
    //     .getBuySeats(movieSesions[0].id)
    //     .then((value) => buySeats = value);
    //     print('buyseats: ' + buySeats.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(15.0),
      child: FutureBuilder<dynamic>(
          future: _loadData(),
          builder: (context, snapshot) {
            while (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            if (snapshot.connectionState == ConnectionState.done) print('done');

            return Column(
              children: [
                _buildDates(),
                SizedBox(
                  height: 20,
                ),
                _buildSchedule(),
                SizedBox(
                  height: 10,
                ),
                _buildSeats(),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => BuyTicketsScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                            "Completar Compra".toUpperCase(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // OutlinedButton(
                //   onPressed: () {},
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       children: [
                //         Text("hola"),
                //         Text(dayList[0])
                //       ],
                //     ),
                //   )
                // ),
              ],
            );
          }),
    );
  }

  Widget _buildDates() {
    //var dayList = movieSesions.schedules.map((e) => e.day.toString()).toSet().toList();
    List<String> dayList = [];
    movieSesions.detailSessions.forEach(
        (e) => dayList.add(e.schedules.map((e) => e.day.toString()).first));

    return Container(
      height: 60.0,
      child: GroupButton(
        isRadio: true,
        onSelected: (i, selected, bol) => debugPrint('Button #$i $selected'),
        options: GroupButtonOptions(
          buttonHeight: 60,
          buttonWidth: 50,
          borderRadius: BorderRadius.circular(8.0),
          spacing: 10,
          elevation: 0,
          selectedColor: Colors.pink[100],
          unselectedColor: Colors.amber[100],
          selectedBorderColor: Colors.pink[900],
          unselectedBorderColor: Colors.amber[900],
        ),
        buttons: dayList,
      ),
    );
  }

  Widget _buildSchedule() {
    List<String> scheduleList = [];
    for (DetailSession d in movieSesions.detailSessions) {
      d.schedules
          .where((e) => e.day.toLowerCase().contains(selectedDay))
          .forEach((e) => e.schedule.forEach((e) => scheduleList.add(e)));
    }

    return Container(
      height: 30.0,
      child: GroupButton(
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
        //buttons: ["12:00", "13:00", "14:30", "18:00", "19:00", "21:40"],
        buttons: scheduleList,
      ),
    );
  }

  Widget _buildSeats() {
    var prueba = movieSesions.detailSessions
        .map((e) => e.schedules.where((e) =>
            e.day == selectedDay && e.schedule.contains(selectedSchedule)))
        .first;
    print('var prueba: ' + prueba.first.toString());

    return Container(
      height: 250,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10.0,
        crossAxisCount: 5,
        children: List.generate(12, (index) {
          return Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Container(
                color: Column == buySeats ? Colors.red : Colors.black,
                height: 20,
                width: 20,
              ));
        }),
      ),
    );
  }

  Widget _chip(String data, BuildContext context) => ChoiceChip(
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          data,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white, fontSize: 14),
        ),
        selectedColor: Colors.deepPurple,
        selected: true,
        elevation: 1,
        padding: EdgeInsets.symmetric(horizontal: 10),
      );
}
