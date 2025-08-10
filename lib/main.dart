import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/location_permission_service.dart';

void main() {
  // Reset location permission check on app start
  LocationPermissionService.resetSessionCheck();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //  designSize: Size(375, 812), more generic 
      designSize: Size(430, 932),

      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'LocateLost',

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
        );
      },
    );
  }
}

