import 'dart:async';

import 'package:netflix_clone/models/movies_model.dart';

import 'services_api_provider.dart';

class ServiceRepository {
  final serviceApiProvider = ServiceApiProvider();

  Future<List<MoviesPopularResult>> fetchAllMovies() =>
      serviceApiProvider.getMoviesHttp();
}
