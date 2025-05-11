import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import 'auth_screens/login_screen.dart';
import 'drawer_screens/about_us_screen.dart';
import 'drawer_screens/contact_us_screen.dart';
import 'drawer_screens/emergency_screen.dart';
import 'drawer_screens/faqs_screen.dart';
import 'drawer_screens/stats_screen.dart';
import 'drawer_screens/terms_and_conditions_screen.dart';
import 'profile_screen.dart';
import 'report_case_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Zohaib Khoso'; // Dynamically update this as needed

  // Function to handle navigation from drawer
  void navigateToScreen(Widget screen) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
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
              style: TextStyle(fontSize: 18, color: AppColors.primary),
            ),
            Text(
              username,
              style: TextStyle(
                fontSize: 25,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'You have not reported any case yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),

            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportCaseScreen()),
                );
              },
              height: 45,
              width: 130,
              fontSize: 15,
              borderRadius: 10,
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
                style: TextStyle(fontSize: 24, color: AppColors.secondary),
              ),
            ),
            // Simplifying the drawer items with the reuse of navigateToScreen method
            _buildDrawerItem(
              icon: Icons.home,
              title: 'Home',
              onTap: () => navigateToScreen(HomeScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () => navigateToScreen(ProfileScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart,
              title: 'Stats',
              onTap: () => navigateToScreen(StatsScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Terms  & Conditions',
              onTap: () => navigateToScreen(TermsAndConditionsScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.help_outlined,
              title: 'FAQs',
              onTap: () => navigateToScreen(FAQsScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.support,
              title: 'Emergency',
              onTap: () => navigateToScreen(EmergencyScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () => navigateToScreen(AboutUsScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.call,
              title: 'Contact Us',
              onTap: () => navigateToScreen(ContactUsScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
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


