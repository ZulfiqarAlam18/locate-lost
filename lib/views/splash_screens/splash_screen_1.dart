import 'package:flutter/material.dart';
import 'package:locat_lost/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,

      body: Stack(

        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Map1.png'),
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
                  'assets/images/splash1.png',
                   width: 355,
                  height: 275,
                ),
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 100,
            child: Padding(
              padding: EdgeInsets.only(top: 64,left: 32,right: 32,bottom:16),
              child:   RichText(
                  text: TextSpan(
                    text: 'Reuniting\n',
                    style: TextStyle(color: AppColors.primary, fontSize: 30,fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: 'Loved Ones,\nOne ',
                        style: TextStyle(color: AppColors.myBlackColor,fontWeight: FontWeight.w400),
                      ),
                      TextSpan(text: 'Search'),
                      TextSpan(
                        text: ' at\na time',
                        style: TextStyle(color: AppColors.myBlackColor,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),

            ),
          ),


        ],
      ),


    );
  }
}
