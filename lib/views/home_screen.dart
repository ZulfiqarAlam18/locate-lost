import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Zohaib Khoso'; // Dynamically update this as needed

  // Function to handle navigation from drawer
  void navigateToScreen(String routeName) {
    Navigator.pop(context); // Close the drawer
    Get.toNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'LocateLost',
        onPressed: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Done Done Done...........')),
          // );
        },
        icon: Icons.menu,
      ),

      // appBar: AppBar(title: Text('LocateLost')),
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome,',
              style: TextStyle(fontSize: 18.sp, color: AppColors.primary),
            ),
            Text(
              username,
              style: TextStyle(
                fontSize: 25.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'You have not reported any case yet',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),

            CustomElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.reportCase);
              },
              height: 45.h,
              width: 130.w,
              fontSize: 15.sp,
              borderRadius: 10.r,
              label: 'New Case',
            ),
          ],
        ),
      ),

      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Text(
                'Welcome, $username!',
                style: TextStyle(fontSize: 24.sp, color: AppColors.secondary),
              ),
            ),
            // Simplifying the drawer items with the reuse of navigateToScreen method
            _buildDrawerItem(
              icon: Icons.home,
              title: 'Home',
              onTap: () => navigateToScreen(AppRoutes.home),
            ),
            _buildDrawerItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () => navigateToScreen(AppRoutes.profile),
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart,
              title: 'Stats',
              onTap: () => navigateToScreen(AppRoutes.stats),
            ),
            _buildDrawerItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Terms  & Conditions',
              onTap: () => navigateToScreen(AppRoutes.termsAndConditions),
            ),
            _buildDrawerItem(
              icon: Icons.help_outlined,
              title: 'FAQs',
              onTap: () => navigateToScreen(AppRoutes.faqs),
            ),
            _buildDrawerItem(
              icon: Icons.support,
              title: 'Emergency',
              onTap: () => navigateToScreen(AppRoutes.emergency),
            ),
            _buildDrawerItem(
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () => navigateToScreen(AppRoutes.aboutUs),
            ),
            _buildDrawerItem(
              icon: Icons.call,
              title: 'Contact Us',
              onTap: () => navigateToScreen(AppRoutes.contactUs),
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () {
                Navigator.pop(context); // Close drawer first
                Get.toNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method to build drawer items
  ListTile _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      textColor: AppColors.primary,
      iconColor: AppColors.primary,
      onTap: onTap,
    );
  }
}
