import 'package:flutter/material.dart';
import 'package:salvy_calendar/models/day_model.dart';

class DayState extends ChangeNotifier{
  bool isDaySelected = false;
  DayModel selectedDay = DayModel(0);

  switchSelection(DayModel newDay){
    //turn selection around
    isDaySelected = !isDaySelected;

    //except if its a new selection. Then set selection back to true
    if(newDay!=selectedDay){
      isDaySelected= true;
      selectedDay = newDay;
    }
    notifyListeners();
  }
}