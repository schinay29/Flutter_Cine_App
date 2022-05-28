import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/screens/movies/movie_detail_header.dart';
import 'package:flutter/material.dart';
class MovieDetailScreen extends StatefulWidget {
 final Movie movie;
  const MovieDetailScreen(this.movie);
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isLoading = false;
  void initState() {
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieDetailHeader(widget.movie),
            Text(widget.movie.name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.movie.description),
            ),
          ],
        ),
      ),
    );
  }
}
