import 'package:flutter_dotenv/flutter_dotenv.dart';

class Tmdb {
  static String? get apiKey {
    return dotenv.env['API_KEY'];
  }

  static String? get language {
    return dotenv.env['LANGUAGE'];
  }

  static String? get baseUrl {
    return dotenv.env['BASE_URL'];
  }

  static String? get baseUrlGenre {
    return dotenv.env['BASE_URL_GENRE'];
  }
}
