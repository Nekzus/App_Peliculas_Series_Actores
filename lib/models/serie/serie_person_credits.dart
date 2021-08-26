import 'dart:convert';

import 'package:peliculas_reversionado/models/serie/models.dart';

class SeriePersonCredits {
  SeriePersonCredits({
    required this.cast,
    required this.crew,
    required this.id,
  });

  List<Serie> cast;
  List<Serie> crew;
  int id;

  factory SeriePersonCredits.fromJson(String str) =>
      SeriePersonCredits.fromMap(json.decode(str));

  factory SeriePersonCredits.fromMap(Map<String, dynamic> json) =>
      SeriePersonCredits(
        cast: List<Serie>.from(json["cast"].map((x) => Serie.fromMap(x))),
        crew: List<Serie>.from(json["crew"].map((x) => Serie.fromMap(x))),
        id: json["id"],
      );
}
