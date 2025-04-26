import 'package:flutter/material.dart';
import 'package:locat_lost/Screens/SplashScreens/splash1.dart';
import 'package:locat_lost/Screens/SplashScreens/splash2.dart';
import 'package:locat_lost/Screens/SplashScreens/splash3.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/Widgets/custom_elevated_button.dart';
import 'package:locat_lost/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth_screens/signup.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'LocateLost',
            style: TextStyle(
              fontSize: 40,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            color: AppColors.primary,
            indent: 80,
            endIndent: 80,
            thickness: 2,
          ),


          Expanded(
            child: PageView(
              controller: _controller,
              children: [Splash1(), Splash2(), Splash3()],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: WormEffect(
                dotColor: AppColors.myBlackColor,
                dotHeight: 15,
                dotWidth: 15,
                activeDotColor: AppColors.primary,
              ),
            ),
          ),



          CustomElevatedButton(onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));

          },
              height: 60,
              width: 241,
              fontSize: 25,
              borderRadius: 10,
              label: 'Get Started',
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
