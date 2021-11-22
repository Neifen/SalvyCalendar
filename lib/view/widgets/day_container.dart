import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:salvy_calendar/util/day_util.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/view/widgets/big_day_container.dart';

class DayContainer extends StatelessWidget {
  final DayModel _dayModel;

  DayContainer(String _day) : _dayModel = DayModel(_day);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (DayUtil.isDayAvailable(_dayModel)) {
            BigDayDialog(_dayModel).showAsHero(context);
          }
        },
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Hero(
            tag: _dayModel.title,
            flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => Container(
              color: Style.primaryColor,
            ),
            transitionOnUserGestures: true,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0), color: DayUtil.getColor(_dayModel), border: Border.all(color: DayUtil.getColor(_dayModel))),
                child: Stack(
                  children: [
                    positionDeco(_dayModel.day, 1, context),
                    positionDeco(_dayModel.day, 2, context),
                    positionDeco(_dayModel.day, 3, context),
                    Center(
                        child: Text(
                      _dayModel.title,
                      style: Style.buttonTextStyle,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget positionDeco(int day, int nr, BuildContext context) {
    var point = Style.randomPoints[(day - 1) % 12];
    var child = Icon(
      Icons.star,
      color: Style.decoColor,
      size: Style.convertForScreen(20.0, context),
    );

    switch (nr) {
      case 1:
        return Positioned(child: child, top: Style.convertForScreen(point[0].x, context), left: Style.convertForScreen(point[0].y, context));
      case 2:
        return Positioned(child: child, top: Style.convertForScreen(point[1].x, context), right: Style.convertForScreen(point[1].y, context));
      default:
        return Positioned(child: child, left: Style.convertForScreen(point[2].x, context), bottom: Style.convertForScreen(point[2].y, context));
    }
  }
}
