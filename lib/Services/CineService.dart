import 'dart:convert';

import 'package:cine_view/backend/constants.dart';
import 'package:cine_view/models/MovieModel.dart';
import 'package:http/http.dart';

class CineService {
  final String apiUrl = ApiConstants.baseUrl;
  
  Future<List<MovieModel>> getMovies() async {
    Response res = await get(Uri.parse('$apiUrl/Movies'));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<MovieModel> cases = body.map((dynamic item) => MovieModel.fromJson(item)).toList();
      return cases;
    } else {
      throw "Failed to load cases list";
    }
  }


}
