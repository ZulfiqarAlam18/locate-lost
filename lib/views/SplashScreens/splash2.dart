import 'package:flutter/material.dart';
import 'package:locat_lost/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,

      body: Stack(

        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Map2.png'),
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
                'assets/images/splash2.png',
                width: 355,
                height: 275,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 200,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 54,left: 40,right: 16,bottom:16),
              child:   Text('Hope\nAction\nReunion',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),)

            ),
          ),


        ],
      ),


    );
  }
}








