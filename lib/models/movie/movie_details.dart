import 'dart:convert';

class MovieDetails {
  MovieDetails({
    required this.adult,
    this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<GenreMovie> genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  String? voteAverage;
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
    } else if (this.originalLanguage == "cn") {
      return 'Chino Cantonés';
    } else if (this.originalLanguage == "he") {
      return 'Hebreo';
    }
    return originalLanguage!.toUpperCase();
  }

  factory MovieDetails.fromJson(String str) =>
      MovieDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieDetails.fromMap(Map<String, dynamic> json) => MovieDetails(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<GenreMovie>.from(
            json["genres"].map((x) => GenreMovie.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromMap(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromMap(x))),
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromMap(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toStringAsPrecision(2),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toMap())),
        "production_countries":
            List<dynamic>.from(productionCountries.map((x) => x.toMap())),
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages":
            List<dynamic>.from(spokenLanguages.map((x) => x.toMap())),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class GenreMovie {
  GenreMovie({
    required this.id,
    this.name,
  });

  int id;
  String? name;

  get fullGenreName {
    if (this.name == "Suspense") {
      return 'Suspenso';
    }
    return name!.toUpperCase();
  }

  factory GenreMovie.fromJson(String str) =>
      GenreMovie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenreMovie.fromMap(Map<String, dynamic> json) => GenreMovie(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  int id;
  String? logoPath;
  String name;
  String originCountry;

  factory ProductionCompany.fromJson(String str) =>
      ProductionCompany.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductionCompany.fromMap(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  String iso31661;
  String name;

  factory ProductionCountry.fromJson(String str) =>
      ProductionCountry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductionCountry.fromMap(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class SpokenLanguage {
  SpokenLanguage({
    required this.iso6391,
    required this.name,
  });

  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(String str) =>
      SpokenLanguage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "iso_639_1": iso6391,
        "name": name,
      };
}
