import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? '';
  static String theMovieDbToken = dotenv.env['THE_MOVIEDB_TOKEN'] ?? '';
}
