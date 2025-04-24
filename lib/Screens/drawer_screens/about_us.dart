import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
import '../../colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'About Us',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 5),
              _buildProfileCard(
                imagePath: 'assets/images/ali.png',
                name: 'Ali Raza',
                role: 'Full Stack Developer',
                position: 'Team Leader',
              ),
              SizedBox(height: 20),
              _buildProfileCard(
                imagePath: 'assets/images/zulfiqar.png',
                name: 'Zulfiqar Alam',
                role: 'Flutter Developer',
                position: 'Team Member',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required String imagePath,
    required String name,
    required String role,
    required String position,
  }) {
    return DottedBorder(
      strokeWidth: 2,
      padding: EdgeInsets.zero,
      borderType: BorderType.RRect,
      dashPattern: [8, 4],
      color: AppColors.primary,
      radius: Radius.circular(12),
      child: Card(
        elevation: 16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePath,
                      width: 140,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            role,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            position,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'I’m a Software Engineering student and one of the developers behind LocateLost. My expertise lies in web development, where I specialize in creating scalable and efficient web applications.  .',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.myBlackColor,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'From frontend design to backend functionality,I ensure a seamless and user-friendly experience for LocateLost’s web platform, Passionate about innovation and problem-solving, I’m committed to making LocateLost a reliable tool for reconnecting people with their loved ones.',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.myBlackColor,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomElevatedButton(
                    label: 'Hire Me',
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.secondary,
                    width: 140,
                    height: 32,
                    onPressed: () {},
                  ),
                  CustomElevatedButton(
                    label: 'Resume',
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.secondary,
                    width: 140,
                    height: 32,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
