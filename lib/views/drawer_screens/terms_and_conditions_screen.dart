import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/widgets/custom_app_bar.dart';
import 'package:locat_lost/utils/app_colors.dart';

import '../../widgets/custom_elevated_button.dart';
import '../auth_screens/login_screen.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Terms & Conditions',
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      backgroundColor: AppColors.secondary,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SectionTitle('Why LocateLost Exists'),
                    SectionBody(
                      'Our mission is to reunite missing children with their families using advanced facial recognition. We are not an official rescue or law enforcement body — just a bridge.',
                    ),

                    SectionTitle('Your Responsibility'),
                    SectionBody(
                      'Provide accurate info. Misleading or harmful use will result in account ban and possible legal action.',
                    ),

                    SectionTitle('Our Role'),
                    SectionBody(
                      'We are tech facilitators — not involved in any personal communication or verification. The developer holds zero legal responsibility for misuse.',
                    ),

                    SectionTitle('Use of AI'),
                    SectionBody(
                      'Face matching is automated and may not always be accurate. Treat all matches as leads, not confirmations.',
                    ),

                    SectionTitle('Privacy Matters'),
                    SectionBody(
                      'Your data is processed only for matching purposes and never shared or sold. Photos and details are secured.',
                    ),

                    SectionTitle('What We Don\'t Guarantee'),
                    SectionBody(
                      'We cannot promise a successful match or reunion. Please always report missing/found cases to local authorities.',
                    ),

                    SectionTitle('Modifications & Updates'),
                    SectionBody(
                      'These terms may evolve. Continued use means you accept any updated version.',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: agreed,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      agreed = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'I have read and agree to the Terms & Conditions.',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              height: 60.h,
              width: 241.w,
              fontSize: 20.sp,
              borderRadius: 10.r,
              label: 'Create Account',
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h, bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SectionBody extends StatelessWidget {
  final String text;
  const SectionBody(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 15.sp, color: Colors.black87, height: 1.6),
    );
  }
}
