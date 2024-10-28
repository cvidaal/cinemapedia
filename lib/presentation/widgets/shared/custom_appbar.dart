import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

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
                //TODO Funcionalidad boton de busqueda
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
                  context.push('/home/0/movie/${movie.id}');
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