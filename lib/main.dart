import 'package:fluro/fluro.dart';
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
    final router = FluroRouter();

    router.define("/:id", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var corpsName = params["id"][0];
          if(corpsName=='/'){
            return CircularProgressIndicator();
          }
      return CalendarPage(title: corpsName, corpsName: corpsName);
    }));

    return MaterialApp(
        title: 'Salvy Calendar',
        theme: ThemeData(
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
          primarySwatch: Style.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/Bern',
        onGenerateRoute: router.generator);
  }
}
