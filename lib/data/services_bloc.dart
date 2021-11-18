import 'package:netflix_clone/models/movies_model.dart';
import 'package:rxdart/rxdart.dart';

import 'services_repository.dart';

class ServiceBloc {
  final _repository = ServiceRepository();
  late List<MoviesPopularResult> moviesModel;

  final _servicesFetcher = PublishSubject<List<MoviesPopularResult>>();
  Stream<List<MoviesPopularResult>> get allMovies => _servicesFetcher.stream;

  fetchAllMovies() async {
    this.moviesModel = await _repository.fetchAllMovies();
    this._servicesFetcher.sink.add(moviesModel);
  }

  dispose() {
    _servicesFetcher.close();
  }
}

final servicesBloc = ServiceBloc();
