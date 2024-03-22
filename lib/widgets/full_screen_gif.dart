import 'package:flutter/material.dart';

class FullScreenGif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/gif/pokemon-day.gif',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
