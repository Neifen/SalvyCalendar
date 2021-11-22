import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvy_calendar/providers/navigation_provider.dart';
import 'package:salvy_calendar/services/login_service.dart';
import 'package:salvy_calendar/util/style.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final globalKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  var errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(80),
        child: Form(
            key: globalKey,
            child: Column(
              children: [
                TextField(
                    onSubmitted: (value) => passwordFocus.requestFocus(),
                    focusNode: emailFocus,
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text('E-Mail'),
                    )),
                TextField(
                    onSubmitted: (value) => _login(context),
                    focusNode: passwordFocus,
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      label: Text(
                        'Password',
                      ),
                    )),
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox.square(
                  dimension: 20,
                ),
                ElevatedButton(onPressed: (() => _login(context)), child: Text("Login"))
              ],
            )),
      ),
    );
  }

  _login(BuildContext context) async {
    try {
      await LoginService().login(emailController.text, passwordController.text);

      emailFocus.unfocus();
      passwordFocus.unfocus();

      context.read<NavigationProvider>().reset();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? '';
      });
    }
  }
}
