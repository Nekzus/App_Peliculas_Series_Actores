// To parse this JSON data, do
//
//     final seriePreview = seriePreviewFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_reversionado/models/serie/models.dart';

class SeriePreview {
  SeriePreview({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory SeriePreview.fromJson(String str) =>
      SeriePreview.fromMap(json.decode(str));

  factory SeriePreview.fromMap(Map<String, dynamic> json) => SeriePreview(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
