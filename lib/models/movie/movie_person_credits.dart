import 'dart:convert';

import 'package:peliculas_reversionado/models/movie/models.dart';

class MoviePersonCredits {
  MoviePersonCredits({
    required this.cast,
    required this.crew,
    required this.id,
  });

  List<Movie> cast;
  List<Movie> crew;
  int id;

  factory MoviePersonCredits.fromJson(String str) =>
      MoviePersonCredits.fromMap(json.decode(str));

  factory MoviePersonCredits.fromMap(Map<String, dynamic> json) =>
      MoviePersonCredits(
        cast: List<Movie>.from(json["cast"].map((x) => Movie.fromMap(x))),
        crew: List<Movie>.from(json["crew"].map((x) => Movie.fromMap(x))),
        id: json["id"],
      );
}
