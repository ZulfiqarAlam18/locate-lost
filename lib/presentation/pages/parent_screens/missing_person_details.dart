import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/custom_elevated_button.dart';
import 'package:locate_lost/presentation/widgets/custom_text_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MissingPersonDetailsScreen extends StatefulWidget {
  const MissingPersonDetailsScreen({Key? key}) : super(key: key);

  @override
  _MissingPersonDetailsScreenState createState() =>
      _MissingPersonDetailsScreenState();
}

class _MissingPersonDetailsScreenState
    extends State<MissingPersonDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'fatherName': TextEditingController(),
    'caste': TextEditingController(),
    'gender': TextEditingController(),
    'height': TextEditingController(),
    'hairColor': TextEditingController(),
    'skinColor': TextEditingController(),
    'disability': TextEditingController(),
    'lastSeenPlace': TextEditingController(),
    'lastSeenTime': TextEditingController(),
    'phoneNumber': TextEditingController(),
  };

  double progressPercent = 0.25;

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
            _buildForm(),
           // _buildNavigationButtons(),
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
            'Missing Person Details',
            style: TextStyle(
              fontSize: 26.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Divider(
          color: AppColors.primary,
          indent: 80.w,
          endIndent: 80.w,
          thickness: 2.h,
        ),
        SizedBox(height: 8.h),
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
            children: [_buildProgressText(), _buildProgressIndicator()],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressText() {
    return Expanded(
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
            'Enter missing person\'s details\nto continue',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.myRedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Expanded(
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
                // _buildSectionTitle(
                //   'Please complete the form with the accurate details of the missing person',
                // ),
                // SizedBox(height: 15.h),
                // _buildSectionTitle('Missing Person Details:', size: 18),
                // SizedBox(height: 10.h),

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

  List<Widget> _buildFormFields() {
    return [
      _buildTextField('Name', 'Enter Missing Person\'s name', 'name', true),
      _buildTextField(
        'Father\'s Name',
        'Enter Missing Person\'s father\'s name',
        'fatherName',
        true,
      ),
      _buildTextField(
        'Surname',
        'Enter Missing Person\'s surname',
        'caste',
        true,
      ),
      _buildTextField(
        'Gender',
        'Enter Missing Person\'s gender',
        'gender',
        true,
      ),
      _buildTextField(
        'Height',
        'Enter Missing Person\'s height (ft)',
        'height',
        true,
      ),
      _buildTextField(
        'Skin Color',
        'Enter Missing Person\'s skin color',
        'skinColor',
        true,
      ),
      _buildTextField(
        'Hair Color',
        'Enter Missing Person\'s hair color',
        'hairColor',
        true,
      ),
      _buildTextField(
        'Disability (if any)',
        'Enter Missing Person\'s disability',
        'disability',
        false,
      ),
      _buildTextField(
        'Last Seen Place',
        'Where was the person seen last?',
        'lastSeenPlace',
        true,
      ),
      _buildTextField(
        'Last Seen Time',
        'Enter Missing Person\'s last seen time',
        'lastSeenTime',
        true,
      ),
      _buildTextField(
        'Phone Number (optional)',
        'Enter Missing Person\'s phone number',
        'phoneNumber',
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
           // labelText: label,
            hintText: hint,
            controller: _controllers[controllerKey]!,
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

  Widget _buildSectionTitle(String title, {double size = 16}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: size.sp,
          color: size > 16 ? AppColors.primary : AppColors.myBlackColor,
          fontWeight: size > 16 ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
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
                Get.toNamed(AppRoutes.uploadImages);
              } else {
                Get.snackbar(
                  'Form Incomplete',
                  'Please fill all required fields',
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
