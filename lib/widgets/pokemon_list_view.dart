import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../providers/providers.dart';
import '../services/audio/audio_service.dart';
import '../utils/string_utils.dart';

class PokemonListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(pokemonViewModelProvider);

    bool isLoading = viewModel.pokemons.isEmpty &&
        viewModel.hasMore &&
        viewModel.errorMessage == null;


    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        itemCount: isLoading ? 6 : viewModel.pokemons.length + (viewModel.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (isLoading) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Container(width: 50, height: 50, color: Colors.grey),
                  title: Container(width: double.infinity, height: 10, color: Colors.grey),
                  subtitle: Container(width: 100, height: 10, color: Colors.grey),
                ),
              ),
            );
          } else if (index >= viewModel.pokemons.length) {
            if (viewModel.hasMore) {
              viewModel.fetchPokemons();
              return Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          }

          final pokemon = viewModel.pokemons[index];
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  context.go('/pokemon/${pokemon.id}');
                },
                leading:
                    Image.network(pokemon.imageUrl ?? '', fit: BoxFit.cover),
                title: Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                capitalize(pokemon.name),
                                style: TextStyle(color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                height: 20,
                                width: 1,
                                color:
                                    Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${pokemon.baseExperience}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                trailing:IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons/volume_up_simple_electrifying.svg',
                    height: 35,
                    color: Colors.blue,
                  ),
                  onPressed: () => ref.read(audioServiceProvider).playCry(pokemon.cryUrl ?? ''),
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
