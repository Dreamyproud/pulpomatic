import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:netflix_clone/models/movies_model.dart';
import 'package:netflix_clone/utils/constats.dart';

class ServiceApiProvider with ChangeNotifier {
  Client client = Client();
  late List<MoviesPopularResult> _moviesModel;

  /// Token getter
  List<MoviesPopularResult> get moviesModel {
    return _moviesModel;
  }

  Future<List<MoviesPopularResult>> getMoviesHttp() async {
    print(baseUrl + 'movie/popular?api_key=$apiKey&language=en-US&page=1');

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await client.get(
        Uri.parse(
            baseUrl + 'movie/popular?api_key=$apiKey&language=en-US&page=1'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      MoviesPopularModel movies = new MoviesPopularModel.fromMap(jsonResponse);

      notifyListeners();
      return movies.results;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load get movies');
    }
  }
}
