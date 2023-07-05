import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('https://images.wallpapersden.com/image/download/sun-in-retro-wave-mountains_a2VsZ2yUmZqaraWkpJRobWllrWdma2U.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
