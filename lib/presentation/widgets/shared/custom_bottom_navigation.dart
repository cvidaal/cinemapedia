import 'package:cinemapedia/presentation/widgets/movies/movies_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index){
    switch(index){
      case 0:
        context.go('/home/0');
        break;
      case 1: 
        context.go('/home/1');
        break;
      case 2: 
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => onItemTapped(context, index),
      elevation: 0, 
      items: const [ // Tiene que haber más de 2 items
        BottomNavigationBarItem( 
          icon: Icon(Icons.home_max),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favoritos'
        ),
      ],
    );
  }
}