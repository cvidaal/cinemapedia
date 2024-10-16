import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftheposterdb.com%2Fimages%2Fdefaults%2Fmissing_poster.jpg&f=1&nofb=1&ipt=abd0bceedf44599c3c06ac9eb68700dcde1bb7e99aa78db3d4422f7d62300b2e&ipo=images',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
        : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftheposterdb.com%2Fimages%2Fdefaults%2Fmissing_poster.jpg&f=1&nofb=1&ipt=abd0bceedf44599c3c06ac9eb68700dcde1bb7e99aa78db3d4422f7d62300b2e&ipo=images',
      releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );

    static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftheposterdb.com%2Fimages%2Fdefaults%2Fmissing_poster.jpg&f=1&nofb=1&ipt=abd0bceedf44599c3c06ac9eb68700dcde1bb7e99aa78db3d4422f7d62300b2e&ipo=images',
      genreIds: moviedb.genres.map((e) => e.name).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
        : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftheposterdb.com%2Fimages%2Fdefaults%2Fmissing_poster.jpg&f=1&nofb=1&ipt=abd0bceedf44599c3c06ac9eb68700dcde1bb7e99aa78db3d4422f7d62300b2e&ipo=images',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount      
    );
}
