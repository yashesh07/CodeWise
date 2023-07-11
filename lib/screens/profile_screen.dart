import 'dart:ui';

import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/Theme/font_size.dart';
import 'package:code_wise/models/user_data.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<User?> fetchUserDetails() async {
    UserData userData = UserData(cf_handle: 'yashesh_07');
    return userData.getUser();
  }

  String getShortForm(String s){
    if(s=='legendary grandmaster')  return 'LGM';
    if(s=='international grandmaster')  return 'IG';
    if(s=='international master')  return 'IM';
    if(s=='candidate master')  return 'CM';

    return s;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<User?>(
        future: fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred while fetching user details'),
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(8.0),
              // Top Bar ---------------------------------------------------------------------
              child: Column(
                children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.titlePhoto),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CODE',
                          style: TextStyle(fontSize: 25, fontFamily: 'PlayfairDisplaySC'),
                        ),
                        Image(
                          image: AssetImage('assets/codewise_logo.png'),
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'WISE',
                          style: TextStyle(fontSize: 25, fontFamily: 'PlayfairDisplaySC'),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Icon(Icons.settings_rounded, color: CustomTheme.accentColor(),))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [

                    // Card 1 ---------------------------------------------------------------------

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                CustomTheme.accentColor(),
                                CustomTheme.accentColor(),
                              ],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Profile',
                                style:
                                    TextStyle(fontSize: CustomFont.tag, color: CustomTheme.secondaryTextColor),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Current Rating',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          '${user.rating}',
                                          style: TextStyle(fontSize: CustomFont.bodytext),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Current Status',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          getShortForm(user.rank),
                                          maxLines: 3,
                                          style:
                                              TextStyle(fontSize: CustomFont.bodytext),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Max Rating',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          '${user.maxRating}',
                                          style: TextStyle(fontSize: CustomFont.bodytext),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Max Status',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          getShortForm(user.maxRank),
                                          style:
                                              TextStyle(fontSize: CustomFont.bodytext),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    user.handle,
                                    style: TextStyle(fontSize: CustomFont.heading),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),


                    // Card 2 ---------------------------------------------------------------------


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                CustomTheme.accentColor(),
                                CustomTheme.accentColor(),
                              ],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Stats',
                                style:
                                    TextStyle(fontSize: CustomFont.tag, color: CustomTheme.secondaryTextColor),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Contributions',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          '${user.contribution}',
                                          style: TextStyle(fontSize: CustomFont.bodytext),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Problems Solved',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          'coming soon',
                                          style: TextStyle(fontSize: CustomFont.tag),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Global Rank',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          'coming soon',
                                          style: TextStyle(fontSize: CustomFont.tag),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'No of friends',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          '${user.friendsCount}',
                                          style: TextStyle(fontSize: CustomFont.bodytext),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Max Streak',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          'coming soon',
                                          style: TextStyle(fontSize: CustomFont.tag),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Country Rank',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext, color: CustomTheme.secondaryTextColor),
                                        ),
                                        Text(
                                          'coming soon',
                                          style: TextStyle(fontSize: CustomFont.tag),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),


                    // Problem of the day ---------------------------------------------------------------------


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: CustomTheme.accentColor(),
                            width: 2,
                          ),
                        ),
                        elevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          color: CustomTheme.secondaryBackgroundColor,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "Problem of the day",
                                style:
                                    TextStyle(fontSize: CustomFont.tag, color: CustomTheme.secondaryTextColor),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "Cyclic Rotation",
                                        style: TextStyle(
                                            fontSize: CustomFont.subheading, color: Colors.white),
                                      ),
                                      SizedBox(height: 10),
                                      Text('Codeforces Global Round 20',
                                          style: TextStyle(
                                              fontSize: CustomFont.normaltext,
                                              color: Colors.white)),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.share_rounded,
                                            color: CustomTheme.accentColor(),
                                          ),
                                          Text(
                                            'share',
                                            style: TextStyle(
                                              fontSize: CustomFont.tag,
                                              color: CustomTheme.secondaryTextColor,
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "(*\'Proble of the day\' feature will be available in coming days)",
                      style:
                      TextStyle(fontSize: 5, color: CustomTheme.secondaryTextColor),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                  ],
                ),
              ),
                ],
              )
            );
          } else {
            // If no data is available, display a message indicating no contests found
            return const Center(
              child: Text('No user found'),
            );
          }
        },
      ),
    );
  }
}
