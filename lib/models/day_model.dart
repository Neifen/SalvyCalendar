import 'package:flutter/cupertino.dart';

class DayModel {
  final String title;
  final Key key;
  final int day;

  DayModel(this.day)
      : this.title = day.toString(),
        key = Key(day.toString());
}
