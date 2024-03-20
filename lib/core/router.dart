import 'package:go_router/go_router.dart';
import 'package:pokemon/views/home_page.dart';
import 'package:pokemon/views/pokemon_details_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'pokemon/:id',
            builder: (context, state) {
              final pokemonId = state.pathParameters['id'];
              if (pokemonId != null) {
                return PokemonDetailsPage(pokemonId: int.parse(pokemonId));
              }
              return const HomePage();
            },
          ),
        ],
      ),
    ],
  );
}
