import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932), // i phone 15 pro max
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Inforato',

          // theme: ThemeData(
          //   scaffoldBackgroundColor: AppColors.background,
          //   primaryColor: AppColors.primary,
          //   useMaterial3: true,
          //   appBarTheme: const AppBarTheme(
          //     backgroundColor: AppColors.background,
          //     foregroundColor: AppColors.secondary,
          //     elevation: 0,
          //   ),
          //   textTheme: const TextTheme(
          //     bodyLarge: TextStyle(color: AppColors.textPrimary),
          //     bodyMedium: TextStyle(color: AppColors.textSecondary),
          //   ),
          //   iconTheme: const IconThemeData(color: AppColors.secondary),
          //   colorScheme: ColorScheme.fromSwatch().copyWith(
          //     primary: AppColors.primary,
          //     secondary: AppColors.secondary,
          //   ),
          // ),
          //
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,

          // Old navigation - now using GetX routes
          // home: SplashScreen(),
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
      },
    );
  }
}
