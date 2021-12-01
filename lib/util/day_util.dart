import 'package:flutter/material.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:salvy_calendar/util/style.dart';

class DayUtil {
  static final _year = 2021;
  static DateTime? _today;

  static _init() {
    if (_today == null) {
      DateTime _now = DateTime.now();
      _today = DateTime(_now.year, _now.month, _now.day);
    }
  }

  static fakeIt(int day) {
    _today = DateTime(_year, 12, day);
  }

  static bool isDayToday(DayModel day) {
    _init();
    DateTime dateDay = DateTime(_year, 12, day.day);
    return dateDay.isAtSameMomentAs(_today!);
  }

  static bool isDayAvailable(DayModel day) {
    _init();
    DateTime dateDay = DateTime(_year, 12, day.day);
    return dateDay.isBefore(_today!) || dateDay.isAtSameMomentAs(_today!);
  }

  static Color getColor(DayModel day) {
    if (isDayToday(day)) {
      return Style.todayColor;
    } else if (isDayAvailable(day)) {
      return Style.primaryColor;
    } else {
      return Style.unavailableColor;
    }
  }
}
