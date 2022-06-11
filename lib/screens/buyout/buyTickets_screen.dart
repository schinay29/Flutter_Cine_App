import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Room.dart';
import 'package:cine_view/models/RoomMovie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group_button/group_button.dart';

class BuyTicketsScreen extends StatefulWidget {
  @override
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  CineService _cineService = new CineService();
  List<RoomMovie> movieSesions = [];
  List<int> buySeats = [];
  Room room = Room('0', '0', '0', '0', '0');
  //late Room room;
  List<RoomMovie> scheduleList = [];

  //late Future<List<RoomMovie>> movieSesions;
  int movieId = 2;
  String selectedDay = 'lunes';
  String selectedSchedule = '20:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  _loadData() async {
    print('prueba: ' + movieSesions.length.toString());
    await _cineService
        .getSession(movieId)
        .then((value) => {movieSesions = value });

        
    // if (this.movieSesions.length == 0) print(movieSesions);
    // await _cineService
    //     .getRoomSeat(int.parse(movieSesions.first.roomId))
    //     .then((value) => {room = value, print('value; ' + room.col)});
    //     print(room.col);
    // await _cineService
    //     .getBuySeats(int.parse(movieSesions.first.id))
    //     .then((value) => buySeats = value);
    print(buySeats);
  }

  _loadExtra() async {
    if (this.movieSesions.length == 0) return print('failed');
    await _cineService
        .getRoomSeat(int.parse(movieSesions[0].roomId))
        .then((value) => {room = value, print('value; ' + room.col)});
        print(room.col);
    await _cineService
        .getBuySeats(int.parse(movieSesions.first.id))
        .then((value) => buySeats = value);
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
            if (snapshot.connectionState == ConnectionState.done) _loadExtra();
            // var dayList =
            //     movieSesions.map((e) => e.day.toString()).toSet().toList();
            var schedule = movieSesions
                .where((data) => data.day.toLowerCase().contains(selectedDay))
                .map((e) => e.schedule)
                .toList();
            // child:
            return Column(
              children: [
                //_build days
                _buildDates(),
                //build schedule
               _buildSchedule(),
                //_buildSeats(),
                _buildSeats(),
                

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

                // build days
                // Container(
                //   width: 60,
                //   height: 60,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     color: Colors.white30,
                //   ),
                //   child: Text("1"),
                // ),
                // _buildDates(),
                //SizedBox(height: 20.0),
                //_buildSchedule(),
                //SizedBox(height: 20.0),
                //_loadData(),
                //_buildSeats(),
                // Positioned(
                //   top: 30,
                //   child: IconButton(
                //     onPressed: () => Navigator.pop(context),
                //     icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.green,)),
                // )
              ],
            );
          }),
    );
  }

  Widget _buildDates() {
    var dayList = movieSesions.map((e) => e.day.toString()).toSet().toList();

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
    var scheduleList = movieSesions
                .where((data) => data.day.toLowerCase().contains(selectedDay))
                .map((e) => e.schedule)
                .toList();
    
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
                            color:
                                Column == buySeats ? Colors.red : Colors.black,
                            height: 20,
                            width: 20,
                          ));
                    }),
                  ),
                );
      // child: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       ...List.generate(int.parse(room.col), (Column) {
      //         return Padding(
      //           //padding: const EdgeInsets.all(5.0),
      //           padding: const EdgeInsets.all(1.0),
      //           child: Wrap(
      //             direction: Axis.horizontal,
      //             children: [
      //               ...List.generate(int.parse(room.row), (Row) {
      //                 print(Column);
      //                 return Padding(
      //                     padding: const EdgeInsets.only(left: 5.0),
      //                     child: Container(
      //                       color:
      //                           Column == buySeats ? Colors.red : Colors.black,
      //                       height: 30,
      //                       width: 30,
      //                     ));
      //               }, growable: true)
      //             ],
      //           ),
      //         );
      //       }),
      //     ],
      //   ),
      // ),
    
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
