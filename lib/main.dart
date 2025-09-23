import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'navigation/app_pages.dart';
import 'navigation/app_routes.dart';
import 'data/services/location_permission_service.dart';
import 'data/bindings/app_bindings.dart';

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

          initialBinding: AppBindings(), // Initialize backend integration
         //  initialRoute: AppRoutes.splash,
          initialRoute: AppRoutes.mainNavigation,
          getPages: AppPages.pages,

  
        );
      },
    );
  }
}
