import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Session.dart';
import 'package:cine_view/screens/moviedetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyCardsScreen extends StatefulWidget {
  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  CineService _cineService = new CineService();
  List<Object?> cards = [];
  final cardName = TextEditingController();
  final cardNumber = TextEditingController();
  final cardCvv = TextEditingController();
  final cardExpiration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
        // height: 200,
        // child: FutureBuilder(
        //   // future: _cineService.getSession(2),
        //   future: _cineService.getMovies(),
        //   builder: (context,  AsyncSnapshot<List<Movie>> snapshot) {
        //     while (snapshot.connectionState == ConnectionState.waiting)
        //       return CircularProgressIndicator();
        //     if (snapshot.connectionState == ConnectionState.done){
        //       if (snapshot.hasData) {
        //         if (snapshot.data != null) movies = snapshot.data!;
        //       }
        //     }
        //     return Column(
        //       children: [
        //         _buildRecentMovies(),
        //         _buildPageIndicator(),
        //         SizedBox(height: 40,),
        //         SingleChildScrollView(
        //           scrollDirection: Axis.horizontal,

        //         child: Row(

        //           children: List.generate(movies.length, ((index) => _buildAllMovies(movies[index]))),
        //         )

        //         )
        //       ],
        //     );
        // },)
        reverse: true,

        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              'Mis Tarjetas',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 12,
            ),
            _buildCards(),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 20),
            //   alignment: Alignment.topLeft,
            //   child: Text('AÑADIR TARJETA', style: TextStyle(fontSize: 18, color: Colors.grey.shade600), textAlign: TextAlign.end,),
            //   // child: Text('hola'),
            // ),
            // Divider(),
            SizedBox(
              height: 10,
            ),

            _buildTextField(
                paddingLeft: 15,
                paddingRight: 15,
                hintText: 'Propietario de la tarjeta',
                inputType: TextInputType.name,
                controller: cardName),
            _buildTextField(
                paddingLeft: 15,
                paddingRight: 15,
                hintText: 'Número de la tarjeta',
                inputType: TextInputType.number,
                controller: cardNumber),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                      paddingLeft: 15,
                      paddingRight: 10,
                      hintText: 'Fecha caducidad',
                      inputType: TextInputType.datetime,
                      controller: cardExpiration),
                ),
                Expanded(
                  child: _buildTextField(
                      paddingLeft: 10,
                      paddingRight: 15,
                      hintText: 'CVV',
                      inputType: TextInputType.number,
                      controller: cardCvv),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(
                  width: 35,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.blue,
                      onPressed: () {
                        print('card payment object: '+ cardName.text);
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(builder: (context) => BuyTicketsScreen()),
                        //   (Route<dynamic> route) => false);
                        //Navigator.pushNamed(context, '/second');
                      },
                      child: Text(
                        "Añadir método de pago".toUpperCase(),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 35,
                )
              ],
            ),
            //Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
          ],
        ),
      ),
    );
  }

  // Widget _buildCards() {
  //   return CarouselSlider(
  //     options: CarouselOptions(height: 250.0,
  //     aspectRatio: 16/9,
  //     viewportFraction: 0.6,
  //     enlargeCenterPage: true,
  //      onPageChanged: ( index, reason ) => {
  //               print(index),
  //               // setState(() {
  //               // _currentPage = index;

  //               // })
  //           },),
  //     items: cards.map((i) {
  //       return Builder(
  //         builder: (BuildContext context) {
  //           return Container(
  //             //width: 200,
  //             width: MediaQuery.of(context).size.width,
  //             margin: EdgeInsets.symmetric(horizontal: 0),
  //             decoration: BoxDecoration(
  //               image:DecorationImage(
  //               fit: BoxFit.cover
  //               ),
  //               color: Colors.amber,
  //               borderRadius: BorderRadius.circular(10.0)),
  //             child: GestureDetector(
  //                       onTap: () {
  //                         //print('tap '+ i.movieId.toString());

  //                         Navigator.of(context).pushAndRemoveUntil(
  //                           MaterialPageRoute(builder: (context) => DetailScreen(i)),
  //                           (Route<dynamic> route) => false);
  //                       }
  //             )
  //           );
  //         },
  //       );
  //     }).toList(),
  //   );
  // }

  Widget _buildCards() {
    var fourLastDigits = '4444';
    return Container(
      height: 195,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: SweepGradient(
          center: AlignmentDirectional(1, -1),
          startAngle: 1.7,
          endAngle: 3,
          colors: const <Color>[
            Color(0xff148535),
            Color(0xff148535),
            Color(0xff0D6630),
            Color(0xff0D6630),
            Color(0xff148535),
            Color(0xff148535),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VISA',
                style: TextStyle(
                    fontSize: 24.30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Visa electrónica',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          Text(
            "\t****\t\t****\t\t****\t\t****\t\t ${fourLastDigits}",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Titular tarjeta',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'nOMBRE TITULAR',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fecha caducidad',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'insertar fecha caducidad',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required double paddingLeft,
      required double paddingRight,
      required String hintText,
      required TextInputType inputType, 
      required TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        top: 20,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: TextField(
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey.shade500),
            fillColor: Colors.grey.shade100,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none)),
        keyboardType: inputType,
        controller: controller,
      ),
    );
  }
}
