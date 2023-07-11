import 'package:code_wise/Theme/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme/colors.dart';
import 'home_screen.dart';

class CodeforcesHandle extends StatefulWidget {
  const CodeforcesHandle({super.key});

  @override
  State<CodeforcesHandle> createState() => _CodeforcesHandleState();
}

class _CodeforcesHandleState extends State<CodeforcesHandle> {

  TextEditingController _handleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CustomTheme.secondaryBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 50),
                child: Text('Enter your Codeforces handle', style: TextStyle(color: CustomTheme.textColor, fontSize: CustomFont.heading),),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _handleController,
                  decoration: const InputDecoration(
                    labelText: 'Codeforces Handle',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: CustomTheme.thirdBackgroundColor,
                ),
                child: Text('Save Handle', style: TextStyle(color: CustomTheme.textColor),),
                onPressed: () {
                  String handle = _handleController.text;
                  // TODO: Save the handle and perform any necessary actions
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "(*Make sure you have entered correct Codeforces handle or else you may face some unknown error or data)",
                  style:
                  TextStyle(fontSize: 5, color: CustomTheme.secondaryTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _handleController.dispose();
    super.dispose();
  }
}
