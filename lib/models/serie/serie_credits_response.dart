import 'dart:convert';

class SerieCreditsResponse {
  SerieCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory SerieCreditsResponse.fromJson(String str) =>
      SerieCreditsResponse.fromMap(json.decode(str));

  factory SerieCreditsResponse.fromMap(Map<String, dynamic> json) =>
      SerieCreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
      );
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;
  String? heroId;

  get fullProfilePath {
    if (this.profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';

    return 'https://3.bp.blogspot.com/-fsG9KlI1P14/TsIHzSr9-bI/AAAAAAAABJY/EMlyo42oUkU/s1600/4-Avatares-para-Facebook.jpg';
  }

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        castId: json["cast_id"] == null ? null : json["cast_id"],
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
      );
}
