import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

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
  List<String> tarjetas = [];
  

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
            _showPayMethod(),
            _showInfo(name: widget.movie.name, sesionDate: widget.day + ' '+widget.schedule + ', ' + DateTime.now().year.toString(), amount: widget.seats.length),
            SizedBox(height: 20,),
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
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) => OrderScreen(movieSesions!.movie, selectList, selectedDay.toString(), selectedSchedule.toString(), room!),
                    // ),
                    // );
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
    return Container();
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
                      Text('****\t\t****\t\t****\t\t' + '1234'),
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

  Widget _showInfo({required String name, required String sesionDate, required int amount}) {
    //var formatDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
    return Container(
      margin: EdgeInsets.only(left: 18, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detalles de la compra', style: TextStyle(fontSize: 16, color: Colors.black38),),
          SizedBox(height: 6,),
          Text(name),
          SizedBox(height: 5,),
          Text(sesionDate),
          SizedBox(height: 5,),
          Row(
            children: [SizedBox(width: 15,), Text(amount.toString() + ' entradas'), SizedBox(width: 250,), Text('x 5€')],
          ),
          SizedBox(height: 5,),
          Row(
            children: [SizedBox(width: 25,), Text(' TOTAL'), SizedBox(width: 250,), Text((amount * 5).toString() + '€')],
          ),

        ],
      ),
    );
  }
}
