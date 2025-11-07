import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Frequently Asked Questions',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'What this app is about?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'Smarter Solution for reuniting missing children with their parents, with advanced AI features. LocateLost helps by utilizing modern technologies for efficient and fast reunification.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'How does facial recognition work?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'Our facial recognition technology uses advanced algorithms to analyze facial features and match them against our database of reported missing persons. The system is designed to be accurate even with changes in appearance over time.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'Is my data secure?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'Yes, we take data security very seriously. All personal information and images are encrypted and stored securely. We only use your data for the purpose of finding missing persons and never share it with third parties without your consent.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'How can I report a missing person?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'To report a missing person, go to the home screen and select "Report a Missing Person." You\'ll need to provide details about the missing person, including their name, age, last seen location, and clear photos. We recommend also reporting to local authorities in addition to using our app.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'How long does it take to find a match?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'Our AI system processes images instantly and can find potential matches within minutes. However, verification and confirmation may take longer as we ensure accuracy. We notify you immediately when potential matches are found.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'What should I do if I find someone who looks like a missing person?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'If you spot someone who matches a missing person, use our "Report a Sighting" feature to upload their photo and location. Do not approach or confront the person directly. Instead, contact local authorities immediately and share the information through our app.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'Can I update information about a missing person after reporting?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'Yes, you can update information about a reported missing person. Go to "My Reports" in the app menu, select the case, and tap "Edit Information." You can add new photos, update last seen locations, or modify any details that might help in the search.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'Does the app work offline?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'Some basic features like viewing previously loaded information work offline, but utils features like facial recognition, uploading reports, and receiving matches require an internet connection. We recommend using the app with a stable internet connection for best results.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(width: 1.w, color: AppColors.primary),
                    ),
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      title: Text(
                        'What types of photos work best for recognition?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      iconColor: AppColors.secondary,
                      textColor: AppColors.secondary,
                      collapsedTextColor: AppColors.secondary,
                      collapsedIconColor: AppColors.secondary,

                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          color: Colors.white,
                          child: Text(
                            'For best results, upload clear, high-resolution photos showing the person\'s face directly. Avoid blurry images, photos with shadows, or pictures where the face is partially covered. Multiple photos from different angles help improve recognition accuracy.',
                          ),
                        ),
                      ],
                      initiallyExpanded: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
