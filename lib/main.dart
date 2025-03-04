import 'package:flutter/material.dart';
import 'package:locatlost/demo.dart';
import 'colors.dart';

import 'views/splash/spalsh_1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locate Lost',
      home: Spalsh1(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: myPrimaryColor,
        ),
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: myPrimaryColor,
          primary: myPrimaryColor,
          secondary: Colors.teal[50],
        ),
      ),
    );
  }
}
