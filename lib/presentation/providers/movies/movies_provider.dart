import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateNotifierProvider: Es un proveedor que permite exponer el estado (List<Movie>) a través de un objeto MoviesNotifier.
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  /// ref.watch(): ref es una referencia a todos los proveedores dentro de Riverpod.
  /// watch te permite observar el movieRepositoryProvider, que contiene la lógica para obtener películas.
  /// Aquí estamos específicamente obteniendo el método getNowPlaying, que trae las películas en cartelera.
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  ///MoviesNotifier: Este es el objeto que va a manejar el estado de la lista de películas y las actualizaciones.
  ///Lo inicializamos pasando la función fetchMoreMovies.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
},);

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
},);

/// typedef: Define un alias para simplificar el tipo de una función.
/// Aquí, MovieCallBack es una función que devuelve una Future con una lista de Movie
/// y recibe como argumento un entero page (número de página).
typedef MovieCallBack = Future<List<Movie>> Function({int page});

// Extiende de StateNotifier y gestiona una lista de películas.
class MoviesNotifier extends StateNotifier<List<Movie>> {
  bool isLoading = false;
  int currentPage = 0; // Variable que almacena el número de la página actual.
  MovieCallBack
      fetchMoreMovies; // Función pasada al constructor que sera usada para obtener más peliculas

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

// Metodo para cargar más peliculas.
  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    print('Obteniendo más peliulas');
    currentPage++;

    ///lama a la función que obtiene más películas desde la API (o la fuente de datos), pasando la página actual.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    //Actualiza el estado añadiendo las nuevas películas a las ya existentes usando el "spread operator" (...).
    //Esto asegura que las películas anteriores no se pierdan cuando se añadan las nuevas.
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
