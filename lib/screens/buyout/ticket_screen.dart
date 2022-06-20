import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Order.dart';
import 'package:cine_view/models/Room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'dart:math';

class TicketScreen extends StatefulWidget {
  final Movie movie;
  final List<String> seats;
  final String day;
  final Room room;
  final Order order;
  final String schedule;
  const TicketScreen(
      this.movie, this.seats, this.day, this.schedule, this.room, this.order);
  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final CineService _cineService = CineService();
  List<String> tarjetas = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TicketWidget(
              width: 350,
              height: 500,
              isCornerRounded: true,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              child: TicketData(),
            ),
          ],
        ),
      ),
    );
  }

  Widget TicketData() {
    String title = widget.movie.name;
    Iterable<int> seats = widget.seats.map((e) => int.parse(e.substring(1)));
    int minSeat = seats.reduce((curr, next) => curr < next ? curr : next);
    int maxSeat = seats.reduce((curr, next) => curr > next ? curr : next);

    return Container(
      child: Column(
        //rossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 120,
                  height: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 1,
                        color: Color(0xff4353AB),
                      )),
                  child: Center(
                      child: Text(
                    'Entrada de cine',
                    style: TextStyle(color: Color(0xff4353AB)),
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 135,
                  height: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 1,
                        color: Color(0xff4353AB),
                      )),
                  child: Center(
                      child: Text(
                    'comprobante pago',
                    style: TextStyle(color: Color(0xff4353AB)),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Icon(
                  Icons.movie_filter,
                  color: Color(0xff4353AB),
                ),
              ),
              Text(
                '$title',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.movie_filter,
                  color: Color(0xff4353AB),
                ),
              ),
            ],
          ),
          Image(
            height: 200,
            width: 340,
            image: NetworkImage(widget.movie.img),
            fit: BoxFit.fill,
          ),
          Divider(thickness: 1.5),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Fecha',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  Text(
                    widget.day,
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Sala',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  Text(
                    widget.room.number.toString(),
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Hora',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  Text(
                    widget.schedule,
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Letra',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  Text(
                    widget.seats.first[0],
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Precio',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  Text(
                    widget.order.price.toString(),
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Asientos',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  Text(
                    minSeat.toString() + ' - ' + maxSeat.toString(),
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Image(
            height: 45,
            width: 250,
            image: NetworkImage(
                'https://static.vecteezy.com/system/resources/previews/001/199/360/original/barcode-png.png'),
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
