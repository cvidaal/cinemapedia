import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.move_to_inbox_outlined, color: colors.primary,),
              const SizedBox(width: 5,),
              Text('Cinemapedia', style: titleStyle,),

              const Spacer(), //Sirve para tomar todo el espacio del Row.

              IconButton(onPressed: () {
                //TODO:
                final searchedMovies = ref.watch(searchedMoviesProvider);
                final searchQuery = ref.read(searchQueryProvider);

                showSearch<Movie?>(
                  query: searchQuery,
                  context: context,
                  delegate: SearchMovieDelegate(
                    initialMovies: searchedMovies,
                    searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery,
                  ) 
                ).then((movie) {
                  if(movie == null) return;
                  context.push('/movie/${movie.id}');
                });
              }, 
              icon: const Icon(Icons.search))
            ],
          ),
        ),
      )
      );
  }
}