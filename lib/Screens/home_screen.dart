import 'package:flutter/material.dart';
import 'package:locat_lost/Screens/report_case.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LocateLost'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
      ),
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome,',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primary,
                //fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Zohaib Khoso',
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
            CustomButton(text: 'New Case', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportCase()));

            }, size: 'large', bgColor: AppColors.primary, textColor: AppColors.secondary),

          ],
        ),
      ),

      drawer: Drawer(
        backgroundColor: Colors.white,

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(decoration: BoxDecoration(color:AppColors.primary),child: Text('Welcome,Zohaib!',style: TextStyle(
              fontSize: 24,
              color: AppColors.secondary,
            ),)),
            ListTile(

              leading: Icon(Icons.home),
              title: Text('Home'),
              textColor: AppColors.primary,
              iconColor: AppColors.primary,
            ),
            ListTile(

              leading: Icon(Icons.report_gmailerrorred),
              title: Text('Report a case'),
              textColor: AppColors.primary,
              iconColor: AppColors.primary,
            ),
            ListTile(

              leading: Icon(Icons.help_outlined),
              title: Text('FAQs'),
              textColor: AppColors.primary,
              iconColor: AppColors.primary,
            ),
            ListTile(

              leading: Icon(Icons.warning_amber_outlined),
              title: Text('Emergency'),
              textColor: AppColors.primary,
              iconColor: AppColors.primary,
            ),
            ListTile(

              leading: Icon(Icons.info_outline),
              title: Text('About Us'),
              textColor: AppColors.primary,
              iconColor: AppColors.primary,
            ),
            ListTile(

              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              textColor: AppColors.primary,
              iconColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
