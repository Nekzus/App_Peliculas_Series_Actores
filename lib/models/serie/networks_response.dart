import 'dart:convert';

class Network {
  Network({
    required this.headquarters,
    this.homepage,
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  String? headquarters;
  String? homepage;
  int id;
  String? logoPath;
  String? name;
  String? originCountry;

  get fullLogoPath {
    if (this.logoPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.logoPath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Network.fromJson(String str) => Network.fromMap(json.decode(str));

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        headquarters:
            json["headquarters"] == null ? null : json["headquarters"],
        homepage: json["homepage"] == null ? null : json["homepage"],
        id: json["id"] == null ? null : json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        name: json["name"] == null ? null : json["name"],
        originCountry:
            json["origin_country"] == null ? null : json["origin_country"],
      );
}
