import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/services/route_serivce.dart';
import 'package:salvy_calendar/states/day_state.dart';

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
    var _router = RouteService();

    return MaterialApp(
        title: 'Salvy Calendar',
        theme: ThemeData(
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/Bern/13',
        onGenerateRoute: _router.generator);
  }
}
