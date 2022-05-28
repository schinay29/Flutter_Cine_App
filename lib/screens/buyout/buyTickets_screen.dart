import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Room.dart';
import 'package:cine_view/models/RoomMovie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BuyTicketsScreen extends StatefulWidget {
  @override
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  CineService _cineService = new CineService();
  List<RoomMovie> movieSesions = [];
  List<int> buySeats = [];
  Room room = Room('1', '1', '1', '1', '1');
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
    //_loadData();
  }

   _loadData() async {
    print('prueba: ' + movieSesions.length.toString());
    if(this.movieSesions.length == 0) print(movieSesions);
    await _cineService.getRoomSeat(int.parse(movieSesions[0].roomId)).then((value) => room = value);
    await _cineService.getBuySeats(int.parse(movieSesions.first.id)).then((value) => buySeats = value);
    print(buySeats);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(15.0),
      child: FutureBuilder<List<RoomMovie>>(
          future: _cineService.getSession(movieId),
          builder:(context, snapshot) {
            while (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            if (snapshot.connectionState == ConnectionState.done)
                movieSesions = snapshot.data!;
                  
            child:
            return Column(
              children: [
                _buildDates(),
                SizedBox(height: 20.0),
                _buildSchedule(),
                //SizedBox(height: 20.0),
                //_loadData(),
                _buildSeats(),
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

  // Widget _buildSchedule() {
  //   // get all distinct days
  //   var dayList = movieSesions.map((e) => e.day.toString()).toSet().toList();
  //   //movieSesions.retainWhere((x) => list.add(x.day));
  //   return Wrap(
  //     direction: Axis.horizontal,
  //     alignment: WrapAlignment.center,
  //     children: List<Widget>.generate(
  //       dayList.length,
  //       (int index) {
  //         return ChoiceChip(
  //           visualDensity: VisualDensity(horizontal: 0.0, vertical: 4),
  //           label: Text(dayList[index]),
  //           selected: false,
  //           onSelected: (bool value) {
  //             String b = "2";
  //             String v = dayList[index];

  //             print("select ${movieSesions[index].day}");
  //             //  const ChoiceChip(label: Text("{b}"), selected: true);
  //           },
  //         );
  //       },
  //     ).toList(),
  //   );
  // }

  Widget _buildDates() {
    var dayList = movieSesions.map((e) => e.day.toString()).toSet().toList();
    return Container(
      height: 60.0,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: dayList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                  selectedDay = dayList[index];
                  scheduleList = movieSesions.where((data) => data.day.toLowerCase().contains(selectedDay)).toList();
                  });
                  print("Tapped a Container");
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height / 7,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromARGB(255, 50, 50, 219),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 6)),
                      Text('4'),
                      Text(dayList[index]),
                    ],
                  ),
                ));
          }),
    );
  }

  Widget _buildSchedule() {
    scheduleList = movieSesions
        .where((data) => data.day.toLowerCase().contains(selectedDay))
        .toList();
    return Container(
      height: 30.0,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: scheduleList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  print("Tapped a Container");
                  setState(() {
                   // _loadData();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 4),
                  height: MediaQuery.of(context).size.height / 5,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromARGB(108, 238, 243, 210),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(scheduleList[index].schedule),
                    ],
                  ),
                ));
          }),
    );
  }

  Widget _buildSeats() {
    return Expanded(
      child: FutureBuilder<dynamic>(
      future: _loadData(),
      builder: (context, snapshot) {
        while (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        //if (snapshot.connectionState == ConnectionState.done)
         //if(snapshot.hasData) room = snapshot.data?? Room('', '', '', '', '') ;
        
        return Column(children: [
          //Text(seat);
          ...List.generate(int.parse(room.col), (Column) {
            return Padding(
              //padding: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(1.0),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  ...List.generate(int.parse(room.row), (Row) {
                    print(Column);
                    return Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          color: Column == buySeats ?Colors.red: Colors.black,
                          height: 30,
                          width: 30,
                        ));
                  } , growable: true)
                ],
              ),
            );
          }),
        ]);
      }
    ));
  }

  
}
