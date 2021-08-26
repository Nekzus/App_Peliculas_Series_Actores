import 'dart:async';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_reversionado/helpers/movie/debouncer.dart';
import 'package:peliculas_reversionado/helpers/movie/helpers.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/models/movie/search_response.dart';
import 'package:peliculas_reversionado/models/person_details.dart';

class MoviesProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  String _apiKey = 'fd6e6e97276183956c3334241bf7dcf8';
  String _baseUrl = 'api.themoviedb.org';
  String _baseUrlGenre = 'https://api.themoviedb.org';
  String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> similarMovies = [];
  List<MovieGenre> movieList = [];
  List<Genre> genreList = [];

  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<GenreMovie>> genreMovie = {};
  Map<int, List<Movie>> moviesSimilar = {};
  Map<int, List<Movie>> personMoviesSimilar = {};

  int _popularPage = 0;
  int _similarPage = 0;
  int _personSimilarPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  // ignore: close_sinks
  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Movie>> getSimilarMovies(int moviesId) async {
    if (moviesSimilar.containsKey(moviesId)) return moviesSimilar[moviesId]!;
    _similarPage++;

    final jsonData =
        await _getJsonData('3/movie/$moviesId/similar', _similarPage);
    final similarResponse = SimilarResponse.fromJson(jsonData);

    moviesSimilar[moviesId] = similarResponse.results;

    return similarResponse.results;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<GenreMovie>> getMovieGenre(int movieId) async {
    if (genreMovie.containsKey(movieId)) return genreMovie[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId');
    final genreMovieResponse = MovieDetails.fromJson(jsonData);

    genreMovie[movieId] = genreMovieResponse.genres;

    return genreMovieResponse.genres;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQueryMovie(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchMovies(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  Future<List<Genre>> getGenreList() async {
    try {
      final response = await _dio.get(
          '$_baseUrlGenre/3/genre/movie/list?api_key=$_apiKey&language=$_language');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<MovieGenre>> getMovieByGenre(int movieId) async {
    try {
      final url =
          '$_baseUrlGenre/3/discover/movie?with_genres=$movieId&api_key=$_apiKey&language=$_language';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<MovieGenre> movieList =
          movies.map((m) => MovieGenre.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<MovieGenre>> getNowPlayingMovie() async {
    try {
      final url =
          '$_baseUrlGenre/movie/now_playing?api_key=$_apiKey&language=$_language';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<MovieGenre> movieList =
          movies.map((m) => MovieGenre.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  getMovieDetails(int movieId) async {
    final jsonData = await _getJsonData('3/movie/$movieId');
    final movieDetailsResponse = MovieDetails.fromJson(jsonData);
    return movieDetailsResponse;
  }

  getPersonDetails(int actorId) async {
    final jsonData = await _getJsonData('3/person/$actorId');
    final personDetailsResponse = PersonDetails.fromJson(jsonData);
    return personDetailsResponse;
  }

  Future<List<Movie>> getPersonMovies(int movieId) async {
    if (personMoviesSimilar.containsKey(movieId))
      return personMoviesSimilar[movieId]!;
    _personSimilarPage++;

    final jsonData = await _getJsonData(
        '3/person/$movieId/movie_credits', _personSimilarPage);
    final personSimilarResponse = MoviePersonCredits.fromJson(jsonData);

    personMoviesSimilar[movieId] = personSimilarResponse.cast;

    return personSimilarResponse.cast;
  }
}
