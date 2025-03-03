import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locatlost/screens/home_screen.dart';
import 'colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locate Lost',
      home: HomeScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor:  myPrimaryColor,
        ),
        primaryColor: myPrimaryColor,
        colorScheme: ColorScheme.fromSeed(
            seedColor: myPrimaryColor,
            primary: myPrimaryColor,
            secondary: Colors.teal[50],

        ),

        scaffoldBackgroundColor: Colors.white,


        textButtonTheme: TextButtonThemeData(),
      ),
    );
  }
}
