import 'dart:convert';

import 'package:cine_view/backend/constants.dart';
import 'package:cine_view/models/RoomMovie.dart';
import 'package:http/http.dart';

import '../models/Movie.dart';
import '../models/User.dart';

class CineService {
  final String apiUrl = ApiConstants.baseUrl;

  Future<List<Movie>> getMovies() async {
    Response res = await get(Uri.parse('$apiUrl/Movies'));

    if (res.statusCode != 200) throw "Failed to load cases list";
    List<dynamic> body = jsonDecode(res.body);
    List<Movie> movies =
        body.map((dynamic item) => Movie.fromJson(item)).toList();
    return movies;
  }

  // Future<User> getUser(int id) async {
  //   Response res = await get(Uri.parse('$apiUrl/User/2'));

  //   if (res.statusCode != 200) return User.fromJson(json.decode(res.body));
  // }

  Future<List<RoomMovie>> getSession(int movieId) async {
    Response res = await get(Uri.parse('$apiUrl/RoomMovie/GetList/${movieId}'));
    print("in session ");
    //if(res.statusCode != 200) return new List.empty();
     return (json.decode(res.body) as List)
      .map((data) => RoomMovie.fromJson(data))
      .toList();

  }
}
