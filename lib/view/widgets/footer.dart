import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/providers/navigation_provider.dart';
import 'package:salvy_calendar/services/login_service.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/util/web_version_info.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                WebVersionInfo.getVersionNr(),
                style: Style.infoTextStyle,
              ),
              Visibility(
                visible: context.watch<NavigationProvider>().route != NavigationRoute.main,
                child: TextButton(
                    onPressed: () {
                      context.read<NavigationProvider>().reset();
                    },
                    child: Text(
                      'Home',
                      style: Style.infoTextStyle,
                    )),
              ),
              Visibility(
                visible: LoginService().isLoggedIn() && context.watch<NavigationProvider>().route != NavigationRoute.admin,
                child: TextButton(
                    onPressed: () {
                      context.read<NavigationProvider>().admin();
                    },
                    child: Text(
                      'Admin',
                      style: Style.infoTextStyle,
                    )),
              ),
              Visibility(
                visible: !LoginService().isLoggedIn(),
                child: TextButton(
                    onPressed: () {
                      context.read<NavigationProvider>().login();
                    },
                    child: Text(
                      'Login',
                      style: Style.infoTextStyle,
                    )),
              ),
              Visibility(
                visible: LoginService().isLoggedIn(),
                child: TextButton(
                    onPressed: () {
                      LoginService().logout();
                      context.read<NavigationProvider>().reset();
                    },
                    child: Text(
                      '- Logout',
                      style: Style.infoTextStyle,
                    )),
              )
            ],
          )),
    ]);
  }
}
