import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/colors.dart';

class Splash3 extends StatefulWidget {
  const Splash3({super.key});

  @override
  State<Splash3> createState() => _Splash3State();
}

class _Splash3State extends State<Splash3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          Center(
            child: Image.asset('assets/splash3.png', width: 355, height: 280),
          ),
          SizedBox(height: 30),
          RichText(
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
                  text: 'Between',
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
                TextSpan(text: 'Found'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
