class Genre {
  final int? id;
  final String? name;

  String? error;

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

  Genre({required this.id, required this.name});

  factory Genre.fromJson(dynamic json) {
    if (json == null) {
      return Genre(id: null, name: '');
    }
    return Genre(id: json['id'], name: json['name']);
  }

  static fromMap(x) {}
}
