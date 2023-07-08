import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';

class AlarmManager {

  late AlarmSettings? alarmSettings;

  final int alarmTime;
  final int id;

  AlarmManager({
    required this.alarmTime,
    required this.id,
});

  void buildAlarmSettings() {
    // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(alarmTime*1000);
    // dateTime = dateTime.subtract(const Duration(minutes: 10));
    DateTime dateTime = DateTime.now();
    dateTime = dateTime.add(const Duration(minutes: 3));
    alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      loopAudio: true,
      vibrate: true,
      notificationTitle: 'Codeforces contest reminder',
      notificationBody: 'Content name ($id) is going to start',
      assetAudioPath: 'assets/marimba.mp3',
      stopOnNotificationOpen: false,
    );
  }

  void saveAlarm() {
    buildAlarmSettings();
    Alarm.set(alarmSettings: alarmSettings!);
  }

  void deleteAlarm() {
    Alarm.stop(alarmSettings!.id);
  }
}