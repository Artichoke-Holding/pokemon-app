import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/core/router.dart';
import 'package:pokemon/views/home_page.dart';
import 'package:pokemon/views/pokemon_details_page.dart';

void main() {
  runApp(ProviderScope(child: MyInfoGameApp()));
}

class MyInfoGameApp extends StatelessWidget {
  MyInfoGameApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Info Game',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,

    );
  }
}
