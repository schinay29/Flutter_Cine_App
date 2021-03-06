import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Room.dart';
import 'package:cine_view/models/Session.dart';
import 'package:cine_view/screens/buyout/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class BuyTicketsScreen extends StatefulWidget {
  final Movie movie;
  const BuyTicketsScreen(this.movie);
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  //bool isLoading = false;
  final CineService _cineService = CineService();
  Sessions? movieSesions;
  List<int> buySeats = [];
  List<String> letter = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  String? selectedDay;
  String? selectedSchedule;
  Room? room;
  List<String> selectList = [];
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    await _cineService.getSession(widget.movie.movieId).then((value) => {
          setState(() {
            movieSesions = value;
          }),
          print(value)
        });
    selectedDay =
        movieSesions?.detailSessions.first.schedules.first.day.toString();
    room = movieSesions?.detailSessions.first.room;
    //_cineService.getBuySeats(sessionId)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(16),
            child: Text("Elegir horario",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54)),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _buildDates(),
        const SizedBox(
          height: 20,
        ),
        _buildSchedule(),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(16),
            child: Text("Elegir asientos",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54)),
          ),
        ),
        Column(
          children:
              List<Widget>.generate(room != null ? room!.row : 0, (int index) {
            return Container(
              child: _buildSeats(letter: letter[index]),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.25), // border color
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2), // border width
                        child: Container(
                          // or ClipRRect if you need to clip the content
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff4353AB), // inner circle color
                          ),
                          child: Container(), // inner content
                        ),
                      ),
                    ),
                    Text("Asientos libres", textAlign: TextAlign.left),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.25), // border color
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2), // border width
                        child: Container(
                          // or ClipRRect if you need to clip the content
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(
                                255, 162, 187, 196), // inner circle color
                          ),
                          child: Container(), // inner content
                        ),
                      ),
                    ),
                    Text(
                      "Asientos reservados",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 85,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 13.5, right: 13),
              width: MediaQuery.of(context).size.width / 1.09,
              child: Expanded(
                child: SizedBox(
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(
                              movieSesions!.movie,
                              selectList,
                              selectedDay.toString(),
                              selectedSchedule.toString(),
                              room!),
                        ),
                      );
                    },
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
            ),
          ],
        ),
      ],
    ));
  }

  Widget _buildDates() {
    //var dayList = movieSesions.schedules.map((e) => e.day.toString()).toSet().toList();
    List<dynamic> prueba = [];
    for (var e in (movieSesions != null) ? movieSesions!.detailSessions : []) {
      // dayList.add(e.schedules.map((e) => e.day.toString()).first);
      for (var x in e.schedules) {
        prueba.add(x.day.toString());
      }
      // e.schedules.foreach((y) => dayList.add(e.day.first));
    }

    List<String> dayList = prueba.map((e) => e.toString()).toSet().toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // height: 78.0,
      child: GroupButton(
        isRadio: true,
        onSelected: (i, selected, bol) => {
          debugPrint('Button #$i $selected'),
          setState(() {
            selectedDay = i.toString();
          })
        },
        options: GroupButtonOptions(
          buttonHeight: 75,
          buttonWidth: 62,
          borderRadius: BorderRadius.circular(8.0),
          spacing: 10,
          elevation: 0,
          selectedColor: Color(0xff4353AB),
          unselectedColor: Color.fromARGB(255, 162, 187, 196),
          selectedBorderColor: Color(0xff4353AB),
          unselectedBorderColor: Color.fromARGB(255, 162, 187, 196),
        ),
        buttons: dayList,
      ),
    );
  }

  Widget _buildSchedule() {
    List<String> scheduleList = [];
    for (DetailSession d
        in movieSesions != null ? movieSesions!.detailSessions : []) {
      d.schedules
          .where((e) => e.day.toLowerCase().contains(selectedDay!))
          .forEach((e) => e.schedule.forEach((e) => scheduleList.add(e)));
    }

    return SizedBox(
      height: 30.0,
      child: GroupButton(
        isRadio: true,
        onSelected: (i, selected, bol) => {
          setState(() {
            selectedSchedule = i.toString();
          }),
          debugPrint('Button #$i $selected')
        },
        options: GroupButtonOptions(
          buttonHeight: 30,
          buttonWidth: 65,
          borderRadius: BorderRadius.circular(8.0),
          spacing: 10,
          elevation: 0,
          selectedColor: Color(0xff4353AB),
          unselectedColor: Color.fromARGB(255, 162, 187, 196),
          selectedBorderColor: Color(0xff4353AB),
          unselectedBorderColor: Color.fromARGB(255, 162, 187, 196),
        ),
        //buttons: ["12:00", "13:00", "14:30", "18:00", "19:00", "21:40"],
        buttons: scheduleList,
      ),
    );
  }

  Widget _buildSeats({required String letter}) {
    return Wrap(
      children: List<Widget>.generate(
        room != null ? room!.col : 0,
        (int index) {
          return Container(
            margin: EdgeInsets.all(0.2),
            child: ChoiceChip(
              selectedColor: Color(0xff4353AB),
              elevation: 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              label: Text(''),
              selected: selectList.contains(letter + index.toString()),
              onSelected: (bool selected) {
                setState(() {
                  //_value = (selected ? index : null)!;
                  selected
                      ? selectList.add(letter + index.toString())
                      : selectList.remove(letter + index.toString());
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
