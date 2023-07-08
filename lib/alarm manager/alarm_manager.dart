import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';

class AlarmManager {

  void saveAlarm(AlarmSettings alarmSettings) {
    Alarm.set(alarmSettings: alarmSettings!);
  }

  void deleteAlarm(int id) {
    Alarm.stop(id);
  }
}