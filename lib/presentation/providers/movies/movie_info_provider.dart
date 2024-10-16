import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final moviesRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: moviesRepository.getMovieById);
},);


typedef GetMovieCallBack = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>>{

  final GetMovieCallBack getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }
  ): super({});

  Future<void> loadMovie( String movieId ) async{
    if (state[movieId] != null) return; //* Si la pelicula ya esta cargada no la volvemos a cargar
    final movie = await getMovie(movieId);
    
    state = {...state, movieId: movie};
  }

}