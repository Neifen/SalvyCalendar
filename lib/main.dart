import 'package:flutter/material.dart';
import 'package:salvy_calendar/pages/calendar_page.dart';
import 'package:salvy_calendar/states/day_state.dart';
import 'package:salvy_calendar/style.dart';
import 'package:salvy_calendar/widgets/big_day_container.dart';

import 'widgets/day_container.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => DayState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salvy Calendar',
      theme: ThemeData(
        primarySwatch: Style.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalendarPage(title: 'Salvy Calendar'),
    );
  }
}


