import 'package:auth_app/screens/login_screen.dart';
import 'package:auth_app/screens/registor.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isShow = true;
  void toglle() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isShow) {
      return LoginScreen(
        onTap: toglle,
      );
    } else {
      return Registration(
        onTap: toglle,
      );
    }
  }
}
