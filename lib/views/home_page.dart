import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import 'package:pokemon/views/user_page.dart';

import '../providers/providers.dart';
import '../widgets/pokemon_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon',style: TextStyle(fontWeight: FontWeight.w600),),
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
                    return {'Sort by Name', 'Sort by Base Experience'}.map((String choice) {
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
            onPressed: () {
              context.push('/users'); // Navigate to the UserPage
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'toggleButtons',
                  child: ToggleButtons(
                    isSelected: const [true, false],
                    onPressed: (_) {},
                    children: const [
                      Text('En'),
                      Text('De'),
                    ],
                  ),
                ),
              ];
            },
          ),

        ],
      ),
      body: Container(
          color: Colors.grey[300],
          child: PokemonListView()),
    );
  }
}
