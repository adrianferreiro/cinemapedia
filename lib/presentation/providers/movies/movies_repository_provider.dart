//la data que contiene no cambia entonces usamos un provider de solo lectura
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

//éste repositorio es inmutable
//su objetivo es proporcionar a todos los demás providers
//que tengo la info necesaria para que puedan consultar la info
//de éste repositoryimpl.
//que primero es el getNowPlaying pero después vamos a tener mas
final movieRepositoryProvider = Provider((ref) {
  //si el día de mañana queremos usar otro datasource, entonce cambiamos acá
  return MovieRepositoryImpl(MoviedbDatasource());
});
