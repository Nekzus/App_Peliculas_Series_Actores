import 'dart:convert';

class PersonDetails {
  PersonDetails({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    required this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  DateTime? birthday;
  dynamic deathday;
  int? gender;
  dynamic homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String placeOfBirth;
  double? popularity;
  String? profilePath;

  get fullProfilePath {
    if (this.profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';

    return 'https://i.pinimg.com/236x/6e/b6/68/6eb668f57953414eb15bc9bb18306c29.jpg';
  }

  get fullBirthday {
    if (this.birthday == null) {
      DateTime.tryParse([this.birthday].toString());
      print(this.birthday);
      return '***';
    }
    return this.birthday;
  }

  get fullPlaceOfBirth {
    // ignore: unnecessary_null_comparison
    if (this.placeOfBirth == null) {
      print(this.placeOfBirth);
      return '***';
    }
    return this.placeOfBirth;
  }

  factory PersonDetails.fromJson(String str) =>
      PersonDetails.fromMap(json.decode(str));

  factory PersonDetails.fromMap(Map<String, dynamic> json) => PersonDetails(
        adult: json["adult"] == null ? null : json["adult"],
        alsoKnownAs: json["also_known_as"] == null
            ? null
            : List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"] == null ? null : json["biography"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        deathday: json["deathday"],
        gender: json["gender"] == null ? null : json["gender"],
        homepage: json["homepage"],
        id: json["id"] == null ? null : json["id"],
        imdbId: json["imdb_id"] == null ? null : json["imdb_id"],
        knownForDepartment: json["known_for_department"] == null
            ? null
            : json["known_for_department"],
        name: json["name"] == null ? null : json["name"],
        placeOfBirth:
            json["place_of_birth"] == null ? null : json["place_of_birth"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );
}
