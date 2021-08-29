import 'dart:convert';

class MovieCertificationResponse {
  MovieCertificationResponse({
    required this.id,
    required this.results,
  });

  int id;
  List<Result>? results;

  factory MovieCertificationResponse.fromJson(String str) =>
      MovieCertificationResponse.fromMap(json.decode(str));

  factory MovieCertificationResponse.fromMap(Map<String, dynamic> json) =>
      MovieCertificationResponse(
        id: json["id"] == null ? null : json["id"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    required this.iso31661,
    required this.releaseDates,
  });

  String iso31661;
  List<ReleaseDate>? releaseDates;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
        releaseDates: json["release_dates"] == null
            ? null
            : List<ReleaseDate>.from(
                json["release_dates"].map((x) => ReleaseDate.fromJson(x))),
      );
}

class ReleaseDate {
  ReleaseDate({
    required this.certification,
    required this.iso6391,
    required this.note,
    required this.releaseDate,
    required this.type,
  });

  String certification;
  String iso6391;
  String note;
  DateTime? releaseDate;
  int type;

  factory ReleaseDate.fromJson(String str) =>
      ReleaseDate.fromMap(json.decode(str));

  factory ReleaseDate.fromMap(Map<String, dynamic> json) => ReleaseDate(
        certification:
            json["certification"] == null ? null : json["certification"],
        iso6391: json["iso_639_1"],
        note: json["note"] == null ? null : json["note"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        type: json["type"] == null ? null : json["type"],
      );
}
