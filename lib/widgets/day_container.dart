import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:salvy_calendar/services/day_service.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/widgets/big_day_container.dart';

class DayContainer extends StatelessWidget {
  final DayModel _dayModel;

  DayContainer(String _day) : _dayModel = DayModel(_day);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (DayService.isDayAvailable(_dayModel)) {
            BigDayContainer(_dayModel).showAsHero(context);
          }
        },
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Hero(
            tag: _dayModel.title,
            flightShuttleBuilder: (flightContext, animation, flightDirection,
                    fromHeroContext, toHeroContext) =>
                Container(
              color: Style.primaryColor,
            ),
            transitionOnUserGestures: true,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: DayService.getColor(_dayModel),
                    border: Border.all(color: DayService.getColor(_dayModel))),
                child: Stack(
                  children: [
                    positionDeco(
                        _dayModel.day,
                        1,
                        Icon(
                          Icons.star,
                          color: Style.deco,
                        )),
                    positionDeco(
                        _dayModel.day,
                        2,
                        Icon(
                          Icons.star,
                          color: Style.deco,
                        )),
                    positionDeco(
                        _dayModel.day,
                        3,
                        Icon(
                          Icons.star,
                          color: Style.deco,
                        )),
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

  Widget getRandomPlacement(Widget child) {
    const size = 8;

    var columns = List<Widget>(size);
    columns.fillRange(0, size, Expanded(child: Container()));

    var rows = List<Widget>(size);
    rows.fillRange(0, size, Expanded(child: Container()));

    var columnNr = Random().nextInt(size);
    var rowNr;
    do {
      rowNr = Random().nextInt(size);
    } while ((columnNr >= 3 && columnNr <= 6) && (rowNr >= 3 && rowNr <= 6));

    rows[rowNr] = child;
    var rowWidget = Row(children: rows);
    columns[columnNr] = rowWidget;

    var columnWidget = Column(
      children: columns,
    );

    return columnWidget;
  }

  Widget positionDeco(int day, int nr, Widget child) {
    var point = Style.randomPoints[(day - 1) % 12];

    switch (nr) {
      case 1:
        return Positioned(child: child, top: point[0].x, left: point[0].y);
      case 2:
        return Positioned(child: child, top: point[1].x, right: point[1].y);
      default:
        return Positioned(child: child, left: point[2].x, bottom: point[2].y);
    }
  }
}
