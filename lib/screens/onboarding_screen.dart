import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/screens/home_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
                  title: 'Codeforces Profile',                  description: 'View your Codeforces profile details.',
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
          TextButton(
            onPressed: () {
              if (_currentPage < 3) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: CustomTheme.secondaryBackgroundColor
            ),
            child: Text(_currentPage < 3 ? 'Next' : 'Get Started', style: TextStyle(color: CustomTheme.textColor),),
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
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
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
