import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locat_lost/widgets/custom_text_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../routes/app_routes.dart';

class FoundPersonDetailsScreen extends StatefulWidget {
  const FoundPersonDetailsScreen({super.key});

  @override
  State<FoundPersonDetailsScreen> createState() =>
      _FoundPersonDetailsScreenState();
}

class _FoundPersonDetailsScreenState extends State<FoundPersonDetailsScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController cName = TextEditingController();
  final TextEditingController cGender = TextEditingController();
  final TextEditingController cFName = TextEditingController();
  final TextEditingController cLocation = TextEditingController();
  final TextEditingController cTime = TextEditingController();
  final TextEditingController cAge = TextEditingController();
  final TextEditingController cHairColor = TextEditingController();
  final TextEditingController cCloths = TextEditingController();
  final TextEditingController cExtraDetails = TextEditingController();

  double progressPercent = .25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
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
              indent: 100,
              endIndent: 100,
              thickness: 2,
            ),
            SizedBox(height: 20),
            Container(
              width: 390,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Card(
                elevation: 6,
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
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
                            SizedBox(height: 6),
                            Text(
                              'Enter found person\'s details\nto continue',
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
                          radius: 40,
                          lineWidth: 8.0,
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
            SizedBox(height: 20),
            Divider(
              color: AppColors.primary,
              indent: 100,
              endIndent: 100,
              thickness: 2,
            ),
            SizedBox(height: 10),
            Text(
              'Please complete the form with the accurate details of the found person',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.myBlackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Found Person Details:',
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
                        'Enter person\'s name',
                        cName,
                        true,
                      ),
                      _buildTextField(
                        'Father\'s Name',
                        'Enter person\'s father\'s name',
                        cFName,
                        true,
                      ),
                      _buildTextField(
                        'Gender',
                        'Enter person\'s gender',
                        cGender,
                        true,
                      ),
                      _buildTextField(
                        'Hair Color',
                        'Enter person\'s hair color',
                        cHairColor,
                        true,
                      ),
                      _buildTextField(
                        'Place',
                        'Enter place where person was found',
                        cLocation,
                        true,
                      ),
                      _buildTextField(
                        'Time',
                        'Enter the time when person was found',
                        cTime,
                        true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            height: 45,
                            width: 130,
                            fontSize: 15.sp,
                            borderRadius: 10,
                            label: 'Back',
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.primary,
                            showBorder: true,
                          ),
                          CustomElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.finderDetails);
                            },
                            height: 45,
                            width: 130,
                            fontSize: 15.sp,
                            borderRadius: 10,
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
