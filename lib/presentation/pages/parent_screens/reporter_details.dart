import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/custom_elevated_button.dart';
import 'package:locate_lost/presentation/widgets/custom_text_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ReporterDetailsScreen extends StatefulWidget {
  const ReporterDetailsScreen({Key? key}) : super(key: key);

  @override
  _ReporterDetailsScreenState createState() => _ReporterDetailsScreenState();
}

class _ReporterDetailsScreenState extends State<ReporterDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'reporterName': TextEditingController(),
    'relationship': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'emergencyContact': TextEditingController(),
    'additionalDetails': TextEditingController(),
  };

  double progressPercent = 0.85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(), 
            _buildProgressCard(), 
            _buildForm()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 50.h),
        Center(
          child: Text(
            'Reporter Details',
            style: TextStyle(
              fontSize: 26.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Divider(
          color: AppColors.primary,
          indent: 80.w,
          endIndent: 80.w,
          thickness: 2.h,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      height: 140.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary, width: 1.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.h),
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
                    SizedBox(height: 8.h),
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
                  radius: 45.r,
                  lineWidth: 8.0.w,
                  percent: progressPercent,
                  animation: true,
                  animationDuration: 1200,
                  progressColor: AppColors.primary,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    "${(progressPercent * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildInstructionText(),
                SizedBox(height: 15.h),
                _buildSectionTitle('Reporter Details:'),
                SizedBox(height: 10.h),
                ..._buildFormFields(),
                SizedBox(height: 20.h),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'Please complete the form with your accurate details',
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.myBlackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(
        'Your Full Name',
        'Enter your complete name',
        'reporterName',
        true,
      ),
      _buildTextField(
        'Relationship with Missing Person',
        'e.g., Father, Mother, Brother, Friend',
        'relationship',
        true,
      ),
      _buildTextField(
        'Phone Number',
        'Enter your active phone number',
        'phoneNumber',
        true,
      ),
      _buildTextField(
        'Emergency Contact',
        'Alternative contact number',
        'emergencyContact',
        true,
      ),
      _buildTextField(
        'Additional Details',
        'Any other relevant information (optional)',
        'additionalDetails',
        false,
      ),
    ];
  }

  Widget _buildTextField(
    String label,
    String hint,
    String controllerKey,
    bool isRequired,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
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
          SizedBox(height: 6.h),
          CustomTextFormField(
            labelText: label,
            hintText: hint,
            controller: _controllers[controllerKey]!,
            validator: (value) {
              if (isRequired && (value?.isEmpty ?? true)) {
                return 'This field is required';
              }
              // Add phone number validation
              if (controllerKey == 'phoneNumber' && value != null && value.isNotEmpty) {
                if (value.length < 10 || value.length > 15) {
                  return 'Please enter a valid phone number';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
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
              if (_formKey.currentState?.validate() ?? false) {
                Get.toNamed(AppRoutes.parentCaseSummary);
              } else {
                Get.snackbar(
                  'Form Incomplete',
                  'Please fill all required fields correctly',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            height: 45.h,
            width: 130.w,
            fontSize: 15.sp,
            borderRadius: 10.r,
            label: 'Next',
          ),
        ],
      ),
    );
  }
}
