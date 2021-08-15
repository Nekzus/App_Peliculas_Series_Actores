import 'dart:convert';

import 'package:peliculas_reversionado/models/serie/models.dart';

class SerieSimilarResponse {
  SerieSimilarResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory SerieSimilarResponse.fromJson(String str) =>
      SerieSimilarResponse.fromMap(json.decode(str));

  factory SerieSimilarResponse.fromMap(Map<String, dynamic> json) =>
      SerieSimilarResponse(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
