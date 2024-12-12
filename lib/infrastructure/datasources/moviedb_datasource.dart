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

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MzdjOTU0ZGU5NjQwMTRhNDJiOGIyOTc4NWRjY2Q0ZCIsIm5iZiI6MTczMzkxOTYzMi43Mjk5OTk4LCJzdWIiOiI2NzU5ODM5MGVmMjY5ZDBiODhlM2E0MTYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.NmKN7XZe9R4mCFYi_RR2A3Y9gF2bfzz53OdhCv99jUI';
    final response = await dio.get('/movie/now_playing');
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        // es como un filtro que deja pasar si el resultado de la condición es true
        // es un ejemplo para que en el caso de que no tenga poster, directamente no me carge la movie
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }
}
