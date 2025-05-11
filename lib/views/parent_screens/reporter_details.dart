import 'package:flutter/material.dart';
import 'package:locat_lost/widgets/custom_elevated_button.dart';
import 'package:locat_lost/views/case_summary.dart';
import 'package:locat_lost/widgets/custom_text_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../utils/app_colors.dart';


class ReporterDetailsScreen extends StatefulWidget {
  const ReporterDetailsScreen({Key? key}) : super(key: key);

  @override
  _ReporterDetailsScreenState createState() => _ReporterDetailsScreenState();
}

class _ReporterDetailsScreenState extends State<ReporterDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'reporterName': TextEditingController(),
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
            'Missing Person',
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
                      'Enter your details\nto continue',
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
              _buildSectionTitle('Reporter Details:'),
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
          'Please complete the form with your accurate details',
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
      _buildTextField('Your name', 'Enter your full name', 'reporterName', true),
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
                builder: (context) => CaseSummaryScreen(),
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
