import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locat_lost/Screens/login.dart';
import 'package:locat_lost/Screens/report_case.dart';
import 'package:locat_lost/Screens/signup.dart';
import 'package:locat_lost/colors.dart';

import 'Screens/home_screen.dart';

void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {




  Widget build(BuildContext context){


    return MaterialApp(

      theme: ThemeData(

        appBarTheme: AppBarTheme(
          foregroundColor: AppColors.secondary,
          backgroundColor: AppColors.primary,
          centerTitle: true,

        ),

        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.primary,
        //     foregroundColor: AppColors.secondary,
        //   ),
        // ),

        // inputDecorationTheme: InputDecorationTheme(
        //  enabledBorder: OutlineInputBorder(
        //    borderSide: BorderSide(
        //     // color: Colors.teal,
        //
        //      width: 1,
        //    ),
        //    borderRadius: BorderRadius.circular(12),
        //
        //  ),
        //  focusedBorder: OutlineInputBorder(
        //    borderSide: BorderSide(
        //      color: AppColors.primary,
        //      width: 1,
        //    ),
        //    borderRadius: BorderRadius.circular(12),
        //  )
        //
        // ),


      ),

      home:  ReportCase(),

    );



  }


}

/*


style: TextStyle(
fontSize: 30,
color: AppColors.primary,
fontWeight: FontWeight.w600,
),

*/