import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // Categorias View
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack( // <--- Este widget sirve para guardar el estado de la página
        index: pageIndex,
        children: viewRoutes, // Recibe [0, 1, 2] dependiendo de la página que muestra
      ), 
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}


