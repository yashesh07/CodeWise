import 'package:flutter/material.dart';

import '../data manager/data_fetcher.dart';
import '../widgets/contest_tile.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({super.key});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {

  late Future<Album> futureAlbum;
  late Widget onGoingContest;
  late Widget upComingContest;

  @override
  void initState() {
    super.initState();
    futureAlbum = DataFetcher().fetchAlbum();
    onGoingContest = Center(
      child: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 50,
              itemBuilder: (context, index) {
                return snapshot.data!.result[index].phase!='BEFORE' && snapshot.data!.result[index].phase!='FINISHED' ? ContestTile(
                  id: snapshot.data!.result[index].id,
                  name: snapshot.data!.result[index].name,
                  type: snapshot.data!.result[index].type,
                  phase: snapshot.data!.result[index].phase,
                  frozen: snapshot.data!.result[index].frozen,
                  durationSeconds: snapshot.data!.result[index].durationSeconds,
                  startTimeSeconds: snapshot.data!.result[index].startTimeSeconds,
                  relativeTimeSeconds: snapshot.data!.result[index].relativeTimeSeconds,
                ):null;
              },
            );
          } else if (snapshot.hasError) {
            return const Text('error');
            // return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const SizedBox(
            width: 350,
            height: 350,
            child: Text('loading'),
          );
        },
      ),
    );
    upComingContest = Expanded(
      child: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return snapshot.data!.result[index].phase=='BEFORE' ? ContestTile(
                    id: snapshot.data!.result[index].id,
                    name: snapshot.data!.result[index].name,
                    type: snapshot.data!.result[index].type,
                    phase: snapshot.data!.result[index].phase,
                    frozen: snapshot.data!.result[index].frozen,
                    durationSeconds: snapshot.data!.result[index].durationSeconds,
                    startTimeSeconds: snapshot.data!.result[index].startTimeSeconds,
                    relativeTimeSeconds: snapshot.data!.result[index].relativeTimeSeconds,
                  ):null;
                },
              );
            } else if (snapshot.hasError) {
              return const Text('error');
              // return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const SizedBox(
              width: 350,
              height: 350,
              child: Text('loading'),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Ongoing Contests'),
              ),
            ),
          ),
          onGoingContest,
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Upcoming Contests'),
              ),
            ),
          ),
          upComingContest,
        ],
      ),
    );
  }
}
