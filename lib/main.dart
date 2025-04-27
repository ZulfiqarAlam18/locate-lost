import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/colors.dart';
import 'package:locat_lost/demo.dart';
import 'package:locat_lost/demo2.dart';
import 'package:locat_lost/views/SplashScreens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        textTheme: GoogleFonts.poppinsTextTheme(),


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
   //  home: ReportCase(),
   //   home: RecordScreen(),
     // home: ProfileScreen(),
     // home: TermsAndConditions(),
    //  home: ContactUs(),
    //  home: ForgetPasswordGlass()
   //   home: HomeScreen(),
     // home: CapturePicturesScreen(),
      //home: DisplayInfoScreen(),
      //home: ChildDetailsScreen(),
     // home: ParentDetailsScreen(),
      //home: UploadImagesScreen(),
//      home: FounderDetailsScreen(),
   // home: ChildInfoScreen(),
       // home: ProfileScreen(),
      //home: Demo(),
      //   home: EmergencyContactScreen(),
    //  home: DeveloperProfileScreen(),
     // home: AboutUsScreen(),
    //  home: StatsScreen(),
     // home: Demo2(),

    );
  }
}

/*


,style: TextStyle(
fontSize: 30,
color: AppColors.primary,
fontWeight: FontWeight.w600,
),

*/

/*

  CustomElevatedButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

                      },
                        height: 60,
                        width: 241,
                        fontSize: 20,
                        borderRadius: 10,
                        label: 'Create Account',
                      ),


CustomElevatedButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

                      },
                        height: 45,
                        width: 130,
                        fontSize: 15,
                        borderRadius: 10,
                        label: 'Create Account',
                      ),





 */