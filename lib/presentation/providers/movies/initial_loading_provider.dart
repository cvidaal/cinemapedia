import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_provider.dart';

final initialLoadingProvider = Provider(
  (ref) {
    final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
    final step2 = ref.watch(popularMoviesProvider).isEmpty;
    final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
    final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

    if(step1 || step2 || step3 || step4) return true; // Si alguno es true = true;
    
    return false; // termino de cargar
  },
);