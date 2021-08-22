import 'dart:convert';

import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/models/serie/serie.dart';

class SerieTopResponse {
  SerieTopResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory SerieTopResponse.fromJson(String str) =>
      SerieTopResponse.fromMap(json.decode(str));

  factory SerieTopResponse.fromMap(Map<String, dynamic> json) =>
      SerieTopResponse(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
