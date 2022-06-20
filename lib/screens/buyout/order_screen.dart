// ignore_for_file: avoid_print

import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Order.dart';
import 'package:cine_view/models/Payment.dart';
import 'package:cine_view/models/Room.dart';
import 'package:cine_view/screens/buyout/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  final Movie movie;
  final List<String> seats;
  final String day;
  final Room room;
  final String schedule;
  const OrderScreen(this.movie, this.seats, this.day, this.schedule, this.room);
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final CineService _cineService = CineService();
   var cardNumberMask = MaskTextInputFormatter(
      mask: '####  ####  ####  ####', filter: {"#": RegExp(r'[0-9]')});
  var cardDateMask =
      MaskTextInputFormatter(mask: '##-##', filter: {"#": RegExp(r'[0-9]')});
  var cardCvvMask =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  // List<String> tarjetas = [];
  Payment? card;
  var  fourLastDigits = '1234';
  double ticketPrice = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId') ?? 0;
    print('user ' + userId.toString());
    await _cineService.getDefaultCard(userId!).then((value) => 
    setState(() { 
      card = value; 
      print(value);
      if(card != null) fourLastDigits = card!.cardNumber.toString().substring(12); 
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Detalle del pedido',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            SizedBox(
              height: 6,
            ),
            _buildImage(),
            SizedBox(
              height: 16,
            ),
            (card != null) ? _showPayMethod() : _addPayMethod(),
            _showInfo(
                name: widget.movie.name,
                sesionDate: widget.day +
                    ' ' +
                    widget.schedule +
                    ', ' +
                    DateTime.now().year.toString(),
                amount: widget.seats.length),
            SizedBox(
              height: 20,
            ),
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
                        saveOrder();
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
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10, left: 15),
      width: 290,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: NetworkImage(widget.movie.img), fit: BoxFit.fill),
        color: Colors.transparent,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Color.fromARGB(33, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  Widget _addPayMethod() {
    return Container(
      margin: EdgeInsets.only(left: 7, right: 18, top: 10),
      color: Colors.white60,
      child: Column(
        children: [
          _buildTextField(paddingLeft: 18, paddingRight: 18, hintText: 'Numero de tarjeta', inputType: TextInputType.number,  mask: cardNumberMask),
          _buildTextField(paddingLeft: 18, paddingRight: 18, hintText: 'Nombre propietario', inputType: TextInputType.text,  mask: MaskTextInputFormatter()),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          _buildTextField(paddingLeft: 18, paddingRight: 18, hintText: 'Fecha exp', inputType: TextInputType.number,  mask: cardDateMask),
          _buildTextField(paddingLeft: 18, paddingRight: 18, hintText: 'Cvv', inputType: TextInputType.number,  mask: cardCvvMask),

            ],
          )

        ],
      ),
    );
  }

  Widget _showPayMethod() {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, top: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Elegir método de pago',
                style: TextStyle(fontSize: 16, color: Colors.black38),
              )),
          SizedBox(
            width: double.infinity,
            height: 90,
            child: Card(
              elevation: 0.3,
              child: Wrap(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image(
                          image: NetworkImage(
                              'https://1000marcas.net/wp-content/uploads/2019/12/Visa-Logo-2005.jpg'),
                          height: 35),
                    ],
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Tarjeta Visa Electrónica',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('****\t\t****\t\t****\t\t' + fourLastDigits),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(165, 37, 81, 135)),
                        ),
                        child: Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
    

  Widget _showInfo(
      {required String name, required String sesionDate, required int amount}) {
    //var formatDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
    return Container(
      margin: EdgeInsets.only(left: 18, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalles de la compra',
            style: TextStyle(fontSize: 16, color: Colors.black38),
          ),
          SizedBox(
            height: 6,
          ),
          Text(name),
          SizedBox(
            height: 5,
          ),
          Text(sesionDate),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(amount.toString() + ' entradas'),
              SizedBox(
                width: 250,
              ),
              Text('x 5€')
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Text(' TOTAL'),
              SizedBox(
                width: 250,
              ),
              Text((amount * ticketPrice).toString() + '€')
            ],
          ),
        ],
      ),
    );
  }

  saveOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId') ?? 0;
    int roomMovieId = 0;
    Order? order;
    int seatId = 0;

    await _cineService
        .getRoomMovie(widget.room.roomId, widget.movie.movieId, widget.schedule,
            widget.day)
        .then((value) => roomMovieId = value);
    await _cineService
        .saveOrder(new Order(0, widget.seats.length,
            ticketPrice * widget.seats.length, DateTime.now(), userId!))
        .then((value) => {
              order = value,
            });

    widget.seats.forEach((e) async => {
          await _cineService.saveSeat(roomMovieId, e).then((value) async => {
                seatId = value!,
                print(value),
                await _cineService.saveOrderSeat(
                    order!.id, seatId, ticketPrice),
              }),
        });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketScreen(widget.movie, widget.seats,
            widget.day, widget.schedule, widget.room, order!),
      ),
    );
  }

  Widget _buildTextField(
      {required double paddingLeft,
      required double paddingRight,
      required String hintText,
      required TextInputType inputType,
      required MaskTextInputFormatter mask}) {
    return SizedBox(
      // alignment: Alignment.bottomLeft,
      width: 250,
      height: 25,
      child: TextField(
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey.shade500),
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none)),
        keyboardType: inputType,
        inputFormatters: [mask],
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

}
