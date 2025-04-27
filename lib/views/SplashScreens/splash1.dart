import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

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

// import 'package:flutter/material.dart';
// import 'package:locat_lost/Widgets/custom_button.dart';
// import 'package:locat_lost/colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class Splash1 extends StatefulWidget {
//   const Splash1({super.key});
//
//   @override
//   State<Splash1> createState() => _Splash1State();
// }
//
// class _Splash1State extends State<Splash1> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 32,vertical: 0),
//               child: Center(
//                 child: Image.asset(
//                   'assets/images/splash1.png',
//                   width: 355,
//                   height: 275,
//                 ),
//               ),
//             ),
//          //   SizedBox(height: 30),
//
//             Image.asset(
//               'assets/images/Map1.png',
//               width: 300,
//               height: 300,
//
//             ),
//             Row(
//               children: [
//                 // RichText(
//                 //   text: TextSpan(
//                 //     text: 'Reuniting\n',
//                 //     style: TextStyle(color: AppColors.primary, fontSize: 30),
//                 //     children: [
//                 //       TextSpan(
//                 //         text: 'Loved Ones,\nOne ',
//                 //         style: TextStyle(color: AppColors.myBlackColor),
//                 //       ),
//                 //       TextSpan(text: 'Search'),
//                 //       TextSpan(
//                 //         text: ' at\na time',
//                 //         style: TextStyle(color: AppColors.myBlackColor),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//
//                 Image.asset(
//                   'assets/images/Map1.png',
//                   width: 300,
//                   height: 300,
//
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
