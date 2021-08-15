import 'dart:convert';

import 'package:peliculas_reversionado/models/serie/models.dart';

class SeriePopularResponse {
  SeriePopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory SeriePopularResponse.fromJson(String str) =>
      SeriePopularResponse.fromMap(json.decode(str));

  factory SeriePopularResponse.fromMap(Map<String, dynamic> json) =>
      SeriePopularResponse(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
