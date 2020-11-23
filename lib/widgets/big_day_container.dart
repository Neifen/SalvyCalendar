import 'package:flutter/material.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:salvy_calendar/services/storage_getter.dart';
import 'package:salvy_calendar/util/style.dart';

class BigDayContainer extends StatelessWidget {
  final DayModel selectedDay;

  void showAsAlert(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      backgroundColor: Style.primaryColor,
      content: this,
    );

    showDialog(
      context: context,
      child: dialog,
    );
  }

  void showAsHero(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      backgroundColor: Style.primaryColor,
      content: this,
    );

    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withAlpha(150),
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return dialog;
        }));
  }

  void showWithAnimation(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      backgroundColor: Style.primaryColor,
      content: this,
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "close",
      barrierDismissible: true,
      pageBuilder: (context, animation, secondaryAnimation) {},
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          Transform.scale(scale: animation.value, child: dialog),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Hero(
        tag: selectedDay.title,
        transitionOnUserGestures: true,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Style.primaryColor,
                border: Border.all(color: Style.primaryColor)),
            child: Center(
              child: FutureBuilder(
                  future: StorageGetter.getContent(selectedDay.day),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return snapshot.data;
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return CircularProgressIndicator(
                            backgroundColor: Colors.blue);
                      }
                    } else {
                      return CircularProgressIndicator(
                          backgroundColor: Colors.blue);
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  BigDayContainer(this.selectedDay);
}
