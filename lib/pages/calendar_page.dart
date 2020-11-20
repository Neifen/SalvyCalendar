import 'package:flutter/material.dart';
import 'package:salvy_calendar/services/storage_getter.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/util/web_version_info.dart';
import 'package:salvy_calendar/widgets/big_day_container.dart';
import 'package:salvy_calendar/widgets/day_container.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key key, this.title}) : super(key: key);

  final String title;

  Row createDayRow(int startDay) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      DayContainer(startDay++),
      DayContainer(startDay++),
      DayContainer(startDay++),
      DayContainer(startDay++),
    ]);
  }

  Row createBigDayContainer(int startDay) {
    var dayList = [startDay, startDay + 1, startDay + 2, startDay + 3];
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      BigDayContainer(dayList),
    ]);
  }

  List<Widget> createDaysList(int startDay) {
    return [
      createDayRow(startDay),
      createBigDayContainer(startDay),
      createDayRow(startDay = startDay + 4),
      createBigDayContainer(startDay),
      createDayRow(startDay = startDay + 4),
      createBigDayContainer(startDay),
      createDayRow(startDay = startDay + 4),
      createBigDayContainer(startDay),
      createDayRow(startDay = startDay + 4),
      createBigDayContainer(startDay),
      createBigDayContainer(startDay = startDay + 4),
      createDayRow(startDay),
    ];
  }

  String getVersionNr() {
    //could be async in future if package_info allows web tow ork
    if(!WebVersionInfo.showVersion) return "";

    return "${WebVersionInfo.name} + ${WebVersionInfo.build}";
  }

  @override
  Widget build(BuildContext context) {

    print(StorageGetter().getOverview());

    return Scaffold(
      backgroundColor: Style.backgroundColor,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: createDaysList(1),
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
