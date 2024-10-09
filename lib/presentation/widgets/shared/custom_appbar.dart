import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

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
                
              }, 
              icon: const Icon(Icons.search))
            ],
          ),
        ),
      )
      );
  }
}