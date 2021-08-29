import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_reversionado/models/person_details.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/helpers/serie/debouncer.dart';
import 'package:peliculas_reversionado/providers/tmdb.dart';

class SeriesProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  String _apiKey = FlutterConfig.get('API_KEY');
  String _baseUrl = Tmdb.baseUrl;
  String _baseUrlGenre = Tmdb.baseUrlGenre;
  String _language = Tmdb.language;

  List<Serie> popularSeries = [];
  List<Serie> topSeries = [];
  List<Serie> similarSeries = [];
  List<Serie> onDisplaySeries = [];
  List<Serie> airingTodaySeries = [];
  List<Genre> genreList = [];
  List<SerieGenre> serieList = [];

  Map<int, List<Cast>> seriesCast = {};
  Map<int, List<GenreSerie>> genreSerie = {};
  Map<int, List<Serie>> seriesSimilar = {};
  Map<int, List<Serie>> personSeriesSimilar = {};

  int _popularPage = 0;
  int _topPage = 0;
  int _similarPage = 0;
  int _airingPage = 0;
  int _personSerieSimilarPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  // ignore: close_sinks
  final StreamController<List<Serie>> _suggestionStreamController =
      new StreamController.broadcast();
  Stream<List<Serie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  SeriesProvider() {
    this.getPopularSeries();
    this.getTopSeries();
    this.getOnDisplaySeries();
    this.getAiringTodaySeries();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplaySeries() async {
    final jsonData = await _getJsonData('3/discover/tv');
    final nowPlayingResponse = SeriePreview.fromJson(jsonData);

    onDisplaySeries = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularSeries() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/tv/popular', _popularPage);
    final popularResponse = SeriePopularResponse.fromJson(jsonData);

    popularSeries = [...popularSeries, ...popularResponse.results];
    notifyListeners();
  }

  getTopSeries() async {
    _topPage++;

    final jsonData = await _getJsonData('3/tv/top_rated', _topPage);
    final topResponse = SerieTopResponse.fromJson(jsonData);

    topSeries = [...topSeries, ...topResponse.results];
    notifyListeners();
  }

  getAiringTodaySeries() async {
    _airingPage++;

    final jsonData = await _getJsonData('3/tv/airing_today', _airingPage);
    final airingTodayResponse = SerieAiringToday.fromJson(jsonData);

    airingTodaySeries = [...airingTodaySeries, ...airingTodayResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getSerieCast(int serieId) async {
    if (seriesCast.containsKey(serieId)) return seriesCast[serieId]!;

    final jsonData = await _getJsonData('3/tv/$serieId/credits');
    final creditsResponse = SerieCreditsResponse.fromJson(jsonData);

    seriesCast[serieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<GenreSerie>> getSerieGenre(int serieId) async {
    if (genreSerie.containsKey(serieId)) return genreSerie[serieId]!;

    final jsonData = await _getJsonData('3/tv/$serieId');
    final genreResponse = SerieDetails.fromJson(jsonData);

    genreSerie[serieId] = genreResponse.genres;

    return genreResponse.genres;
  }

  Future<List<Serie>> getSimilarSeries(int seriesId) async {
    if (seriesSimilar.containsKey(seriesId)) return seriesSimilar[seriesId]!;
    _similarPage++;

    final jsonData = await _getJsonData('3/tv/$seriesId/similar', _similarPage);
    final similarResponse = SerieSimilarResponse.fromJson(jsonData);

    seriesSimilar[seriesId] = similarResponse.results;

    return similarResponse.results;
  }

  Future<List<Genre>> getGenreList() async {
    try {
      final response = await _dio.get(
          '$_baseUrlGenre/3/genre/tv/list?api_key=$_apiKey&language=$_language');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<SerieGenre>> getSerieByGenre(int serieId) async {
    try {
      final url =
          '$_baseUrlGenre/3/discover/tv?with_genres=$serieId&api_key=$_apiKey&language=$_language';
      final response = await _dio.get(url);
      var series = response.data['results'] as List;
      List<SerieGenre> serieList =
          series.map((m) => SerieGenre.fromJson(m)).toList();
      return serieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<SerieGenre>> getNowPlayingSerie() async {
    try {
      final url =
          '$_baseUrlGenre/tv/now_playing?api_key=$_apiKey&language=$_language';
      final response = await _dio.get(url);
      var series = response.data['results'] as List;
      List<SerieGenre> serieList =
          series.map((m) => SerieGenre.fromJson(m)).toList();
      return serieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Serie>> searchSeries(String query) async {
    final url = Uri.https(_baseUrl, '3/search/tv',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SerieSearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuerySerie(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchSeries(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  getSerieDetails(int serieId) async {
    final jsonData = await _getJsonData('3/tv/$serieId');
    final serieDetailsResponse = SerieDetails.fromJson(jsonData);
    return serieDetailsResponse;
  }

  getPersonSerieDetails(int actorId) async {
    final jsonData = await _getJsonData('3/person/$actorId');
    final personDetailsResponse = PersonDetails.fromJson(jsonData);
    return personDetailsResponse;
  }

  Future<List<Serie>> getPersonSeries(int serieId) async {
    if (personSeriesSimilar.containsKey(serieId))
      return personSeriesSimilar[serieId]!;
    _personSerieSimilarPage++;

    final jsonData = await _getJsonData(
        '3/person/$serieId/tv_credits', _personSerieSimilarPage);
    final personSimilarResponse = SeriePersonCredits.fromJson(jsonData);

    personSeriesSimilar[serieId] = personSimilarResponse.cast;

    return personSimilarResponse.cast;
  }
}
