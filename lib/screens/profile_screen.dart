import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.blue.shade900,
                    spreadRadius: -1,
                    blurRadius: 5,
                  )
                ]),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Expert'),
                  Text('yashesh_07'),
                  Text('1617 (max 2100, master)'),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
