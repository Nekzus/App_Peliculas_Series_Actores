import 'dart:convert';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/models/serie/serie.dart';

class SerieAiringToday {
  SerieAiringToday({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory SerieAiringToday.fromJson(String str) =>
      SerieAiringToday.fromMap(json.decode(str));

  factory SerieAiringToday.fromMap(Map<String, dynamic> json) =>
      SerieAiringToday(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
