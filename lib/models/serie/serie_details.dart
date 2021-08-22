import 'dart:convert';

class SerieDetails {
  SerieDetails({
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    required this.homepage,
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
  String? firstAirDate;
  List<GenreSerie> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  String? lastAirDate;
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

  String toJson() => json.encode(toMap());

  factory SerieDetails.fromMap(Map<String, dynamic> json) => SerieDetails(
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedBy>.from(
            json["created_by"].map((x) => CreatedBy.fromMap(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres: List<GenreSerie>.from(
            json["genres"].map((x) => GenreSerie.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"],
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
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

  Map<String, dynamic> toMap() => {
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x.toMap())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "networks": List<dynamic>.from(networks.map((x) => x.toMap())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toMap())),
        "production_countries":
            List<dynamic>.from(productionCountries.map((x) => x.toMap())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toMap())),
        "spoken_languages":
            List<dynamic>.from(spokenLanguages.map((x) => x.toMap())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
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

  String toJson() => json.encode(toMap());

  factory CreatedBy.fromMap(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };
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

  String toJson() => json.encode(toMap());

  factory GenreSerie.fromMap(Map<String, dynamic> json) => GenreSerie(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Network {
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String name;
  int id;
  String? logoPath;
  String originCountry;

  factory Network.fromJson(String str) => Network.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
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

  String toJson() => json.encode(toMap());

  factory Season.fromMap(Map<String, dynamic> json) => Season(
        //airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toMap() => {
        /* "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}", */
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
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

  String toJson() => json.encode(toMap());

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
