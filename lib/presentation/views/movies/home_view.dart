import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar( // Es lo mismo que un appbar
          floating: true, 
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.zero, // Quita el pading que aparece en la AppBar
          ),
          // Cuando deslizamos hacia abajo aparece
        ),

      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [

            // const CustomAppbar(),

            MoviesSlideshow(movies: slideShowMovies),
            MoviesHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'Lunes 20',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListview(
              movies: upcomingMovies,
              title: 'Próximamente',
              subTitle: 'Este mes',
              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              // subTitle: 'Este mes',
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              // subTitle: 'Este mes',
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
              childCount:
                  1)) // delegate es la función que sirve para crear los widgets dentro de este view
    ]);
  }
}