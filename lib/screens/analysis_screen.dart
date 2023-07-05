import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('https://cdn.wallpapersafari.com/91/22/QTHZaL.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
