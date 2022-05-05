import 'package:flutter/material.dart';
import '../Services/CineService.dart';
import '../models/MovieModel.dart';
import './user_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


prueba() async {
    var movie;
    CineService cineService = new CineService();
    //List<MovieModel> m = cineService.getMovies() as List<MovieModel>;

    //Future<List<MovieModel>> futureCases = cineService.getMovies();
    
    List<MovieModel> movies = await cineService.getMovies();
    print(movies[0].name);
    return movies[0].name;

  }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(prueba().toString()),
      ),
    );
  }
}
