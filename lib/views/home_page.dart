import 'package:flutter/material.dart';
import 'package:myinfogame/views/user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Info Game'),
        actions: [
          PopupMenuButton(
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
                    onPressed: print,
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
      body: const Center(
        child: Text('Welcome to My Info Game\n Here is a list of Pokémon.'),
      ),
    );
  }
}
