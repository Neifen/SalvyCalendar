import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/services/storage_getter.dart';
import 'package:salvy_calendar/states/day_state.dart';
import 'package:salvy_calendar/util/style.dart';

class BigDayContainer extends StatelessWidget {
  final List<int> _responsibilities;

  BigDayContainer(this._responsibilities);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<DayState>(
        builder: (context, dayState, child) {
          if (dayState.isDaySelected &&
              _responsibilities.contains(dayState.selectedDay.day)) {
            return AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                key: dayState.selectedDay.key,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Style.primaryColor,
                    border: Border.all(width: 0)),
                child: Center(
                    child: FutureBuilder(
                        future:
                            StorageGetter.getContent(dayState.selectedDay.day),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return snapshot.data;
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return CircularProgressIndicator(backgroundColor: Colors.blue);
                            }
                          } else {
                            return CircularProgressIndicator(backgroundColor: Colors.blue);
                          }
                        })),
              ),
            );
          } else
            return Container();
        },
      ),
    );
  }
}
