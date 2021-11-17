import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/providers/navigation_provider.dart';
import 'package:salvy_calendar/services/cookie_service.dart';
import 'package:salvy_calendar/services/login_service.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/util/web_version_info.dart';
import 'package:salvy_calendar/view/widgets/day_container.dart';
import 'package:salvy_calendar/view/widgets/footer.dart';

class CalendarPage extends StatelessWidget {
  List<String> dayOrder = [];

  CalendarPage({Key? key, required this.title}) : super(key: key) {
    loadDayOrders();
  }

  Future<List<String>> loadDayOrders() async {
    if (dayOrder.isEmpty) {
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
                FutureBuilder<List<String>>(
                  future: loadDayOrders(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: createDaysList(snapshot.data!),
                        )
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Footer(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
