import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/utils/string_utils.dart';
import '../models/pokemon.dart';
import '../models/species_information.dart';
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
    final pokemonService = ref.read(pokemonServiceProvider);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: pokemonFuture.when(
          data: (pokemon) => buildPokemonDetails(context, pokemon),
          loading: () => buildSkeletonScreen(context),
          error: (error, _) => Center(child: Text(FlutterI18n.translate(context, "errorLoadingPokemon"))),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final speciesInfo = await pokemonService.fetchSpeciesInformation(widget.pokemonId);
              showSpeciesInformationDialog(context, speciesInfo);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(FlutterI18n.translate(context, "errorFetchingSpeciesInfo")))
              );
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: EdgeInsets.zero,
            minimumSize: Size(double.infinity, 48),
          ),
          child: Text(FlutterI18n.translate(context, "viewSpeciesInformation")),
        ),
      ),
    );
  }
  void showSpeciesInformationDialog(
      BuildContext context, SpeciesInformation species) {
    Color backgroundColor = colorMap[species.color.toLowerCase()] ?? Colors.grey;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 24,
        title: Align(
          alignment: Alignment.center,
          child: Text(
            species.name.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${FlutterI18n.translate(context, "shape")}: ${species.shape.toUpperCase()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${FlutterI18n.translate(context, "color")} ${species.color.toUpperCase()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(FlutterI18n.translate(context, "close"), style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              foregroundColor: backgroundColor, backgroundColor: Colors.white.withOpacity(0.9), // Text color
            ),
          ),
        ],
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
            automaticallyImplyLeading: true,
            // Enable the back button
            elevation: 0,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
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
                  title: FlutterI18n.translate(context, "abilities"),
                  items: pokemon.abilities,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: PokemonDetailSection(
                  title: FlutterI18n.translate(context, "types"),
                  items: pokemon.types,
                  itemBuilder: (type) => TypeChip(type: type),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: PokemonDetailSection(
                  title: FlutterI18n.translate(context, "moves"),

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
                      child: Text(FlutterI18n.translate(context, "showMore")),
                    ),
                  ),
                ),
            ]),
          ),
        ],
      ),
    );
  }

  Map<String, Color> colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'black': Colors.black,
    'white': Colors.white,
    'cyan': Colors.cyan,
    'magenta': Colors.pinkAccent,
    'lime': Colors.lime,
    'indigo': Colors.indigo,
    'violet': Colors.deepPurple,
    'navy': Color(0xFF000080),
    'teal': Colors.teal,
    'coral': Colors.deepOrange,
    'maroon': Color(0xFF800000),
    'gold': Colors.amber,
    'silver': Color(0xFFC0C0C0),
    'olive': Color(0xFF808000),
    'beige': Color(0xFFF5F5DC),
    'mint': Color(0xFF98FF98),
    'N/A': Colors.grey,
  };
}
