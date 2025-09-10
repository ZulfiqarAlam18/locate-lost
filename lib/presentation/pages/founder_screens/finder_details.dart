import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/custom_elevated_button.dart';
import 'package:locate_lost/presentation/widgets/custom_text_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class FinderDetailsScreen extends StatefulWidget {
  const FinderDetailsScreen({super.key});

  @override
  State<FinderDetailsScreen> createState() => _FinderDetailsScreenState();
}

class _FinderDetailsScreenState extends State<FinderDetailsScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController cName = TextEditingController();
  final TextEditingController cNum = TextEditingController();
  final TextEditingController cEmergencyNum = TextEditingController();
  final TextEditingController cCNIC = TextEditingController();

  double progressPercent = 1.0; // Final step in the process

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: EdgeInsets.all(16.0.w), // Padding adjusted for consistency
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Center(
              child: Text(
                'Found Person',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(
              color: AppColors.primary,
              indent: 100.w,
              endIndent: 100.w,
              thickness: 2.h,
            ),
            SizedBox(height: 20.h),

            Container(
              width: 390.w,
              height: 140.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.primary, width: 1.5.w),
              ),
              child: Card(
                elevation: 6,
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Application Progress',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Enter your details\nto continue',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.myRedColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CircularPercentIndicator(
                          radius: 40.r,
                          lineWidth: 8.0.w,
                          percent: progressPercent,
                          animation: true,
                          animationDuration: 1000,
                          progressColor: AppColors.primary,
                          backgroundColor: Colors.teal.shade100,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            "${(progressPercent * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Divider(
              color: AppColors.primary,
              indent: 100.w,
              endIndent: 100.w,
              thickness: 2.h,
            ),
            SizedBox(height: 10.h),
            Text(
              'Please complete the form with your accurate details',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.myBlackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Finder Details:',
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      _buildTextField(
                        'Name',
                        'Enter your full name please',
                        cName,
                        true,
                      ),
                      _buildTextField(
                        'Mobile Number',
                        'Enter your active mobile number',
                        cNum,
                        true,
                      ),
                      _buildTextField(
                        'Emergency Contact',
                        'Enter emergency contact in case first one is off.',
                        cEmergencyNum,
                        true,
                      ),
                      _buildTextField(
                        'CNIC Number',
                        'If you want to provide any other details related to you or the missing person.',
                        cCNIC,
                        true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            height: 45.h,
                            width: 130.w,
                            fontSize: 15.sp,
                            borderRadius: 10.r,
                            label: 'Back',
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.primary,
                            showBorder: true,
                          ),
                          CustomElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.finderCaseSummary);
                            },
                            height: 45.h,
                            width: 130.w,
                            fontSize: 15.sp,
                            borderRadius: 10.r,
                            label: 'Next',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    bool isRequired,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
              children: [
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            labelText: label,
            hintText: hint,
            controller: controller,
            validator: (value) {
              if (isRequired && (value?.isEmpty ?? true)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
