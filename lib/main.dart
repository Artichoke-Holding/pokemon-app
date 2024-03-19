import 'package:flutter/material.dart';
import 'package:myinfogame/views/home_page.dart';

void main() {
  runApp(const MyInfoGameApp());
}

class MyInfoGameApp extends StatelessWidget {
  const MyInfoGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Info Game',
      home: HomePage(),
    );
  }
}
