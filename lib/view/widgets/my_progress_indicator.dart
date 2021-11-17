import 'package:flutter/material.dart';
import 'package:salvy_calendar/util/style.dart';

class MyProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Style.primaryColor,
        valueColor: AlwaysStoppedAnimation(Style.decoColor),
      ),
    );
  }
}
