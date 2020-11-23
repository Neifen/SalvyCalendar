import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:salvy_calendar/states/day_state.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/widgets/big_day_container.dart';

class DayContainer extends StatelessWidget {
  final DayModel _dayModel;

  DayContainer(int _day) : _dayModel = DayModel(_day);

  selectDay(BuildContext context) {
    context.read<DayState>().select(_dayModel);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          BigDayContainer(_dayModel).showAsHero(context);
        },
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Hero(
            tag: _dayModel.title,
            transitionOnUserGestures: true,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Style.primaryColor,
                    border: Border.all(color: Style.primaryColor)),
                child: Center(
                    child: Text(
                  _dayModel.title,
                  style: Style.buttonTextStyle,
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
