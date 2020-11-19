import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/states/day_state.dart';
import 'package:salvy_calendar/style.dart';
import 'package:salvy_calendar/widgets/big_day_container.dart';
import 'package:salvy_calendar/widgets/day_container.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key key, this.title}) : super(key: key);

  final String title;
  final ScrollController _scrollController =  ScrollController();

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

  @override
  Widget build(BuildContext context) {

   /* if(Provider.of<DayState>(context).selectedDay != null){
      _scrollController.jumpTo(_scrollController.positions.first.minScrollExtent);
    }*/
    _scrollController.addListener(() {
      print("here I listen");
    });


    return Scaffold(
      backgroundColor: Style.backgroundColor,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizeChangedLayoutNotifier(
            child: SingleChildScrollView(
               controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: createDaysList(1),
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}