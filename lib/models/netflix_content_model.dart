import 'movie_model.dart';

class NetflixContentModel {
  final List<MovieModel> list;
  final String tipoLista;
  NetflixContentModel({required this.list, required this.tipoLista});
}

List<NetflixContentModel> listNetflixContent = [
  NetflixContentModel(list: listPopularMovies, tipoLista: 'Popular on Netflix'),
  NetflixContentModel(list: listTrendingNow, tipoLista: 'Trending Now'),
  NetflixContentModel(list: listWatchItAgain, tipoLista: 'Watch it again'),
  NetflixContentModel(list: listMovieSeries, tipoLista: "Series"),
];
