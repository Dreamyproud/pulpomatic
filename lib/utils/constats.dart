import 'package:tmdb_api/tmdb_api.dart';

const String httpBaseUrl = 'https://api.themoviedb.org/3/'; //Url
const String apiKey = '20cd1967c9b3c81692683bcc18d4c99e';
const String baseUrl = 'https://api.themoviedb.org/3/';
const String accessToken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMGNkMTk2N2M5YjNjODE2OTI2ODNiY2MxOGQ0Yzk5ZSIsInN1YiI6IjYxOTY1NGViMjViOTU1MDA2MmMyNzg3OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.e18z8Iivk6YE6kEkOihUxLN5P3cBTiwU0GGZT-7Y6U8';
const durationPetitions = Duration(seconds: 1);
const imageUrl = 'https://image.tmdb.org/t/p/w500/';
List trendingMovies = [];
List topRateMovies = [];
List tvMovies = [];

Future<List> loadMovies({required String typeList}) async {
  List trendingMovies = [];
  List topRateMovies = [];
  List tvMovies = [];
  List defaultMovies = [];

  /// Initialize tmdb
  final tmdb = TMDB(
    ApiKeys(apiKey, accessToken),
    logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
  );

  /// Maps variables
  Map trendingResult = await tmdb.v3.trending.getTrending();
  Map topRateResult = await tmdb.v3.movies.getTopRated();
  Map tvResults = await tmdb.v3.tv.getPouplar();
  Map defaultResults = await tmdb.v3.movies.getPouplar();

  trendingMovies = trendingResult['results'];
  topRateMovies = topRateResult['results'];
  tvMovies = tvResults['results'];
  defaultMovies = defaultResults['results'];

  switch (typeList) {
    case 'trending':
      return trendingMovies;

    case 'topRate':
      return topRateMovies;
    case 'tv':
      return tvMovies;

    case 'popular':
      return defaultMovies;
    default:
      return defaultMovies;
  }
}
