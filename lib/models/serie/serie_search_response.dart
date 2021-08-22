import 'dart:convert';

import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/models/serie/serie.dart';

class SerieSearchResponse {
  SerieSearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory SerieSearchResponse.fromJson(String str) =>
      SerieSearchResponse.fromMap(json.decode(str));

  factory SerieSearchResponse.fromMap(Map<String, dynamic> json) =>
      SerieSearchResponse(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
