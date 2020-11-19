import 'package:flutter/material.dart';
import 'package:salvy_calendar/pages/calendar_page.dart';
import 'package:salvy_calendar/states/day_state.dart';
import 'package:salvy_calendar/util/style.dart';
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
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
        primarySwatch: Style.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalendarPage(title: 'Salvy Calendar'),
    );
  }
}


