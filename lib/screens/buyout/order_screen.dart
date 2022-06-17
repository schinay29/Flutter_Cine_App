import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OrderScreen extends StatefulWidget {
  final Movie movie;
  const OrderScreen(this.movie);
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final CineService _cineService = CineService();
  List<String> tarjetas = [];
  var imagenPrueba =
      'https://www.cinemascomics.com/wp-content/uploads/2022/04/poster-doctor-strange-en-el-multiverso-de-la-locura-5.jpg';

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
            _buildDetails(),
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
            image: NetworkImage(imagenPrueba), fit: BoxFit.fill),
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

  Widget _buildDetails() {
    return Container(
      child: Column(
        children: [
          //(tarjetas == null)? _addPayMethod(): _showPayMethod(),
          _showPayMethod(),
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
}
