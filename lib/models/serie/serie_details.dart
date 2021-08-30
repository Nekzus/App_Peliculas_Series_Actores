import 'dart:convert';

import 'package:peliculas_reversionado/models/serie/models.dart';

class SerieDetails {
  SerieDetails({
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    this.lastAirDate,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    required this.originCountry,
    this.originalLanguage,
    this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  DateTime? firstAirDate;
  List<GenreSerie> genres;
  String? homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime? lastAirDate;
  String name;
  dynamic nextEpisodeToAir;
  List<Network> networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String> originCountry;
  String? originalLanguage;
  String? originalName;
  String overview;
  double popularity;
  String? posterPath;
  List<Network> productionCompanies;
  List<ProductionCountry> productionCountries;
  List<Season> seasons;
  List<SpokenLanguage> spokenLanguages;
  String? status;
  String tagline;
  String type;
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

  get fullStatus {
    if (this.status == "Ended") {
      return 'Finalizada';
    } else if (this.status == "Canceled") {
      return 'Cancelada';
    } else if (this.status == "Returning Series") {
      return 'Vigente';
    } else if (this.status == "In Production") {
      return 'En Producción';
    }
    return status!.toUpperCase();
  }

  factory SerieDetails.fromJson(String str) =>
      SerieDetails.fromMap(json.decode(str));

  factory SerieDetails.fromMap(Map<String, dynamic> json) => SerieDetails(
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedBy>.from(
            json["created_by"].map((x) => CreatedBy.fromMap(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        genres: List<GenreSerie>.from(
            json["genres"].map((x) => GenreSerie.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"] == null
            ? null
            : DateTime.parse(json["last_air_date"]),
        name: json["name"],
        nextEpisodeToAir: json["last_air_date"],
        networks:
            List<Network>.from(json["networks"].map((x) => Network.fromMap(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<Network>.from(
            json["production_companies"].map((x) => Network.fromMap(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromMap(x))),
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromMap(x))),
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromMap(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toStringAsPrecision(2),
        voteCount: json["vote_count"],
      );
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  int id;
  String creditId;
  String name;
  int? gender;
  String? profilePath;

  factory CreatedBy.fromJson(String str) => CreatedBy.fromMap(json.decode(str));

  factory CreatedBy.fromMap(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );
}

class GenreSerie {
  GenreSerie({
    required this.id,
    this.name,
  });

  int id;
  String? name;

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

  factory GenreSerie.fromJson(String str) =>
      GenreSerie.fromMap(json.decode(str));

  factory GenreSerie.fromMap(Map<String, dynamic> json) => GenreSerie(
        id: json["id"],
        name: json["name"],
      );
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

  factory ProductionCountry.fromMap(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );
}

class Season {
  Season({
    //this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  //DateTime? airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String? posterPath;
  int seasonNumber;

  factory Season.fromJson(String str) => Season.fromMap(json.decode(str));

  factory Season.fromMap(Map<String, dynamic> json) => Season(
        //airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );
}

class SpokenLanguage {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  String englishName;
  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(String str) =>
      SpokenLanguage.fromMap(json.decode(str));

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );
}
