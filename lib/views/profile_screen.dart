import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // 🔷 Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // 🔷 White Card Section
          Positioned(
            top: 200.h,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 200.h,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
            ),
          ),

          // 🔷 Profile Picture
          Positioned(
            top: 110.h,
            left: MediaQuery.of(context).size.width / 2 - 70.w,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(70.r),
              dashPattern: [8, 4],
              color: Colors.teal,
              strokeWidth: 2.w,
              child: Card(
                shape: CircleBorder(side: BorderSide(color: AppColors.primary)),
                elevation: 16,
                child: CircleAvatar(
                  radius: 70.r,
                  backgroundImage: AssetImage('assets/images/zulfi.png'),
                ),
              ),
            ),
          ),

          // 🔷 Profile Name
          Positioned(
            top: 275.h,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Zulfiqar Alam',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // 🔷 Tiles (My Profile, Security, Settings)
          Positioned(
            top: 330.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              children: [
                _buildProfileTile(
                  title: 'My Profile',
                  icon: Icons.person,
                  onTap: () {
                    // TODO: Navigate to profile page
                  },
                ),
                _buildProfileTile(
                  title: 'Security Details',
                  icon: Icons.security,
                  onTap: () {
                    // TODO: Navigate to security details
                  },
                ),
                _buildProfileTile(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    // TODO: Navigate to settings
                  },
                ),
              ],
            ),
          ),

          // back icon
          Positioned(
            top: 60.h,
            left: 13.w,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                size: 40.sp,
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom method to create profile tiles to avoid redundancy
  Widget _buildProfileTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      onTap: onTap,
    );
  }
  // another method
}
