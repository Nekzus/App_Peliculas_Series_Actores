class SerieGenre {
  SerieGenre({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    required this.id,
    this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? name;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
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

  get fullGenreName {
    if (this.name == "Action & Adventure") {
      return 'Acción & Aventura';
    } else if (this.name == "News") {
      return 'Noticias';
    } else if (this.name == "Sci-Fi & Fantasy") {
      return 'Sci-Fi & Fantasía';
    } else if (this.name == "Soap") {
      return 'Telenovela';
    } else if (this.name == "War & Politics") {
      return 'Guerra & Política';
    } else if (this.name == "Talk") {
      return 'Entrevistas';
    }
    return name!.toUpperCase();
  }

  factory SerieGenre.fromJson(dynamic json) {
    return SerieGenre(
      backdropPath: json["backdrop_path"],
      firstAirDate: json["first_air_date"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      name: json["name"],
      originCountry: List<String>.from(json["origin_country"].map((x) => x)),
      originalLanguage: json["original_language"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"].toStringAsPrecision(2),
      voteCount: json["vote_count"],
    );
  }
}
