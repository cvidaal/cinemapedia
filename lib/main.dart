import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';

Future<void> main() async{
  await dotenv.load(fileName: ".env"); // Variables de entorno utilizadas con dotenv

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, // Importación de GoRoute
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
