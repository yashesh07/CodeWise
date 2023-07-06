import 'package:code_wise/models/data_fetcher.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/contest_tile.dart';

class ContestsData{

  List<ContestTile> upComingContest = [];
  List<ContestTile> onGoingContest = [];
  static var activeAlarm = <int>[];

 Future<bool> updateData() async {
    DataFetcher df = DataFetcher('https://codeforces.com/api/contest.list?gym=false');
    final data = await df.fetchAlbum();
    print(data['result'][0]);
    if(data['status']=='OK'){
      var temp = <int>[];
      for(int i = 0; i<15; i++){
        if(data['result'][i]['phase']=="BEFORE"){
          if(activeAlarm.contains(data['result'][i]['id'])) temp.add(data['result'][i]['id']);
          upComingContest.add(ContestTile(
              id: data['result'][i]['id'],
              name: data['result'][i]['name'],
              type: data['result'][i]['type'],
              phase: data['result'][i]['phase'],
              frozen: data['result'][i]['frozen'],
              durationSeconds: data['result'][i]['durationSeconds'],
              startTimeSeconds: data['result'][i]['startTimeSeconds'],
              relativeTimeSeconds: data['result'][i]['relativeTimeSeconds']
          ));
        }
        else if(data['result'][i]['phase']!="BEFORE" && data['result'][i]['phase']!="FINISHED"){
          onGoingContest.add(ContestTile(
              id: data['result'][i]['id'],
              name: data['result'][i]['name'],
              type: data['result'][i]['type'],
              phase: data['result'][i]['phase'],
              frozen: data['result'][i]['frozen'],
              durationSeconds: data['result'][i]['durationSeconds'],
              startTimeSeconds: data['result'][i]['startTimeSeconds'],
              relativeTimeSeconds: data['result'][i]['relativeTimeSeconds']
          ));
        }
      }
      for (var i = 0 ; i < onGoingContest.length/2 ; i++) {
        var t = onGoingContest[i];
        onGoingContest[i] = onGoingContest[onGoingContest.length-1-i];
        onGoingContest[onGoingContest.length-1-i] = t;
      }
      for (var i = 0 ; i < upComingContest.length/2 ; i++) {
        var t = upComingContest[i];
        upComingContest[i] = upComingContest[upComingContest.length-1-i];
        upComingContest[upComingContest.length-1-i] = t;
      }
      activeAlarm = temp;
      for(int i = 0; i<upComingContest.length; i++){
        if(activeAlarm.contains(upComingContest[i].id)){
          upComingContest[i].setAlarm = true;
        }
      }
    }
    else{
      return false;
    }
    return true;
  }

  Future<List<ContestTile>> getUpComingContest() async {
   if(await updateData()) {
     return upComingContest;
   } else {
     return [];
   }
  }

  Future<List<ContestTile>> getOnGoingContest() async {
    if(await updateData()) {
      return onGoingContest;
    } else {
      return [];
    }
  }
}