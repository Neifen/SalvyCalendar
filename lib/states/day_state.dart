import 'package:flutter/material.dart';
import 'package:salvy_calendar/models/day_model.dart';

class DayState extends ChangeNotifier {
  bool isDaySelected = false;
  DayModel selectedDay = DayModel(0);

  select(DayModel newDay) {
    isDaySelected = true;
    selectedDay = newDay;

    notifyListeners();
  }

  cancelSelection() {
    isDaySelected = false;
    notifyListeners();
  }
}
