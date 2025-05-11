import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locat_lost/utils/app_colors.dart';
import 'package:locat_lost/views/splash_screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),

        appBarTheme: AppBarTheme(
          foregroundColor: AppColors.secondary,
          backgroundColor: AppColors.primary,
          centerTitle: true,
        ),
      ),

      home: SplashScreen(),

      // home: DisplayInfoScreen(),

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

