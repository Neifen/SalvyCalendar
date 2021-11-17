import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/providers/navigation_provider.dart';
import 'package:salvy_calendar/services/login_service.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/util/web_version_info.dart';
import 'package:salvy_calendar/view/widgets/footer.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var globalKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Style.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [Text('You\'re an admin')],
          ),
        ),
        bottomSheet: Footer());
  }
}
