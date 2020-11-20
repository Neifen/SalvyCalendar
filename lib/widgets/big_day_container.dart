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
          return Visibility(
            visible: dayState.isDaySelected &&
                _responsibilities.contains(dayState.selectedDay.day),
            child: AspectRatio(
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
                  future: StorageGetter.getFileName(dayState.selectedDay.day),
                  builder: (context, snapshot) => Text(
                    snapshot.hasData
                        ? snapshot.data
                        : snapshot.hasError
                            ? snapshot.error
                            : "loading...",
                    style: Style.buttonTextStyle,
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
