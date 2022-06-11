import 'dart:convert';

import 'package:cine_view/backend/constants.dart';
import 'package:cine_view/models/Actor.dart';
import 'package:cine_view/models/RoomMovie.dart';
import 'package:http/http.dart';

import '../models/Movie.dart';
import '../models/Room.dart';
import '../models/User.dart';

class CineService {
  final String apiUrl = ApiConstants.baseUrl;

  Future<List<Movie>> getMovies() async {
    Response res = await get(Uri.parse('$apiUrl/Movie'));

    if (res.statusCode != 200) throw "Failed to load cases list";
    List<dynamic> body = jsonDecode(res.body);
    List<Movie> movies =
        body.map((dynamic item) => Movie.fromJson(item)).toList();
        print(movies);
    return movies;
  }

  // Future<User> getUser(int id) async {
  //   Response res = await get(Uri.parse('$apiUrl/User/2'));

  //   if (res.statusCode != 200) return User.fromJson(json.decode(res.body));
  // }

  Future<List<RoomMovie>> getSession(int movieId) async {
    final res = await get(Uri.parse('$apiUrl/RoomMovie/GetList/${movieId}'));
    print("in session ");
    //if(res.statusCode != 200) return new List.empty();
     return (json.decode(res.body) as List)
      .map((data) => RoomMovie.fromJson(data))
      .toList();
  }

  
  Future<Room> getRoomSeat(int roomId) async {
    var res = await get(Uri.parse('$apiUrl/Room/${roomId}')); 
    print("in seats ");
    //if(res.statusCode != 200) return new List.empty();
    // += await get(Uri.parse('$apiUrl/Seat/GetBySession/${sessionId}'));
      return Room.fromJson(json.decode(res.body));
     //return json.decode(res.body);
  }

  Future<List<int>> getBuySeats(int sessionId) async {
    final res = await get(Uri.parse('$apiUrl/Seat/GetBySession/${sessionId}'));
    List<int> buyseats = [];
    (jsonDecode(res.body) as List).map((e) => buyseats.add(e)).toList();
    return buyseats;
  } 

  Future<List<Actor>> getCast(int movieId) async {
    final res = await get(Uri.parse('$apiUrl/Cast/${movieId}'));
     return (json.decode(res.body) as List)
      .map((data) => Actor.fromJson(data))
      .toList();
  } 

}
