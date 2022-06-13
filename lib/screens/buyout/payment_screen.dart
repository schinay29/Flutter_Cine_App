import 'package:cine_view/Services/CineService.dart';
import 'package:flutter/material.dart';


class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final CineService _cineService = CineService();
  List<Object?> cards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text('Finalizar Compra', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(height: 7,),
            const Divider(),
            const SizedBox(height: 7,),
            _buildCards(),
            const SizedBox(height: 20,),
            _orderDetail(),
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
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const SweepGradient(
          center: AlignmentDirectional(1, -1),
          startAngle: 1.7,
          endAngle: 3,
          colors: <Color>[
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
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('VISA', style: TextStyle(fontSize: 24.30, fontWeight: FontWeight.bold, color: Colors.white),), 
              Text('Visa electrónica', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),), 
            ],
          ),
          Text("\t****\t\t****\t\t****\t\t****\t\t $fourLastDigits", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),), 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Titular tarjeta', style: TextStyle(fontSize: 12, color: Colors.white),),
                        SizedBox(height: 10,),
                        Text('nOMBRE TITULAR', style: TextStyle(fontSize: 12, color: Colors.white),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Fecha caducidad', style: TextStyle(fontSize: 12, color: Colors.white),),
                        SizedBox(height: 10,),
                        Text('insertar fecha caducidad', style: TextStyle(fontSize: 12, color: Colors.white),),
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

 Widget _orderDetail() {

       return Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top:20),
          alignment: Alignment.topLeft,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detalles del pedido', style: TextStyle(fontSize: 20, color: Colors.grey.shade600)),
                  const SizedBox(height: 10,),
                  const Text('NOMBRE PELICULA'),
                  const Text('Cine'),
                  const Text('Fecha pedido'),
                  const Text('Sala numero'),
                ]
            )
       );

 }

  

}
