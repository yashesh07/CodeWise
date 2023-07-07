import 'dart:ui';

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
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [


                    // Top Bar ---------------------------------------------------------------------

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.titlePhoto),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CODE',
                                style: TextStyle(fontSize: 25),
                              ),
                              Image(
                                image: AssetImage('assets/codewise_logo.png'),
                                height: 25,
                                width: 25,
                              ),
                              Text(
                                'WISE',
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Icon(Icons.settings_rounded))
                        ],
                      ),
                    ),



                    // Card 1 ---------------------------------------------------------------------


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade900,
                                Colors.blueGrey,
                              ],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Profile',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
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
                                        const Text(
                                          'Current Rating',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        Text(
                                          '${user.rating}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Current Status',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        Text(
                                          getShortForm(user.rank),
                                          maxLines: 3,
                                          style:
                                              const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Max Rating',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        Text(
                                          '${user.maxRating}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Max Status',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        Text(
                                          getShortForm(user.maxRank),
                                          style:
                                              const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    user.handle,
                                    style: const TextStyle(fontSize: 32),
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
                                Colors.blue.shade900,
                                Colors.blueGrey,
                              ],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Stats',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
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
                                        const Text(
                                          'Contributions',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        Text(
                                          '${user.contribution}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Problems Solved',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        const Text(
                                          '354',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Problems Solved',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        const Text(
                                          '354',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'No of friends',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        Text(
                                          '${user.friendsCount}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Max Streak',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        const Text(
                                          '365',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Problems Solved',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                        const Text(
                                          '354',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
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
                            color: Colors.blue.shade900,
                            width: 2,
                          ),
                        ),
                        elevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                "Problem of the day",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "Cyclic Rotation",
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.white),
                                      ),
                                      SizedBox(height: 10),
                                      Text('Codeforces Global Round 20',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white)),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.code,
                                            color: Colors.blue,
                                            size: 50,
                                          ),
                                          Text(
                                            'solve',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white54,
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
                  ],
                ),
              ),
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
