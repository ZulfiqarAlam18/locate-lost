import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
import '../../colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(text: 'About Us', onPressed: () {
            Navigator.pop(context);
          }),
          SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileCard(
                    imagePath: 'assets/ali.png',
                    name: 'Ali Raza',
                    role: 'Full Stack Developer',
                    position: 'Team Leader',
                  ),
                  SizedBox(height: 20),
                  _buildProfileCard(
                    imagePath: 'assets/zulfiqar.png',
                    name: 'Zulfiqar Alam',
                    role: 'Flutter Developer',
                    position: 'Team Member',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({
    required String imagePath,
    required String name,
    required String role,
    required String position,
  }) {
    return DottedBorder(
      strokeWidth: 2,
      padding: EdgeInsets.zero,
      borderType: BorderType.RRect,
      dashPattern: [8, 4],
      color: AppColors.primary,
      radius: Radius.circular(12),
      child: Card(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePath,
                      width: 140,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            role,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            position,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'I’m a Software Engineering student and one of the developers behind LocateLost. My expertise lies in web development, where I specialize in creating scalable and efficient web applications.  .',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.myBlackColor,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'From frontend design to backend functionality,I ensure a seamless and user-friendly experience for LocateLost’s web platform, Passionate about innovation and problem-solving, I’m committed to making LocateLost a reliable tool for reconnecting people with their loved ones.',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.myBlackColor,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomElevatedButton(
                    label: 'Hire Me',
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.secondary,
                    width: 140,
                    height: 32,
                    onPressed: () {},
                  ),
                  CustomElevatedButton(
                    label: 'Resume',
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.secondary,
                    width: 140,
                    height: 32,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





















// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:locat_lost/Widgets/custom_appBar.dart';
// import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
//
// import '../../colors.dart';
//
// class AboutUsScreen extends StatefulWidget {
//   const AboutUsScreen({super.key});
//
//   @override
//   State<AboutUsScreen> createState() => _AboutUsScreenState();
// }
//
// class _AboutUsScreenState extends State<AboutUsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Column(
//
//         children: [
//
//           CustomAppBar(text: 'About Us', onPressed: (){}),
//           SizedBox(height: 5,),
//
//           Expanded(child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 DottedBorder(
//                   strokeWidth: 2,
//                   padding: EdgeInsets.zero,
//                   borderType: BorderType.RRect,
//                   dashPattern: [8, 4],
//                   color: AppColors.primary,
//                   radius: Radius.circular(12),
//                   child: Card(
//                     elevation: 16,
//                     child: SizedBox(
//                       width: 390,
//                       height: 320,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   'assets/ali.png',
//                                   width: 160,
//                                   height: 190,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 SizedBox(width: 10),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Ali Raza',
//                                         style: TextStyle(
//                                           fontSize: 25,
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(height: 4),
//                                       Text(
//                                         'Full Stack Developer',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Team Leader',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       SizedBox(height: 6),
//                                       Text(
//                                         'I’m a Software Engineering student\n'
//                                             'and one of the developers behind\n'
//                                             'LocateLost. My expertise lies in web\n'
//                                             'development, where I specialize in\n'
//                                             'creating scalable and efficient web\n'
//                                             'applications. From frontend design\n'
//                                             'to backend functionality, I ensure a',
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: AppColors.myBlackColor,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 6),
//                             Text(
//                               'seamless and user-friendly experience for LocateLost’s'
//                                   ' web platform.\n Passionate about innovation and problem-'
//                                   'solving, I’m committed to\n making LocateLost a reliable tool'
//                                   'for reconnectingpeople with their\n loved ones.',
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: AppColors.myBlackColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CustomElevatedButton(
//                                   label: 'Hire Me',
//                                   backgroundColor: AppColors.primary,
//                                   foregroundColor: AppColors.secondary,
//                                   width: 150,
//                                   height: 30,
//                                   onPressed: () {},
//                                 ),
//                                 CustomElevatedButton(
//                                   label: 'Resume',
//                                   backgroundColor: AppColors.primary,
//                                   foregroundColor: AppColors.secondary,
//                                   width: 150,
//                                   height: 30,
//                                   onPressed: () {},
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 DottedBorder(
//                   strokeWidth: 2,
//                   padding: EdgeInsets.zero,
//                   borderType: BorderType.RRect,
//                   dashPattern: [8, 4],
//                   color: AppColors.primary,
//                   radius: Radius.circular(12),
//                   child: Card(
//                     elevation: 16,
//                     child: SizedBox(
//                       width: 390,
//                       height: 320,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   'assets/zulfiqar.png',
//                                   width: 160,
//                                   height: 190,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 SizedBox(width: 10),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Zulfiqar Alam',
//                                         style: TextStyle(
//                                           fontSize: 25,
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(height: 4),
//                                       Text(
//                                         'Flutter Developer',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Team Member',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       SizedBox(height: 6),
//                                       Text(
//                                         'I’m a Software Engineering student\n'
//                                             'and one of the developers behind\n'
//                                             'LocateLost. My expertise lies in web\n'
//                                             'development, where I specialize in\n'
//                                             'creating scalable and efficient web\n'
//                                             'applications. From frontend design\n'
//                                             'to backend functionality, I ensure a',
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: AppColors.myBlackColor,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 6),
//                             Text(
//                               'seamless and user-friendly experience for LocateLost’s'
//                                   ' web platform.\n Passionate about innovation and problem-'
//                                   'solving, I’m committed to\n making LocateLost a reliable tool'
//                                   'for reconnectingpeople with their\n loved ones.',
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: AppColors.myBlackColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CustomElevatedButton(
//                                   label: 'Hire Me',
//                                   backgroundColor: AppColors.primary,
//                                   foregroundColor: AppColors.secondary,
//                                   width: 150,
//                                   height: 30,
//                                   onPressed: () {},
//                                 ),
//                                 CustomElevatedButton(
//                                   label: 'Resume',
//                                   backgroundColor: AppColors.primary,
//                                   foregroundColor: AppColors.secondary,
//                                   width: 150,
//                                   height: 30,
//                                   onPressed: () {},
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           )),
//
//
//
//
//
//
//
//         ],
//       ),
//
//     );
//   }
// }
