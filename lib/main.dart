import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:salvy_calendar/services/route_serivce.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _router = RouteService();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Salvy Calendar',
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/Bern',
        onGenerateRoute: _router.generator);
  }
}
