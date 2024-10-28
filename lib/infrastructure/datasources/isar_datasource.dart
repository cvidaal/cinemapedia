import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db; // Instancia base de datos

  IsarDatasource() {
    db = openDB();
  }

  //todo:  Método para iniciar la base de datos
  Future<Isar> openDB() async {
    final dir =
        await getApplicationDocumentsDirectory(); // Obtiene la instancia del directorio

    if (Isar.instanceNames.isEmpty) {
      // MovieSchema es el schema que hemos creado con @collection en la clase movie
      return await Isar.open([MovieSchema],
          directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  //TODO: Método para ver si la pelicula pertenece a la lista de favoritos
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isFavoriteMovie = await isar.movies
        .filter() // Filtramos nuestras propiedades
        .idEqualTo(
            movieId) // Utilizamos el metodo si es igual al movieId de nuestras propiedades.
        .findFirst();

    return isFavoriteMovie != null;
  }

  //TODO: Método para cargar las peliculas
  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies
        .where()
        .offset(offset) // La cantidad que devuelve al principio es (0)
        .limit(limit) // El limito de lo que va a devolver
        .findAll(); // Devuelve todos los que encuentre
  }

  //TODO: Método para agregar la película o borrarla
  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      // Borrar
      isar.writeTxnSync(
        () => isar.movies.deleteSync(favoriteMovie.isarId!),
      );
      return;
    }

    // Insertar si es nulo
    isar.writeTxnSync(
      () => isar.movies.putSync(movie),
    );
  }
}
