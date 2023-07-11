import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/screens/codeforces_handle_screen.dart';
import 'package:code_wise/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CodeforcesHandle()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                OnboardingPage(
                  title: 'Codeforces Profile',
                  description: 'View your Codeforces profile details.',
                  image: 'assets/ob_profile.png',
                ),
                OnboardingPage(
                  title: 'Contest Reminder',
                  description: 'Get reminders for upcoming Codeforces contests.',
                  image: 'assets/ob_contest.png',
                ),
                OnboardingPage(
                  title: 'Performance Analysis',
                  description: 'Track and analyze your Codeforces performance using interactive graphs.',
                  image: 'assets/ob_performance.png',
                ),
                OnboardingPage(
                  title: 'Problem of the Day',
                  description: 'Challenge yourself with a daily coding problem.',
                  image: 'assets/ob_problem.png',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextButton(
              onPressed: () async{
                if (_currentPage < 3) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                    if (googleUser != null) {
                      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                      final OAuthCredential credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );
                      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                      final User? user = userCredential.user;
                      // Handle signed-in user
                      _navigateToHomeScreen(context);
                    } else {
                      print('Failed');
                    }
                  } catch (e) {
                    // Handle sign-in error
                    print(e);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: CustomTheme.secondaryBackgroundColor
              ),
              child: _currentPage < 3 ? Text('Next', style: TextStyle(color: CustomTheme.textColor),):
                  _isLoading ? const CircularProgressIndicator() :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/google-logo.png',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Continue with Google', style: TextStyle(color: CustomTheme.textColor),)
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 4; i++) {
      indicators.add(
        i == _currentPage
            ? _indicator(true)
            : _indicator(false),
      );
    }

    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 2,
      width: 24,
      decoration: BoxDecoration(
        color: isActive ? CustomTheme.accentColor() : CustomTheme.thirdBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  OnboardingPage({required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
