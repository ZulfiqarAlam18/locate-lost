import 'package:flutter/material.dart';
import 'package:locat_lost/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,

      body: Stack(

        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Map3.png'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 64,left: 32,right: 32,bottom: 16),
              child: Image.asset(
                'assets/images/splash3.png',
                width: 355,
                height: 275,
              ),
            ),
          ),
          Positioned(
            top: 330,
            left: 50,
            right: 0,
            child: RichText(
              text: TextSpan(
                text: 'Bridging',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: ' the',
                    style: TextStyle(
                      color: AppColors.myBlackColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(text: ' Distance\n'),
                  TextSpan(
                    text: '   Between',
                    style: TextStyle(
                      color: AppColors.myBlackColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(text: ' Lost'),
                  TextSpan(
                    text: ' and\n',
                    style: TextStyle(
                      color: AppColors.myBlackColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(text: '             Found'),
                ],
              ),
            ),
          ),


        ],
      ),


    );
  }
}
