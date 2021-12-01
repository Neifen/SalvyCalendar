import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:salvy_calendar/models/day_model.dart';
import 'package:salvy_calendar/models/media_file_model.dart';
import 'package:salvy_calendar/services/days_service.dart';
import 'package:salvy_calendar/util/style.dart';

import 'my_progress_indicator.dart';

class BigDayDialog {
  final DayModel selectedDay;

  void showAsHero(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      contentPadding: EdgeInsets.all(8),
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

  Widget getDialogContent() {
    return DialogContent(selectedDay);
  }

  BigDayDialog(this.selectedDay);
}

class DialogContent extends StatelessWidget {
  final DayModel selectedDay;

  DialogContent(this.selectedDay);

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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Style.primaryColor, border: Border.all(color: Style.primaryColor)),
            child: Center(
              child: FutureBuilder<MediaFileModel>(
                  future: DaysService.getContent(selectedDay.day),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      return displayMedia(snapshot.data!, context);
                    }
                    return MyProgressIndicator();
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget displayMedia(MediaFileModel model, BuildContext context) {
    if (model.media == null) {
      return Icon(Icons.filter);
    }
    List<Widget> columns = [];
    columns.add(Expanded(
      flex: 1,
      child: Container(),
    ));
    columns.add(Expanded(flex: 10, child: model.media!));

    if (model.hasDescription()) {
      var description = Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(
                    top: Style.convertForScreen(10.0, context), left: Style.convertForScreen(4.0, context), right: Style.convertForScreen(4.0, context)),
                child: Text(model.description,
                    style: TextStyle(color: Style.textColor, fontFamily: Style.descriptionFontfamily, fontSize: Style.convertForScreen(8.0, context)))),
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
}
