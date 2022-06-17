import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Session.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class BuyTicketsScreen extends StatefulWidget {
  final Movie movie;
  const BuyTicketsScreen(this.movie);
  _BuyTicketsScreenState createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  //bool isLoading = false;
  final CineService _cineService = CineService();
  Sessions? movieSesions;
  List<int> buySeats = [];
  String selectedDay = 'lunes';
  String selectedSchedule = '20:00';
  @override
  void initState() {
    super.initState();
  }

  _loadData() async {
    await _cineService
        .getSession(widget.movie.movieId)
        .then((value) => {movieSesions = value});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: _loadData(),
            builder: (context, snapshot) {
              while (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done)
                print('done');

              return Column(
                children: [
                  _buildDates(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildSchedule(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildSeats(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            color: Colors.blue,
                            onPressed: () {},
                            child: Text(
                              "Completar Compra".toUpperCase(),
                              style: const TextStyle(
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
      ),
    );
  }

  Widget _buildDates() {
    //var dayList = movieSesions.schedules.map((e) => e.day.toString()).toSet().toList();
    List<String> dayList = [];
    for (var e in (movieSesions != null)? movieSesions!.detailSessions: []) {
      dayList.add(e.schedules.map((e) => e.day.toString()).first);
    }

    return SizedBox(
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
    for (DetailSession d in movieSesions!= null? movieSesions!.detailSessions: []) {
      d.schedules
          .where((e) => e.day.toLowerCase().contains(selectedDay))
          .forEach((e) => e.schedule.forEach((e) => scheduleList.add(e)));
    }

    return SizedBox(
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
    // var prueba = movieSesions!.detailSessions
    //     .map((e) => e.schedules.where((e) =>
    //         e.day == selectedDay && e.schedule.contains(selectedSchedule)))
    //     .first;

    return SizedBox(
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
        labelPadding: const EdgeInsets.all(2.0),
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
      );
}
