import 'dart:convert';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/screens/movies/Detail.dart';
// import 'package:cine_view/screens/movies/Detail.dart';
import 'package:flutter/material.dart';
import 'package:cine_view/constants/base_api.dart';
import 'package:http/http.dart' as http;

class ListMovie extends StatefulWidget {
  @override
  _ListMovieState createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  List <Movie> movies = [];
  
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMovies();
  }

  loadMovies() async {
    setState(() {
      isLoading = true;
    });
    var url = BASE_API + "movie";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
         List<dynamic> body = jsonDecode(response.body);
         movies =body.map((dynamic item) => Movie.fromJson(item)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        movies = [];
        isLoading = false;
      });
    }
    print("testtt movies");
    //print(movies.first.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    if (movies.isEmpty|| isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return getCard(movies.elementAt(index));
        });
  }

  Widget getCard(Movie item) {
    return Card(
      elevation: 5,
      child: InkWell(
        //Wrapped Row with InkWell
        onTap: () {

          // showMessage(context, item['movieId'].toString());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MovieDetailScreen(item)),
              (Route<dynamic> route) => false);
        }, //Add this as well
        child: Row(
          children: <Widget>[
            SizedBox(height: 180,width:180 , child: Image.network(item.img, fit: BoxFit.cover)),
            Expanded(
              child: Ink(
                height: 180,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Expanded(child: Text(item.description))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
