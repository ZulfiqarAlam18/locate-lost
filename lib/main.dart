import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locat_lost/utils/app_colors.dart';
import 'package:locat_lost/views/splash_screens/splash_screen.dart';


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

          // initialRoute: AppRoutes.getstarted,
          // getPages: AppPages.pages,


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
      },
    );
  }


}





/*

final bottomNavController = Get.find<BottomNavController>();
                        bottomNavController.currentIndex.value = 2;
                        Get.to(MainScreen());


     Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Fitting Room',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 29.sp,
                  ),
                ),
                // CustomIconBar(),
                CustomIconBar(selectedTab: 'upload'),
              ],
            ),



  CustomElevatedButton(
                      onPressed: () {},
                      height: 45,
                      width: 333,
                      fontSize: 16,
                      borderRadius: 56,
                      label: 'Shop the look with \"\$$amount\"',
                      svgIconPath: 'assets/icons/svg/shopping bag 1.svg',
                      textFontWeight: FontWeight.w400,

                    ),

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


 Get.to(HomePage());

 CustomElevatedButton(
                    onPressed: () {
                      Get.to(HomePage());
                    },
                    label: 'Next',
                    buttonSize: ButtonSize.l,
                  ),


 Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(),
                    ),
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(8),

                    child: Column(

                    ),

                  ),




  Text('Settings',  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.1),     ),

 Image.asset('assets/images/Layer_1.png'),
  svgIconPath: 'assets/icons/svg/shopping bag 1.svg',

  Column(

          //  mainAxisSize: MainAxisSize.min,
         //   crossAxisAlignment: CrossAxisAlignment.start,
         //   mainAxisAlignment: MainAxisAlignment.start,

            children: [

              ],
          ),

          Row(

          //  mainAxisSize: MainAxisSize.min,
          //  crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.start,

            children: [

            ],
          ),



                Stack(
              children: [
                Container(child: Image.asset('assets/images/img1.png')),
                Positioned(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,

                  child: Text(
                    'Winter Sales',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
                  ),
                ),
              ],
            ),



 Text(
                            'Fitting Rome',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '4000\$',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                '5000\$',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Sweater 211966255001 Ecru Relaxed Fit',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),




                           Row(
                      children: [
                        CustomElevatedButton(
                          onPressed: () {},
                          buttonSize: ButtonSize.s,
                          backgroundColor: Colors.grey,
                          fontSize: 11,
                          label: 'Small',
                        ),
                        SizedBox(width: 6.5.w),
                        CustomElevatedButton(
                          onPressed: () {},
                          buttonSize: ButtonSize.s,
                          backgroundColor: Colors.grey,
                          fontSize: 11,
                          label: 'Medium',
                        ),
                        SizedBox(width: 6.5.w),
                        CustomElevatedButton(
                          onPressed: () {},
                          buttonSize: ButtonSize.s,
                         // backgroundColor: Colors.grey,
                          fontSize: 11,
                          label: 'Large',
                        ),
                        SizedBox(width: 6.5.w),
                        CustomElevatedButton(
                          onPressed: () {},
                          buttonSize: ButtonSize.s,
                          backgroundColor: Colors.grey,
                          fontSize: 11,
                          label: 'X Large',
                        ),
                      ],
                    ),



 */
