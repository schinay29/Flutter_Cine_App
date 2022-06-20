import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/screens/movies/moviedetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CineService _cineService = CineService();
  List<Movie> movies = [];
  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
          // height: 200,
          child: FutureBuilder(
            // future: _cineService.getSession(2),
            future: _cineService.getMovies(),
            builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
              while (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) movies = snapshot.data!;
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    SizedBox(
                      width: 80,
                    ),
                    const Text(
                      'Cartelera de peliculas',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildRecentMovies(),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Esta semana",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(movies.length,
                            ((index) => _buildAllMovies(movies[index]))),
                      ))
                ],
              );
            },
          )

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
      options: CarouselOptions(
        height: 250.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.6,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) => {
          print(index),
          // setState(() {
          // _currentPage = index;

          // })
        },
      ),
      items: movies.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                //width: 200,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(i.img), fit: BoxFit.cover),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10.0)),
                child: GestureDetector(
                    // child: Image.network(i.img, fit: BoxFit.cover),
                    //child: Text('text $i', style: TextStyle(fontSize: 16.0),
                    onTap: () {
                  print('tap ' + i.movieId.toString());

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(i)),
                  );
                }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => DetailScreen(i)));
                    // }
                    ));
          },
        );
      }).toList(),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      child: AnimatedSmoothIndicator(
        activeIndex: _currentPage,
        //activeIndex: 1,
        count: movies.length,
        //count: 5,
        effect: const ExpandingDotsEffect(
            activeDotColor: Color.fromRGBO(0, 0, 0, 0.9),
            dotWidth: 8,
            dotHeight: 8),
      ),
    );
  }

  Widget _buildAllMovies(Movie movie) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailScreen(movie)),
            ),
          ),
          margin: const EdgeInsets.only(top: 10, left: 15),
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: NetworkImage(movie.img)),
            color: Colors.transparent,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color.fromARGB(17, 0, 0, 0),
              ),
            ],
          ),
          //   child: Row(
          //         children: <Widget>[
          //           RichText(
          //             text: TextSpan(
          //               children: [
          //                 TextSpan(
          //                     //text: "$title\n".toUpperCase(),
          //                     text: "hola\n".toUpperCase(),
          //                     style: Theme.of(context).textTheme.button),
          //                 TextSpan(
          //                   text: "adios".toUpperCase(),
          //                   style: TextStyle(
          //                     color: Colors.black87.withOpacity(0.5),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ]
          // ),
        )
      ],
    );
  }
}
