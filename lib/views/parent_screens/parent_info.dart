import 'package:flutter/material.dart';
import 'package:locat_lost/views/record.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/Widgets/custom_textField.dart';
import 'package:locat_lost/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../Widgets/custom_elevated_button.dart';

class ParentDetailsScreen extends StatefulWidget {
  const ParentDetailsScreen({Key? key}) : super(key: key);

  @override
  _ParentDetailsScreenState createState() => _ParentDetailsScreenState();
}

class _ParentDetailsScreenState extends State<ParentDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'parentName': TextEditingController(),
    'relationship': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'emergencyContact': TextEditingController(),
    'additionalDetails': TextEditingController(),
  };

  double progressPercent = 0.85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildProgressCard(),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
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
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInstructionText(),
              _buildSectionTitle('Parent Details:'),
              ..._buildFormFields(),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionText() {
    return Column(
      children: [
        Text(
          'Please complete the form with the accurate details of the missing person',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.myBlackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField('Parent name', 'Enter Missing Person\'s parent name', 'parentName', true),
      _buildTextField('Relationship with missing person', 'What is your relationship with missing person', 'relationship', true),
      _buildTextField('Phone Number', 'Enter your phone number', 'phoneNumber', true),
      _buildTextField('Emergency Contact', 'Enter emergency contact if phone is off', 'emergencyContact', true),
      _buildTextField('Additional Details', 'Provide any other details', 'additionalDetails', false),
    ];
  }

  Widget _buildTextField(
      String label, String hint, String controllerKey, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
              children: [
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          CustomTextFormField(
            labelText: label,
            hintText: hint,
            controller: _controllers[controllerKey]!,
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

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        CustomElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          height: 45,
          width: 130,
          fontSize: 15,
          borderRadius: 10,
          label: 'Back',
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.primary,
          showBorder: true,
        ),
        CustomElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordScreen(),
              ),
            );
          },
          height: 45,
          width: 130,
          fontSize: 15,
          borderRadius: 10,
          label: 'Next',
        ),

      ],
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:locat_lost/Screens/record.dart';
// import 'package:locat_lost/Widgets/custom_button.dart';
// import 'package:locat_lost/Widgets/custom_textField.dart';
// import 'package:locat_lost/colors.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// class ParentDetailsScreen extends StatefulWidget {
//   const ParentDetailsScreen({super.key});
//
//   @override
//   State<ParentDetailsScreen> createState() => _ParentDetailsScreenState();
// }
//
// class _ParentDetailsScreenState extends State<ParentDetailsScreen> {
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//
//   final TextEditingController cName = TextEditingController();
//   final TextEditingController cFName = TextEditingController();
//   final TextEditingController cCaste = TextEditingController();
//   final TextEditingController cGender = TextEditingController();
//   final TextEditingController cHeight = TextEditingController();
//   final TextEditingController cHairColor = TextEditingController();
//   final TextEditingController cSkinColor = TextEditingController();
//   final TextEditingController cDisability = TextEditingController();
//   final TextEditingController cLastSeenPlace = TextEditingController();
//   final TextEditingController cLastSeenTime = TextEditingController();
//   final TextEditingController cNum = TextEditingController();
//
//   double progressPercent = .85;
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
//               'Parent Details:',
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
//                         'Parent name',
//                         'Enter Missing Person\'s parent name',
//                         cName,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Relationship with missing person',
//                         'What is your relationship with missing person',
//                         cFName,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Phone Number',
//                         'Enter your phone number',
//                         cCaste,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Emergency Contact',
//                         'Enter emergency contact in case first one is off.',
//                         cGender,
//                         true,
//                       ),
//                       _buildTextField(
//                         'Any other details',
//                         'If you want to provide any other details related to you are the missing person.',
//                         cHeight,
//                         true,
//                       ),
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
//                                   builder: (context) => RecordScreen(),
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
//     String label,
//     String hint,
//     TextEditingController controller,
//     bool isRequired,
//   ) {
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
// //  CustomTextFormField Widget Implementation
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
