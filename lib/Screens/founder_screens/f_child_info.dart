import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/Widgets/custom_textField.dart';
import 'package:locat_lost/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'founder_info.dart';

class ChildInfoScreen extends StatefulWidget {
  const ChildInfoScreen({super.key});

  @override
  State<ChildInfoScreen> createState() => _ChildDetailsScreenState();
}

class _ChildDetailsScreenState extends State<ChildInfoScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController cName = TextEditingController();
  final TextEditingController cGender = TextEditingController();
  final TextEditingController cFName = TextEditingController();
  final TextEditingController cLocation = TextEditingController();
  final TextEditingController cTime = TextEditingController();
  final TextEditingController cAge = TextEditingController();
  final TextEditingController cHairColor = TextEditingController();
  final TextEditingController cCloths = TextEditingController();
  final TextEditingController cExtraDetails = TextEditingController();

  double progressPercent = .25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                'Lost Person',
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(
              color: AppColors.primary,
              indent: 100,
              endIndent: 100,
              thickness: 2,
            ),
            SizedBox(height: 20),
            Container(
              width: 390,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Card(
                elevation: 6,
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Application Progress',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Enter missing person\'s real\nname to continue',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.myRedColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CircularPercentIndicator(
                          radius: 40,
                          lineWidth: 8.0,
                          percent: progressPercent,
                          animation: true,
                          animationDuration: 1000,
                          progressColor: AppColors.primary,
                          backgroundColor: Colors.teal.shade100,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            "${(progressPercent * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: AppColors.primary,
              indent: 100,
              endIndent: 100,
              thickness: 2,
            ),
            SizedBox(height: 10),
            Text(
              'Please complete the form with the accurate details of the missing person',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.myBlackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Missing Child/Person Details:',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      _buildTextField(
                        'Name',
                        'Enter child name',
                        cName,
                        true,
                      ),
                      _buildTextField(
                        'Father\'s Name',
                        'Enter  Person\'s father\'s name',
                        cFName,
                        true,
                      ),
                      _buildTextField(
                        'Gender',
                        'Enter Missing Person\'s gender',
                        cGender,
                        true,
                      ),
                      _buildTextField(
                        'Hair Color',
                        'Enter Missing Person\'s hair color',
                        cHairColor,
                        true,
                      ),
                      _buildTextField(
                        'Place',
                        'Enter place where child was found',
                        cLocation,
                        true,
                      ),
                      _buildTextField(
                        'Time',
                        'Enter the time when child was found',
                        cTime,
                        true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.primary,
                            size: 'small',
                            label: 'Back',
                            border: true,
                          ),
                          CustomButton(
                            onPressed: () {
                              if (_key.currentState?.validate() ?? false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FounderDetailsScreen(),
                                  ),
                                );
                              }
                            },
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.secondary,
                            size: 'small',
                            label: 'Next',
                            border: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      String hint,
      TextEditingController controller,
      bool isRequired,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
              children: [
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            labelText: label,
            hintText: hint,
            controller: controller,
            validator: (value) {
              if (isRequired && (value?.isEmpty ?? true)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

// 🔻 CustomTextFormField Widget Implementation
class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 13),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:locat_lost/Widgets/custom_button.dart';
// import 'package:locat_lost/Widgets/custom_textField.dart';
// import 'package:locat_lost/colors.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// import 'founder_info.dart';
//
//
// class ChildInfoScreen extends StatefulWidget {
//   const ChildInfoScreen({super.key});
//
//   @override
//   State<ChildInfoScreen> createState() => _ChildDetailsScreenState();
// }
//
// class _ChildDetailsScreenState extends State<ChildInfoScreen> {
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   final TextEditingController cName = TextEditingController();
//   final TextEditingController cGender = TextEditingController();
//   final TextEditingController cFName = TextEditingController();
//   final TextEditingController cLocation = TextEditingController();
//   final TextEditingController cTime = TextEditingController();
//   final TextEditingController cAge = TextEditingController();
//   final TextEditingController cHairColor = TextEditingController();
//   final TextEditingController cCloths = TextEditingController();
//   final TextEditingController cExtraDetails = TextEditingController();
//
//   double progressPercent = .25;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//
//           children: [
//             SizedBox(height: 50),
//             Center(
//               child: Text(
//                 'Lost Person',
//                 style: TextStyle(
//                   fontSize: 25,
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//
//             Divider(
//               color: AppColors.primary,
//               indent: 100,
//               endIndent: 100,
//               thickness: 2,
//             ),
//             SizedBox(height: 20),
//
//             Container(
//               width: 390,
//               height: 140,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: AppColors.primary, width: 1.5),
//               ),
//               child: Card(
//                 elevation: 6,
//                 color: AppColors.secondary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 12,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Application Progress',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(height: 6),
//                             Text(
//                               'Enter missing person\'s real\nname to continue',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: AppColors.myRedColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: CircularPercentIndicator(
//                           radius: 40,
//                           lineWidth: 8.0,
//                           percent: progressPercent,
//                           animation: true,
//                           animationDuration: 1000,
//                           progressColor: AppColors.primary,
//                           backgroundColor: Colors.teal.shade100,
//                           circularStrokeCap: CircularStrokeCap.round,
//                           center: Text(
//                             "${(progressPercent * 100).toInt()}%",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.teal[800],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 20),
//             Divider(
//               color: AppColors.primary,
//               indent: 100,
//               endIndent: 100,
//               thickness: 2,
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Please complete the form with the accurate details of the missing person',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: AppColors.myBlackColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Missing Child/Person Details:',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: AppColors.primary,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//
//             SizedBox(height: 10),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _key,
//
//                   child: Column(
//                     children: [
//                       _buildTextField(
//                         'Name',
//                         'Enter child name',
//                         cName,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Father\'s Name',
//                         'Enter  Person\'s father\'s name',
//                         cFName,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Gender',
//                         'Enter Missing Person\'s gender',
//                         cGender,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Hair Color',
//                         'Enter Missing Person\'s hair color',
//                         cHairColor,
//                         true,
//                       ),
//
//                       _buildTextField(
//                         'Place',
//                         'Enter place where child was found',
//                         cLocation,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Time',
//                         'Enter the time when child was found',
//                         cTime,
//                         true,
//                       ),
//
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CustomButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             backgroundColor: AppColors.secondary,
//                             foregroundColor: AppColors.primary,
//                             size: 'small',
//                             label: 'Back',
//                             border: true,
//                           ),
//                           CustomButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => FounderDetailsScreen(),
//                                 ),
//                               );
//                             },
//                             backgroundColor: AppColors.primary,
//                             foregroundColor: AppColors.secondary,
//                             size: 'small',
//                             label: 'Next',
//                             border: true,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(
//       String label,
//       String hint,
//       TextEditingController controller,
//       bool isRequired,
//       ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           RichText(
//             text: TextSpan(
//               text: label,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w300,
//               ),
//               children: [
//                 TextSpan(
//                   text: isRequired ? ' *' : '',
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 5),
//           CustomTextFormField(
//             labelText: label,
//             hintText: hint,
//             controller: controller,
//             validator: (value) {
//               if (isRequired && (value?.isEmpty ?? true)) {
//                 return 'This field is required';
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// // 🔻 CustomTextFormField Widget Implementation
// class CustomTextFormField extends StatelessWidget {
//   final String labelText;
//   final String hintText;
//   final TextEditingController controller;
//   final FormFieldValidator<String>? validator;
//
//   const CustomTextFormField({
//     super.key,
//     required this.labelText,
//     required this.hintText,
//     required this.controller,
//     this.validator,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText,
//         hintStyle: const TextStyle(fontSize: 13),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 14,
//         ),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//     );
//   }
// }
