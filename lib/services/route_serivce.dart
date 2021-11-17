import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/providers/navigation_provider.dart';
import 'package:salvy_calendar/services/storage_getter.dart';
import 'package:salvy_calendar/view/pages/admin_page.dart';
import 'package:salvy_calendar/view/pages/calendar_page.dart';
import 'package:salvy_calendar/view/pages/login_page.dart';

import 'day_service.dart';

class RouteService extends FluroRouter {
  var _corpsNameHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    var corpsName = params["id"]?.first;

    List? dayMock = params["day"];
    if (dayMock != null && dayMock.isNotEmpty) {
      DayService.fakeIt(int.parse(dayMock[0]));
    }

    if (corpsName == null || corpsName == '/') {
      return CircularProgressIndicator();
    }

    StorageGetter.init(corpsName);
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
        builder: (context, child) {
          switch (context.watch<NavigationProvider>().route) {
            case NavigationRoute.login:
              return LoginPage();

            case NavigationRoute.admin:
              return AdminPage();

            case NavigationRoute.main:
              return CalendarPage(title: corpsName);
          }
        });
  });
  RouteService() {
    define("/:id", handler: _corpsNameHandler);
    define("/:id/:day", handler: _corpsNameHandler);
  }
}
