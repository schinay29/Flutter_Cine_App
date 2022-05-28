import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/RoomMovie.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CineService _cineService = new CineService();
   List<Movie> movies = [];
   int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
       // height: 200,
        child: FutureBuilder<List<Movie>>(
          // future: _cineService.getSession(2),
          future: _cineService.getMovies(),
          builder: (context, snapshot) {
            while (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            if (snapshot.connectionState == ConnectionState.done) movies = snapshot.data!;
            return Column(
              children: [
                _buildRecentMovies(),
                _buildPageIndicator(), 
                SizedBox(height: 40,),
                _buildAllMovies()
              ],
            );
        },)

        // child: Column(
        //   children: [
        //     _buildRecentMovies(),
        //     _buildPageIndicator(), 
        //     _buildAllMovies()
        //   ],
        // ),
      ),
    );
  }

  Widget _buildRecentMovies() {
    return CarouselSlider(
      
      options: CarouselOptions(height: 250.0,
       onPageChanged: ( index, reason ) => {
                print(index),
                // setState(() {
                // _currentPage = index;
                  
                // })
            },),
      // items: ['https://es.web.img3.acsta.net/pictures/14/01/30/18/07/456916.jpg', 'https://es.web.img3.acsta.net/pictures/14/01/30/18/07/456916.jpg'].map((i) {
      items: movies.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 200,
              //width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0)),
              // child: Text('text $i', style: TextStyle(fontSize: 16.0),
              child: GestureDetector(
                         child: Image.network(i.img, fit: BoxFit.fill),
                        //child: Text('text $i', style: TextStyle(fontSize: 16.0),
                        onTap: () {
                          print('tap '+ i.movieId.toString());
                          // Navigator.push<Widget>(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ImageScreen(i),
                          //   ),
                          // );
                        }
              )
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      child: AnimatedSmoothIndicator(
        activeIndex: _currentPage,
        //activeIndex: 1,
        count: movies.length,
        //count: 5,
        effect: ExpandingDotsEffect(
          activeDotColor: Color.fromRGBO(0, 0, 0, 0.9),
          dotWidth: 8,
          dotHeight: 8),
      ),
    );
  }

  Widget _buildAllMovies(){
    return Column(
      children: [ 
        Image.network('https://es.web.img3.acsta.net/pictures/14/01/30/18/07/456916.jpg', height: 150, width: 150),
        // ARREGLAR FIT
        //imagen
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white38,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Colors.black38,
              ),
            ],
          ),
          child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            //text: "$title\n".toUpperCase(),
                            text: "hola\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "adios".toUpperCase(),
                          style: TextStyle(
                            color: Colors.black87.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
        ),
        )
        

      ],
    );
  }

}
