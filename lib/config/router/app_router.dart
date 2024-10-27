import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0'); // Obtiene el estado de la página
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ??
                  'no-id'; // Coge los parametros del estado
              return MovieScreen(movieId: movieId);
            }),
      ]),

      GoRoute(
        path: '/',
        // Cuando no necesito ninguno de los dos arguemntos utilizamos _ o __ (barra baja)
        redirect: (_, __) => '/home/0',
      ),
]);
