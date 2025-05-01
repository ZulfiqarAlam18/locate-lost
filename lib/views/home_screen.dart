import 'package:flutter/material.dart';
import 'package:locat_lost/views/auth_screens/login.dart';
import 'package:locat_lost/views/drawer_screens/about_us.dart';
import 'package:locat_lost/views/drawer_screens/contact_us.dart';
import 'package:locat_lost/views/drawer_screens/emergency.dart';
import 'package:locat_lost/views/drawer_screens/faqs.dart';
import 'package:locat_lost/views/drawer_screens/stats_screen.dart';
import 'package:locat_lost/views/drawer_screens/terms_and_conditions.dart';
import 'package:locat_lost/views/profile.dart';
import 'package:locat_lost/views/report_case.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/colors.dart';

import '../Widgets/custom_elevated_button.dart';

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
      // appBar: CustomAppBar(
      //   text: 'LocateLost',
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('Done Done Done...........')),
      //     );
      //   },
      //   icon: Icons.menu,
      // ),
      appBar: AppBar(title: Text('LocateLost')),
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
                  MaterialPageRoute(builder: (context) => ReportCase()),
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
              onTap: () => navigateToScreen(TermsAndConditions()),
            ),
            _buildDrawerItem(
              icon: Icons.help_outlined,
              title: 'FAQs',
              onTap: () => navigateToScreen(FAQsScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.support,
              title: 'Emergency',
              onTap: () => navigateToScreen(EmergencyContactScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () => navigateToScreen(AboutUsScreen()),
            ),
            _buildDrawerItem(
              icon: Icons.call,
              title: 'Contact Us',
              onTap: () => navigateToScreen(ContactUs()),
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
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


