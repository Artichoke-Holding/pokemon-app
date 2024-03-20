import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/views/home_page.dart';


void main() {
  runApp(
    const ProviderScope(
      child: MyInfoGameApp(),
    ),
  );
}

class MyInfoGameApp extends StatelessWidget {
  const MyInfoGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Info Game',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
