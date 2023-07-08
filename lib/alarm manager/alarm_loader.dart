import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:code_wise/screens/ring_screen.dart';
import 'package:flutter/material.dart';

class AlarmLoader {

  late List<AlarmSettings> alarms;
  static StreamSubscription? subscription;
  late BuildContext _context;

  void initiateAlarmLoader(BuildContext context){
    _context = context;
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
          (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadAlarms() {
    alarms = Alarm.getAlarms();
    alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async { // when alarm rings
    await Navigator.push(
        _context,
        MaterialPageRoute(
          builder: (context) =>
              RingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  void dispose() {
    subscription?.cancel();
  }

}