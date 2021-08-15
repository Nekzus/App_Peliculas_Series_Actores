class MovieGenre {
  MovieGenre({
    this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  String voteAverage;
  int voteCount;
  String? heroId;

  String? error;

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
    }
    return originalLanguage.toUpperCase();
  }

  factory MovieGenre.fromJson(dynamic json) {
    return MovieGenre(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString());
  }
}
