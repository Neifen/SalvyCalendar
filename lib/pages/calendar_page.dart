import 'package:flutter/material.dart';
import 'package:salvy_calendar/services/cookie_service.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/util/web_version_info.dart';
import 'package:salvy_calendar/widgets/day_container.dart';

class CalendarPage extends StatelessWidget {
  List<String> dayOrder;

  CalendarPage({Key key, this.title}) : super(key: key) {
    loadDayOrders();
  }

  Future<List<String>> loadDayOrders() async {
    if (dayOrder == null) {
      var cookies = await CookieService.getInstance();
      if (cookies.has(CookieService.DAY_LIST)) {
        dayOrder = cookies.loadList(CookieService.DAY_LIST);
      } else {
        dayOrder = List.generate(24, (index) => (index + 1).toString());
        dayOrder.shuffle();
        cookies.saveList(CookieService.DAY_LIST, dayOrder);
      }
    }
    return dayOrder;
  }

  final String title;

  Row createDayRow(List<String> list) {
    List<Widget> newList = list.map((e) => DayContainer(e)).toList();
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: newList);
  }

  List<Widget> createDaysList(List<String> dayList) {
    return [
      createDayRow(dayList.sublist(0, 4)),
      createDayRow(dayList.sublist(4, 8)),
      createDayRow(dayList.sublist(8, 12)),
      createDayRow(dayList.sublist(12, 16)),
      createDayRow(dayList.sublist(16, 20)),
      createDayRow(dayList.sublist(20, 24)),
    ];
  }

  String getVersionNr() {
    //could be async in future if package_info allows web tow ork
    if (!WebVersionInfo.showVersion)
      return "created by Nathan Bourquin - neifen.b@gmail.com";

    return "created by Nathan Bourquin - neifen.b@gmail.com - ${WebVersionInfo.name}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Adventskalender",
                      style: Style.titleTextSTyle,
                    )),
                FutureBuilder(
                  future: loadDayOrders(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: createDaysList(snapshot.data),
                        )
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Wrap(children: [
        Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Text(
              getVersionNr(),
              style: Style.infoTextStyle,
            )),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
