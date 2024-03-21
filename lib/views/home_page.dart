import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../widgets/flag_switch.dart';
import '../widgets/pokemon_list_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentLang = ref.watch(languageProvider);
    bool isEnglish = currentLang == 'en';

    return Scaffold(
      appBar: AppBar(
        title:
            Text(FlutterI18n.translate(context, "title"), style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.grey[300],
        surfaceTintColor: Colors.grey[300],
        actions: [
          Consumer(
              builder: (context, ref, _) {
                return PopupMenuButton<String>(
                  icon: Icon(Icons.filter_alt_outlined),
                  onSelected: (value) {
                    if (value == 'Sort by Name') {
                      ref.read(pokemonViewModelProvider.notifier).sortByName();
                    } else if (value == 'Sort by Base Experience') {
                      ref.read(pokemonViewModelProvider.notifier).sortByBaseExperience();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {FlutterI18n.translate(context, "sortByName"),
                      FlutterI18n.translate(context, "sortByBaseExperience")}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                );
              }
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => context.push('/users'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FlagSwitch(
              value: isEnglish,
              onChanged: (value) {
                ref.read(languageProvider.notifier).state = value ? 'en' : 'de';
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: PokemonListView(),
      ),
    );
  }
}
