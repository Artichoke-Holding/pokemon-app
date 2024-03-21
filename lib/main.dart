import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/router.dart';
import 'package:pokemon/providers/providers.dart';

void main() {
  runApp(ProviderScope(child: MyInfoGameApp()));
}

class MyInfoGameApp extends ConsumerWidget { // Updated to ConsumerWidget
  MyInfoGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentLang = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'My Info Game',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            basePath: 'assets/lang',
            forcedLocale: Locale(currentLang), // Dynamically set the locale
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('de', ''),
      ],
      locale: Locale(currentLang, ''),

      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
