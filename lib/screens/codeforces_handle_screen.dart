import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_wise/Theme/font_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Theme/colors.dart';
import 'home_screen.dart';

class CodeforcesHandle extends StatefulWidget {
  const CodeforcesHandle({super.key});

  @override
  State<CodeforcesHandle> createState() => _CodeforcesHandleState();
}

class _CodeforcesHandleState extends State<CodeforcesHandle> {

  late TextEditingController _handleController;
  User? user = FirebaseAuth.instance.currentUser;
  bool _textfieldLoading = false;
  bool _isLoading = false;

  void _saveCodeforcesHandle(String handle) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('cf_handle', handle);
    if (user != null) {
      String uid = user!.uid;
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      await userRef.set({'codeforcesHandle': handle});
    }
  }

  void initHandle() async{
    setState(() {
      _textfieldLoading = true;
    });
    super.initState();
    if (user != null) {
      String uid = user!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String? codeforcesHandle = snapshot.data()?['codeforcesHandle'];
      if (codeforcesHandle != null) {
        _handleController = TextEditingController(text: codeforcesHandle);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('cf_handle', codeforcesHandle);
      }
      else{
        _handleController = TextEditingController();
      }
    }
    setState(() {
      _textfieldLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initHandle();
  }

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
                child: _textfieldLoading ? const CircularProgressIndicator() : TextField(
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
                child: _isLoading ? const CircularProgressIndicator() : Text('Save Handle', style: TextStyle(color: CustomTheme.textColor),),
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  String handle = _handleController.text;
                  _saveCodeforcesHandle(handle);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  setState(() {
                    _isLoading = false;
                  });
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
