import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieProvider, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieProvider(getActors: actorsRepository.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieProvider extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieProvider({required this.getActors})
      : super({
          //inicializamos vacío el mapa con el "super({})"
        });

  /*
        es similar al manejo de las movies para obtenerlas y guardarlas para no volver a cosultar
        si es que ya la consultamos
         {
    vamos a crear un mapa en el que vamos a tener el 
    id de la película que va a apuntar a una instancia de Actor() 
    que pertenecen a ese id
    es decir que vamos a tener el id de la movie que apunta a una
    lista de actores

    '505642' : <Actor>[],
    '505656' : <Actor>[],
    '505222' : <Actor>[],
    '505612' : <Actor>[],
  }

  */

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
