import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  final ScrollController _scrollController = ScrollController(); // Acceso al ScrollController
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll); // Escucha el Scroll
    loadNextPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  //TODO: ScrollControler
  void _onScroll(){
    if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200){
      // Si llega al final de la lista, carga la siguiente página
      loadNextPage();
    }
  }

  void loadNextPage() async{
    if(isLoading || isLastPage) return; // Si esta cargando o es la última página return;
    isLoading = true;

    final movies = await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if(movies.isEmpty){
      isLastPage = true;
    }
  }
  //initState
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final favoritesMovies = ref
        .watch(favoritesMoviesProvider)
        .values
        .toList(); // Mapa de las peliculas convertido a lista

    if(favoritesMovies.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary,),
            Text('Ohhhh no!!!', style: TextStyle(fontSize: 30, color: colors.primary),),
            const Text('No tienes películas favoritas', style: TextStyle(fontSize: 20, color: Colors.black45) ,),

            SizedBox(height: 20,),
            FilledButton.tonal(onPressed: () => context.go('/home/0'), child: const Text('Empieza a buscar'))
          ],
        ),
      );
    }

    return Scaffold(body: MovieMasonry(
      controller: _scrollController,
      loadNextPage: loadNextPage,
      movies: favoritesMovies
    ));
  }
}
