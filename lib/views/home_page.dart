import 'package:flutter/material.dart';


import 'package:pokemon/views/user_page.dart';

import '../widgets/pokemon_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
        backgroundColor: Colors.grey[300],
        surfaceTintColor: Colors.grey[300],
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert), // This changes the icon
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'users',
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserPage(),
                        ),
                      );
                    },
                    child: const Text('Users'),
                  ),
                ),
                PopupMenuItem(
                  value: 'toggleButtons',
                  child: ToggleButtons(
                    isSelected: const [true, false],
                    onPressed: (_) {}, // Example placeholder function
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
