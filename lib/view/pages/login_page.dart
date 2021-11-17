import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/providers/navigation_provider.dart';
import 'package:salvy_calendar/services/login_service.dart';
import 'package:salvy_calendar/util/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var globalKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(80),
        child: Form(
            key: globalKey,
            child: Column(
              children: [
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text('E-Mail'),
                    )),
                TextField(
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      label: Text(
                        'Password',
                      ),
                    )),
                ElevatedButton(
                    onPressed: (() {
                      LoginService().login(emailController.text, passwordController.text);
                      context.read<NavigationProvider>().reset();
                    }),
                    child: Text("Login"))
              ],
            )),
      ),
    );
  }
}
