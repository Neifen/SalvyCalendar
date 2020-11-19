import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/states/day_state.dart';
import 'package:salvy_calendar/style.dart';

class DayContainer extends StatelessWidget {
  final DayModel _dayModel;

  DayContainer(int _day) : _dayModel = DayModel(_day);

  selectDay(BuildContext context) {
    context.read<DayState>().switchSelection(_dayModel);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => selectDay(context),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            key: _dayModel.key,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Style.primaryColor,
                border: Border.all(width: 0)),
            child: Center(
                child: Text(
              _dayModel.title,
              style: Style.buttonTextStyle,
            )),
          ),
        ),
      ),
    );
  }
}
