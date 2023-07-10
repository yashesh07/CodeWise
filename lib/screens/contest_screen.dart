import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/models/contests_data.dart';
import 'package:flutter/material.dart';

import '../models/data_fetcher.dart';
import '../widgets/contest_tile.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({super.key});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  Future<List<ContestTile>> fetchUpComingContestDetails() async {
    ContestsData contestsData = ContestsData();
    return contestsData.getUpComingContest();
  }

  Future<List<ContestTile>> fetchOnGoingContestDetails() async {
    ContestsData contestsData = ContestsData();
    return contestsData.getOnGoingContest();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: CustomTheme.secondaryBackgroundColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Ongoing Contests'),
            ),
          ),
          FutureBuilder<List<ContestTile>>(
            future: fetchOnGoingContestDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error occurred while fetching contest details'),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final contests = snapshot.data!;
                return contests.length>=4 ? Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: contests))) : Column(children: contests);
              } else {
                // If no data is available, display a message indicating no contests found
                return const Center(
                  child: Text('No contests found'),
                );
              }
            },
          ),
          const SizedBox(
            height: 4,
          ),
          Card(
            color: CustomTheme.secondaryBackgroundColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Upcoming Contests'),
            ),
          ),
          FutureBuilder<List<ContestTile>>(
            future: fetchUpComingContestDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error occurred while fetching contest details'),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final contests = snapshot.data!;
                return Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: contests)));
              } else {
                // If no data is available, display a message indicating no contests found
                return const Center(
                  child: Text('No contests found'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
