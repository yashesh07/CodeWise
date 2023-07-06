import 'package:code_wise/models/contests_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  ContestTile({super.key,
    required this.id,
    required this.name,
    required this.type,
    required this.phase,
    required this.frozen,
    required this.durationSeconds,
    required this.startTimeSeconds,
    required this.relativeTimeSeconds,
    se
  });

  @override
  State<ContestTile> createState() => _ContestTileState();
}

class _ContestTileState extends State<ContestTile> {

  void triggerClock(){
    setState(() {
      widget.setAlarm = !widget.setAlarm;
    });
    if(widget.setAlarm){
      ContestsData.activeAlarm.add(widget.id);
    }
    else{
      ContestsData.activeAlarm.remove(widget.id);
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
      child: ListTile(
        title: Text(widget.name),
        subtitle: Text(
            'Start: ${getDateTime(widget.startTimeSeconds)}\nDuration: ${getDurationFormat(widget.durationSeconds)}'
        ),
        trailing: TextButton(
          onPressed: triggerClock,
          child: SizedBox(
            height: 50,
            width: 50,
            child: widget.phase=="BEFORE" ? Center(child: widget.setAlarm ? Icon(Icons.alarm_on, color: Colors.greenAccent,) : Icon(Icons.alarm)):null,
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}