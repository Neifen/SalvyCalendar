import 'dart:html';

import 'package:flutter/material.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:salvy_calendar/models/media_file_model.dart';
import 'package:salvy_calendar/services/storage_getter.dart';
import 'package:salvy_calendar/util/style.dart';

import 'my_progress_indicator.dart';

class BigDayDialog {
  final DayModel selectedDay;

  void showAsAlert(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      backgroundColor: Style.primaryColor,
      content: getDialogContent(),
    );

    showDialog(
      context: context,
      child: dialog,
    );
  }

  void showAsHero(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      backgroundColor: Style.primaryColor,
      content: getDialogContent(),
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
      content: getDialogContent(),
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

  Widget getDialogContent() {
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
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }
                        return displayMedia(snapshot.data);
                      case ConnectionState.active:
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      default:
                        return MyProgressIndicator();
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget displayMedia(MediaFileModel model) {
    List<Widget> columns = [];
    columns.add(Expanded(
      flex: 1,
      child: Container(),
    ));
    columns.add(model.media);

    if (model.hasDescription()) {
      var description = Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(top: 22.0, left: 12.0, right: 12.0),
                child:
                    Text(model.description, style: Style.descriptionTextStyle)),
          ));
      columns.add(description);
    } else {
      columns.add(Expanded(flex: 1, child: Container()));
    }

    return Center(
      child: Column(
        children: columns,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  BigDayDialog(this.selectedDay);
}
