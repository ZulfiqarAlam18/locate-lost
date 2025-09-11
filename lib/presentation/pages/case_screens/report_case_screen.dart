// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:locat_lost/widgets/custom_app_bar.dart';
// import 'package:locat_lost/utils/app_colors.dart';
// import '../navigation/app_routes.dart';

// class ReportCaseScreen extends StatelessWidget {
//   const ReportCaseScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         text: 'Report A Case',
//         onPressed: () => Navigator.pop(context),
//       ),
//       backgroundColor: AppColors.secondary,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           children: [
//             SizedBox(height: 30.h),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20.r),
//               child: Image.asset(
//                 'assets/images/report.png',
//                 width: double.infinity,
//                 height: 220.h,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 20.h),
//             Divider(
//               thickness: 2.h,
//               color: AppColors.primary,
//               indent: 80.w,
//               endIndent: 80.w,
//             ),
//             SizedBox(height: 20.h),
//             RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                 text: '\" Let\'s ',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Poltawski Nowy',
//                   fontSize: 25.sp,
//                   fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: 'reunite families ',
//                     style: TextStyle(color: AppColors.primary),
//                   ),
//                   const TextSpan(
//                     text: 'with \ntheir ',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   TextSpan(
//                     text: 'loved ones \"',
//                     style: TextStyle(color: AppColors.primary),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//             Divider(
//               thickness: 2.h,
//               color: AppColors.primary,
//               indent: 80.w,
//               endIndent: 80.w,
//             ),
//             SizedBox(height: 30.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildCaseCard(
//                   context,
//                   title1: 'Report a',
//                   title2: 'Missing Person',
//                   image: 'assets/images/unlink.png',
//                   onTap: () => Get.toNamed(AppRoutes.missingPersonDetails),
//                 ),
//                 _buildCaseCard(
//                   context,
//                   title1: 'Report a',
//                   title2: 'Found Person',
//                   image: 'assets/images/link-03.png',
//                   onTap: () => Get.toNamed(AppRoutes.foundPersonDetails),
//                 ),
//               ],
//             ),
//             //  SizedBox(height: 40.h),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCaseCard(
//     BuildContext context, {
//     required String title1,
//     required String title2,
//     required String image,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Card(
//         color: AppColors.primary,
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: SizedBox(
//           width: 160.w,
//           height: 190.h, // Much reduced height since no description
//           child: Padding(
//             padding: EdgeInsets.all(12.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(image, width: 40.w, height: 40.h),
//                     SizedBox(height: 12.h),
//                     Text(
//                       title1,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       title2,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Align(
//                   alignment: Alignment.bottomRight,
//                   child: Icon(
//                     Icons.arrow_circle_right_rounded,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
