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
                    getRandomPlacements(
                        1,
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        )),
                    getRandomPlacements(
                        2,
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        )),
                    getRandomPlacements(
                        3,
                        Icon(
                          Icons.star,
                          color: Colors.white,
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

  Widget getRandomPlacements(int nr, Widget child) {
    const randomPoints = [
      Point(20.0, 5.0),
      Point(31.0, 10.0),
      Point(50.0, 15.0),
      Point(15.0, 10.0),
      Point(10.0, 5.0),
      Point(20.0, 15.0)
    ];

    var index = Random().nextInt(randomPoints.length);
    var point = randomPoints[index];

    switch (nr) {
      case 1:
        return Positioned(child: child, top: point.x, left: point.y);
      case 2:
        return Positioned(child: child, top: point.x, right: point.y);
      default:
        return Positioned(child: child, left: point.x, bottom: point.y);
    }
  }
}
