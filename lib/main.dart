import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locat_lost/Screens/SplashScreens/splash1.dart';
import 'package:locat_lost/Screens/child_info.dart';
import 'package:locat_lost/Screens/display_info.dart';
import 'package:locat_lost/Screens/drawer_screens/about_us.dart';
import 'package:locat_lost/Screens/drawer_screens/emergency.dart';
import 'package:locat_lost/Screens/login.dart';
import 'package:locat_lost/Screens/report_case.dart';
import 'package:locat_lost/Screens/signup.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/colors.dart';
import 'package:locat_lost/demo.dart';
import 'package:locat_lost/demo2.dart';

import 'Screens/SplashScreens/splash.dart';
import 'Screens/drawer_screens/faqs.dart';
import 'Screens/home_screen.dart';
import 'Screens/profile.dart';
import 'Screens/record.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
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

      // home: DisplayInfoScreen(),
      //
      home: Splash(),

      //  home: ProfileScreen(),
      //home: Demo(),
      //   home: EmergencyContactScreen(),
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
