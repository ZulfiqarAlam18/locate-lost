import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/colors.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          Center(
            child: Image.asset('assets/splash2.png', width: 355, height: 280),
          ),
          SizedBox(height: 30),
          RichText(
            text: TextSpan(
              text: 'Hope\n',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              children: [TextSpan(text: 'Action\n'), TextSpan(text: 'Reunion')],
            ),
          ),
        ],
      ),
    );
  }
}
