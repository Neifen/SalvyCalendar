import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:salvy_calendar/pages/calendar_page.dart';
import 'package:salvy_calendar/services/storage_getter.dart';

import 'day_service.dart';

class RouteService extends FluroRouter {
  var _corpsNameHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var corpsName = params["id"][0];

    List dayMock = params["day"];
    if (dayMock != null && dayMock.isNotEmpty) {
      DayService.fakeIt(int.parse(dayMock[0]));
    }

    if (corpsName == '/') {
      return CircularProgressIndicator();
    }

    StorageGetter.init(corpsName);
    return CalendarPage(title: corpsName);
  });

  RouteService() {
    define("/:id", handler: _corpsNameHandler);
    define("/:id/:day", handler: _corpsNameHandler);
  }
}
