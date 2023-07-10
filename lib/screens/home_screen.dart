import 'dart:ui';
import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/alarm%20manager/alarm_loader.dart';
import 'package:code_wise/screens/analysis_screen.dart';
import 'package:code_wise/screens/contest_screen.dart';
import 'package:code_wise/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<IconData> icons = [
    Icons.home_filled,
    Icons.leaderboard,
    Icons.query_stats,
  ];

  final List<String> tabs = ['Home', 'Contest', 'Analysis'];

  final pages = [
    const ProfileScreen(),
    const ContestScreen(),
    const AnalysisScreen(),
  ];

  int _currentIndex = 0;
  int numberOfPages = 3;

  @override
  void initState() {
    super.initState();
    AlarmLoader al = AlarmLoader();
    al.initiateAlarmLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryBackgroundColor,
      body: Stack(
        children: [
          pages[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomClip(),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: CustomTheme.secondaryBackgroundColor),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: ListWheelScrollView.useDelegate(
                        diameterRatio: 0.7,
                        itemExtent: 100,
                        offAxisFraction: 2.5,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (newIndex) {
                          setState(() {
                            _currentIndex =
                                (newIndex + numberOfPages * 100000) %
                                    numberOfPages;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            int newIndex = (index + numberOfPages * 100000) %
                                numberOfPages;
                            return RotatedBox(
                                quarterTurns: 1,
                                child: Column(children: [
                                  Icon(
                                    icons[newIndex],
                                    color: CustomTheme.accentColor()
                                        .withOpacity(_currentIndex == newIndex
                                            ? 1
                                            : 0.25),
                                    size: _currentIndex == newIndex ? 40 : 20,
                                  ),
                                  AnimatedDefaultTextStyle(
                                    duration: Duration(milliseconds: 400),
                                    style: TextStyle(
                                        fontSize:
                                            _currentIndex == newIndex ? 10 : 5),
                                    child: Text(tabs[newIndex], style: TextStyle(fontFamily: 'RobotoMono'),),
                                  ),
                                ]));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 250;

    Path path = Path();
    path
      ..moveTo(size.width / 2, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(size.width / 2, 0),
        radius: Radius.circular(radius),
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
