import 'package:alarm/model/alarm_settings.dart';
import 'package:code_wise/alarm%20manager/alarm_loader.dart';
import 'package:code_wise/models/data_fetcher.dart';

import '../widgets/contest_tile.dart';

class ContestsData{

  List<ContestTile> upComingContest = [];
  List<ContestTile> onGoingContest = [];

 Future<bool> updateData() async {
    DataFetcher df = DataFetcher('https://codeforces.com/api/contest.list?gym=false');
    final data = await df.fetchAlbum();
    print(data['result'][0]);
    if(data['status']=='OK'){
      for(int i = 0; i<15; i++){
        if(data['result'][i]['phase']=="BEFORE"){
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
      var activeAlarm = <int>[];
      AlarmLoader al = AlarmLoader();
      al.loadAlarms();
      for(AlarmSettings alarm in al.alarms){
        activeAlarm.add(alarm.id);
      }
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