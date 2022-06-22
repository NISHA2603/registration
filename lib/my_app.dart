import 'package:flutter/material.dart';
import 'package:registration/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),

      home: LoginScreen(),
    );
  }
}
