import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'apy_key': Environment.theMovieDbKey,
      'language': 'es-MX',
    }),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDBResponse.results
        // es como un filtro que deja pasar si el resultado de la condición es true
        // es un ejemplo para que en el caso de que no tenga poster, directamente no me carge la movie
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    dio.options.headers['Authorization'] =
        'Bearer ${Environment.theMovieDbToken}';
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    dio.options.headers['Authorization'] =
        'Bearer ${Environment.theMovieDbToken}';
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    dio.options.headers['Authorization'] =
        'Bearer ${Environment.theMovieDbToken}';
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    dio.options.headers['Authorization'] =
        'Bearer ${Environment.theMovieDbToken}';
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    return _jsonToMovies(response.data);
  }
}
