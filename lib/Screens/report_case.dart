import 'package:flutter/material.dart';
import 'package:locat_lost/Screens/child_info.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportCase extends StatefulWidget {
  const ReportCase({super.key});

  @override
  State<ReportCase> createState() => _ReportCaseState();
}

class _ReportCaseState extends State<ReportCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [

          Container(
            width: 430,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back)),
                Text('Report a Case'),
              ],
            ),
          ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/report.png',
                      width: 355,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    thickness: 2,
                    color: Colors.teal,
                    indent: 80,
                    endIndent: 80,
                  ),
                  SizedBox(height: 20),

                  RichText(
                    text: TextSpan(
                      text: '\" Let\'s ', // Default text without any style
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poltawski Nowy',
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ), // Default style
                      children: [
                        TextSpan(
                          text: 'reunite families ', // Text with red color
                          style: TextStyle(color: AppColors.primary),
                        ),
                        TextSpan(
                          text: 'with \ntheir ', // Text with blue color
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'loved ones \"', // Text with blue color
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  Divider(
                    thickness: 2,
                    color: Colors.teal,
                    indent: 80,
                    endIndent: 80,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChildDetailsScreens(),
                            ),
                          );
                          // Perform your action here
                          print("Card tapped - Report Lost Person");
                        },
                        child: Card(
                          color: Colors.teal,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SizedBox(
                            width: 170,
                            height: 205,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/unlink.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Report a',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    'Lost Person',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'If you are looking for someone who is lost, tap here to report it.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.arrow_circle_right_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChildDetailsScreens(),
                            ),
                          );

                          // Perform your action here
                          print("Card tapped - Report Lost Person");
                        },
                        child: Card(
                          color: Colors.teal,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SizedBox(
                            width: 170,
                            height: 205,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/link-03.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Report a',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    'Found Person',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'If you are looking for someone who is lost, tap here to report it.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.arrow_circle_right_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // SafeArea(
          //   child: Column(
          //     children: [
          //       // Custom AppBar Container
          //       Container(
          //         margin: const EdgeInsets.all(16),
          //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          //         decoration: BoxDecoration(
          //           color: Colors.teal,
          //           borderRadius: const BorderRadius.only(
          //             topLeft: Radius.circular(20),
          //             topRight: Radius.circular(20),
          //             bottomLeft: Radius.circular(30),
          //             bottomRight: Radius.circular(30),
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withOpacity(0.3),
          //               offset: const Offset(0, 4),
          //               blurRadius: 10,
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             // Drawer/Menu Icon
          //             Icon(Icons.dashboard_customize_rounded, color: Colors.white, size: 30),
          //
          //             // Title
          //             Text(
          //               'LocateLost',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 22,
          //                 letterSpacing: 1,
          //               ),
          //             ),
          //
          //             // Profile Image
          //             CircleAvatar(
          //               radius: 16,
          //               backgroundImage: AssetImage('assets/profile.jpg'), // replace with your image
          //             ),
          //           ],
          //         ),
          //       ),
          //
          //       // Rest of the UI
          //
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
