import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          Center(
            child: Image.asset('assets/images/splash1.png', width: 355, height: 280),
          ),
          SizedBox(height: 30),

          Row(
            children: [

              RichText(
                text: TextSpan(
                  text: 'Reuniting\n',
                  style: TextStyle(color: AppColors.primary, fontSize: 30),
                  children: [
                    TextSpan(
                      text: 'Loved Ones,\nOne ',
                      style: TextStyle(color: AppColors.myBlackColor),
                    ),
                    TextSpan(text: 'Search'),
                    TextSpan(
                      text: ' at\na time',
                      style: TextStyle(color: AppColors.myBlackColor),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/Map1_updated.svg',width: 20,height: 20,),

            ],
          ),


        ],
      ),
    );
  }
}
