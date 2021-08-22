import 'dart:convert';

class Movie {
  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  String voteAverage;
  int voteCount;
  String? heroId;

  get fullPosterImg {
    if (this.posterPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get fullBackdropPath {
    if (this.backdropPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get fullOriginalLanguage {
    if (this.originalLanguage == "en") {
      return 'Inglés';
    } else if (this.originalLanguage == "es") {
      return 'Español';
    } else if (this.originalLanguage == "ja") {
      return 'Japonés';
    } else if (this.originalLanguage == "fr") {
      return 'Francés';
    } else if (this.originalLanguage == "ko") {
      return 'Koreano';
    } else if (this.originalLanguage == "pt") {
      return 'Portugués';
    } else if (this.originalLanguage == "de") {
      return 'Alemán';
    } else if (this.originalLanguage == "pt") {
      return 'Portugués';
    } else if (this.originalLanguage == "pt") {
      return 'Portugués';
    } else if (this.originalLanguage == "ru") {
      return 'Ruso';
    } else if (this.originalLanguage == "ar") {
      return 'Árabe';
    } else if (this.originalLanguage == "pl") {
      return 'Polaco';
    } else if (this.originalLanguage == "fa") {
      return 'Persa';
    } else if (this.originalLanguage == "da") {
      return 'Danés';
    } else if (this.originalLanguage == "no") {
      return 'Noruego';
    } else if (this.originalLanguage == "zh") {
      return 'Chino Mandarín';
    } else if (this.originalLanguage == "it") {
      return 'Italiano';
    } else if (this.originalLanguage == "hi") {
      return 'Hindi';
    } else if (this.originalLanguage == "ga") {
      return 'Irlandés';
    } else if (this.originalLanguage == "tr") {
      return 'Turco';
    } else if (this.originalLanguage == "nl") {
      return 'Holandés';
    } else if (this.originalLanguage == "is") {
      return 'Islandés';
    }
    return originalLanguage!.toUpperCase();
  }

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toStringAsPrecision(2),
        voteCount: json["vote_count"],
      );
}
