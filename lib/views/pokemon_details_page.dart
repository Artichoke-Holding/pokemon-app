import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/utils/string_utils.dart'; // Assuming this exists for capitalize function
import '../models/pokemon.dart';
import '../providers/providers.dart';
import '../widgets/build_keleton_screen.dart';
import '../widgets/pokemon_detail_section.dart';
import '../widgets/type_chip.dart';

class PokemonDetailsPage extends ConsumerStatefulWidget {
  final int pokemonId;

  const PokemonDetailsPage({Key? key, required this.pokemonId})
      : super(key: key);

  @override
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends ConsumerState<PokemonDetailsPage> {
  int _visibleMovesCount = 20;

  @override
  Widget build(BuildContext context) {
    final pokemonFuture = ref.watch(pokemonByIdProvider(widget.pokemonId));

    return Scaffold(
      body: pokemonFuture.when(
        data: (pokemon) => buildPokemonDetails(context, pokemon),
        loading: () => buildSkeletonScreen(context),
        error: (error, _) => Text('Error: $error'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            // Remove elevation if you want a flat design
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: EdgeInsets.zero,
            minimumSize: Size(double.infinity, 48),
          ),
          child: Text('View Species Information'),
        ),
      ),
    );
  }

  Widget buildPokemonDetails(BuildContext context, Pokemon pokemon) {
    List<String> movesToShow = pokemon.moves.length > _visibleMovesCount
        ? pokemon.moves.sublist(0, _visibleMovesCount)
        : pokemon.moves;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: Text(capitalize(pokemon.name ?? '')),
            automaticallyImplyLeading: true, // Enable the back button
            elevation: 0,
            surfaceTintColor: Colors.white,
          ),
          //
          if (pokemon.spriteUrls.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              items: pokemon.spriteUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(url, fit: BoxFit.cover);
                  },
                );
              }).toList(),
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: PokemonDetailSection(
                  title: 'Abilities',
                  items: pokemon.abilities,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: PokemonDetailSection(
                  title: 'Types',
                  items: pokemon.types,
                  itemBuilder: (type) => TypeChip(type: type),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: PokemonDetailSection(
                  title: 'Moves',
                  items: movesToShow,
                ),
              ),
              if (pokemon.moves.length > _visibleMovesCount)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        _visibleMovesCount =
                            _visibleMovesCount + 20 > pokemon.moves.length
                                ? pokemon.moves.length
                                : _visibleMovesCount + 20;
                      }),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // Text color
                        backgroundColor: Colors.blue, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.blueAccent),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: Text('Show More'),
                    ),
                  ),
                ),
            ]),
          ),
        ],
      ),
    );
  }
}
