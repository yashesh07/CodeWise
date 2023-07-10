import 'package:alarm/model/alarm_settings.dart';
import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/Theme/font_size.dart';
import 'package:code_wise/alarm%20manager/alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../alarm manager/alarm_loader.dart';

class ContestTile extends StatefulWidget {

  final int id;
  final String name;
  final String type;
  final String phase;
  final bool frozen;
  final int durationSeconds;
  final int startTimeSeconds;
  final int relativeTimeSeconds;
  bool setAlarm = false;

  late AlarmManager am;

  ContestTile({super.key,
    required this.id,
    required this.name,
    required this.type,
    required this.phase,
    required this.frozen,
    required this.durationSeconds,
    required this.startTimeSeconds,
    required this.relativeTimeSeconds,
  });

  @override
  State<ContestTile> createState() => _ContestTileState();
}

class _ContestTileState extends State<ContestTile> {

  @override
  void initState() {
    super.initState();
    widget.am = AlarmManager();
  }

  void triggerClock(){
    setState(() {
      widget.setAlarm = !widget.setAlarm;
    });
    if(widget.setAlarm){
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(widget.startTimeSeconds*1000);
      dateTime = dateTime.subtract(const Duration(minutes: 15));
      // DateTime dateTime = DateTime.now();
      // dateTime = dateTime.add(const Duration(minutes: 3));
      AlarmSettings alarmSettings = AlarmSettings(
        id: widget.id,
        dateTime: dateTime,
        loopAudio: true,
        vibrate: true,
        notificationTitle: 'Codeforces contest reminder',
        notificationBody: 'Content name (${widget.id}) is going to start',
        assetAudioPath: 'assets/marimba.mp3',
        stopOnNotificationOpen: false,
      );
      widget.am.saveAlarm(alarmSettings);
      AlarmLoader al = AlarmLoader();
      al.initiateAlarmLoader(context);
    }
    else{
      widget.am.deleteAlarm(widget.id);
      AlarmLoader al = AlarmLoader();
      al.initiateAlarmLoader(context);
    }
  }

  String getDateTime(int time){
    return DateFormat('dd/MM/yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(time*1000));
  }

  String getDurationFormat(int time){
    int hour = (time~/3600);
    int minutes = (time%3600)~/60;
    return "${hour==0 ? "" : "$hour hr"} ${minutes==0 ? "" : "$minutes m"}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomTheme.thirdBackgroundColor,
      child: ListTile(
        title: Text(widget.name, style: TextStyle(fontSize: CustomFont.normaltext),),
        subtitle: Text(
            'Start: ${getDateTime(widget.startTimeSeconds)}\nDuration: ${getDurationFormat(widget.durationSeconds)}',
            style: TextStyle(fontSize: CustomFont.normaltext),
        ),
        trailing: TextButton(
          onPressed: triggerClock,
          child: SizedBox(
            height: 50,
            width: 50,
            child: widget.phase=="BEFORE" ? Center(child: widget.setAlarm ? Icon(Icons.alarm_on, color: CustomTheme.successColor,) : Icon(Icons.alarm, color: CustomTheme.highlightColor,)):null,
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}