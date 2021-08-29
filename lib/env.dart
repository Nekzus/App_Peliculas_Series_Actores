import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static init() async {
    await dotenv.load(fileName: 'assets/env/.env');
    assert(dotenv.env.containsKey("API_KEY"));
  }
}
