import 'dart:convert';

import 'package:cine_view/backend/constants.dart';
import 'package:cine_view/models/Actor.dart';
import 'package:cine_view/models/Order.dart';
import 'package:cine_view/models/Payment.dart';
import 'package:cine_view/models/Session.dart';
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

  Future<User?> getUser(String email, String password ) async {
    Response res = await post(Uri.parse('$apiUrl/User/$email/$password'));
    if(res.statusCode != 200) return null;
    return User.fromJson(json.decode(res.body));
  }

  Future<User?> saveUser(String email, String password) async {
    Response res = await post(
    Uri.parse('$apiUrl/User'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': email,
        'Password': password,
        'Rol': 'user'
      }),
    );
    if(res.statusCode != 200) return null;
    return User.fromJson(jsonDecode(res.body));
  }

  Future<Sessions?> getSession(int movieId) async {
    final res = await get(Uri.parse('$apiUrl/RoomMovie/GetList/$movieId'));
    print("in session ");
    if(res.statusCode != 200) return null;
    return Sessions.fromJson(json.decode(res.body));
    //  return (json.decode(res.body) as List)
    //   .map((data) => Sessions.fromJson(data));
  }

  Future<Room> getRoomSeat(int roomId) async {
    var res = await get(Uri.parse('$apiUrl/Room/$roomId')); 
    print("in seats ");
    //if(res.statusCode != 200) return new List.empty();
    // += await get(Uri.parse('$apiUrl/Seat/GetBySession/${sessionId}'));
      return Room.fromJson(json.decode(res.body));
     //return json.decode(res.body);
  }

  Future<List<int>> getBuySeats(int sessionId) async {
    final res = await get(Uri.parse('$apiUrl/Seat/GetBySession/$sessionId'));
    List<int> buyseats = [];
    (jsonDecode(res.body) as List).map((e) => buyseats.add(e)).toList();
    return buyseats;
  } 

  Future<List<Actor>> getCast(int movieId) async {
    final res = await get(Uri.parse('$apiUrl/Cast/$movieId'));
     return (json.decode(res.body) as List)
      .map((data) => Actor.fromJson(data))
      .toList();
  } 

  Future<List<Payment>?> getCards(int userId) async {
    final res = await get(Uri.parse('$apiUrl/Payment/$userId'));
    return (json.decode(res.body) as List)
      .map((data) => Payment.fromJson(data))
      .toList();
    //return null;
  }

  Future<Payment?> saveCard(Payment payment) async {
    Response res = await post(
    Uri.parse('$apiUrl/Payment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Name': payment.name,
        'CardNumber': payment.cardNumber,
        'Cvv': payment.cvv,
        'UserId': payment.userId,
        'Expiration': payment.expirationDate,
      }),
    );
    if(res.statusCode != 200) return null;
    return Payment.fromJson(jsonDecode(res.body));
  }

  Future<Order?> saveOrder(Order order) async {
    Response res = await post(
    Uri.parse('$apiUrl/Order'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Quantity': order.quantity,
        'Price': order.price,
        'CreatedDate': order.createdDate,
        'UserId': order.userId,
      }),
    );
    if(res.statusCode != 200) return null;
    return Order.fromJson(jsonDecode(res.body));
  }


  Future<dynamic> saveOrderSeat(int orderId, int seatId, double price) async {
    Response res = await post(
    Uri.parse('$apiUrl/OrderSeat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'OrderId': orderId,
        'SeatId': seatId,
        'price': price,
      }),
    );
    if(res.statusCode != 200) return null;
    return 'successfully';
  }

  

}
