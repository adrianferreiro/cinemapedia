import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

/*
  {
    vamos a crear un mapa en el que vamos a tener el 
    id de la película que va a apuntar a una instancia de Movie(),
    '505642' : Movie(),
    '505656' : Movie(),
    '505222' : Movie(),
    '5056121' : Movie(),
  }
  entonces puedo consultar si ese id ya existe en mi arreglo o mapa
  y si existe, voy a retornar la película que tengo en caché y si no existe
  hacemos la petición para cargar la información.

 */

//definición de callback para poner ciertas "llaves" cuando otras personas
//utilicen mi objeto
typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    print('realizando petición http');
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
