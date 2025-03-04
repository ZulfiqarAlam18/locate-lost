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

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: bgColor,
            backgroundColor: myPrimaryColor,
            textStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,


            ),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            minimumSize: Size(241,60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),


          ),
        ),

        // textTheme: TextTheme(
        //  bodyText1: TextStyle(
        //    fontFamily: 'Poppins',
        //    fontWeight: FontWeight.w600,
        //    color: Colors.white,
        //
        //  )
        //
        // ),


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
